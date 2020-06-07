import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.14
import controls 1.0
import ".." 1.0

PageBase {

    function closeAllPopups() {
        installCertificatePopup.close();
        installAnotherCertificatePopup.close();
        errorPopup.close();
    }

    Item {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 90

        // Used for any kind of error (except SSL handshake)
        ErrorMessagePopup {
            id: errorPopup

            anchors.centerIn: parent
        }

        // Used for letting the user know that CA certificate
        // might be needed. Will be suppressed after rejecting
        YesNoPopup {
            id: installCertificatePopup

            anchors.centerIn: parent
            message: qsTr("You might need a CA certificate for this connection. Want to <u>install</u> it?")
            onYes: certificateSelector.open()
            onNo: installCertificatePopup.enabled = false
        }

        // ToDo: consider merging installCertificatePopup into
        // a more generic popup covering both cases of SSL
        // certificates installation... Perhaps, use states.
        //
        // Used for pursuing the user with a request to install
        // CA certificate. Cannot be suppressed after rejecting
        YesNoPopup {
            id: installAnotherCertificatePopup

            anchors.centerIn: parent
            message: qsTr("It seems that your CA certificate is invalid. Want to <u>install</u> another?")
            onYes: certificateSelector.open()
        }

    }

    ColumnLayout {
        anchors.centerIn: parent

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Which Jira server would you like to use today?")
            font.pixelSize: 36
        }

        TextField {
            id: serverUrl

            Layout.minimumWidth: 300
            Layout.preferredWidth: serverUrl.contentWidth
            Layout.maximumWidth: 500
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Text.AlignHCenter
            placeholderText: "http://"
            text: JiraProxy.instance.server
            enabled: !JiraProxy.validating
            font.pixelSize: 26
            color: Material.color(Material.Amber, Material.Shade300)
            onAccepted: JiraProxy.setupAndValidateServer(text)
            onTextEdited: if (text.startsWith("https") && installCertificatePopup.enabled && !installCertificatePopup.opened) {
                installCertificatePopup.open();
            } else if (text.startsWith("http:")) {
                closeAllPopups();
            }
            validator: RegExpValidator {
                regExp: RegExp("^(http|https)://.*")
            }

        }

        RoundButton {
            Layout.preferredWidth: 54
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("\u2713")
            enabled: !JiraProxy.validating
            font.pixelSize: 24
            onReleased: if (serverUrl.acceptableInput) {
                JiraProxy.setupAndValidateServer(serverUrl.text);
            } else {
                errorPopup.errorText = qsTr("Invalid URL")
                errorPopup.open();
            }

            BusyIndicator {
                anchors.centerIn: parent
                running: JiraProxy.validating
            }

        }

    }

    FileDialog {
        id: certificateSelector

        nameFilters: ["*.crt"]
        onAccepted: {
            JiraProxy.instance.caCertificateFile = certificateSelector.fileUrl;
            // there was already an attempt to connect, so
            // let's verify CA certificate and server again
            if (JiraProxy.sslError)
                JiraProxy.setupAndValidateServer(serverUrl.text);

        }
    }

    states: [
        State {
            name: "Validation Process Running"
            when: JiraProxy.validating
            StateChangeScript {
                script: closeAllPopups()
            }
        },
        State {
            name: "Jira server is Valid"
            when: JiraProxy.valid
            StateChangeScript {
                script: MenuStateMachine.nextPage()
            }
        },
        State {
            name: "Any error except SSL handshake error"
            when: JiraProxy.serverError || (JiraProxy.networkError && !JiraProxy.sslError)
            StateChangeScript {
                script: {
                    errorPopup.errorText = JiraProxy.lastErrorText;
                    errorPopup.open();
                }
            }
        },
        State {
            name: "SSL handshake error"
            when: JiraProxy.sslError
            StateChangeScript {
                script: {
                    var certPopup = (JiraProxy.instance.caCertificateFile == "") ? installCertificatePopup : installAnotherCertificatePopup;
                    certPopup.enabled = true;
                    certPopup.open();
                }
            }
        }

    ]

}

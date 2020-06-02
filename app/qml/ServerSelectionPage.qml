import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.14

Page {

    function closeAllPopups() {
        installCertificatePopup.close();
        installAnotherCertificatePopup.close();
        errorPopup.close();
    }

    Item {
        height: 90

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

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
        // certificates installation... Perhaps, use states
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
            onTextEdited: {
                if (text.startsWith("https") && installCertificatePopup.enabled && !installCertificatePopup.opened)
                    installCertificatePopup.open();
                else if (text.startsWith("http:"))
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
            onReleased: JiraProxy.setupAndValidateServer(serverUrl.text)

            BusyIndicator {
                anchors.centerIn: parent
                running: JiraProxy.validating
            }

        }

    }

    FileDialog {
        id: certificateSelector

        nameFilters: ["*.crt"]
        onAccepted: function() {
            JiraProxy.instance.caCertificateFile = certificateSelector.fileUrl;
            // there was already an attempt to connect, so
            // let's verify CA certificate and server again
            if (JiraProxy.sslError)
                JiraProxy.setupAndValidateServer(serverUrl.text);

        }
    }

    Connections {
        target: JiraProxy
        onValidatingChanged: function() {
            if (JiraProxy.validating || JiraProxy.valid) {
                closeAllPopups();
            } else if (JiraProxy.serverError || !JiraProxy.sslError) {
                errorPopup.errorText = JiraProxy.lastErrorText;
                errorPopup.open();
            } else if (JiraProxy.sslError) {
                var certPopup = (JiraProxy.instance.caCertificateFile == "") ? installCertificatePopup : installAnotherCertificatePopup;
                certPopup.enabled = true;
                certPopup.open();
            } else {
                console.warn("Unknown use case?");
            }
        }
    }

}

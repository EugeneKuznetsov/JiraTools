import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.14

Page {
    Item {
        height: 90

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        ErrorMessagePopup {
            id: errorPopup

            anchors.centerIn: parent
        }

        YesNoPopup {
            id: installCertificatePopup

            anchors.centerIn: parent
            message: qsTr("You might need a CA certificate for this connection. Want to <u>install</u> it?")
            onYes: function () {
                close();
                certificateSelector.open();
            }
            onNo: enabled = false
        }

        YesNoPopup {
            id: installAnotherCertificatePopup

            anchors.centerIn: parent
            message: qsTr("It seems that your CA certificate is invalid. Want to <u>install</u> another?")
            onYes: function () {
                close();
                certificateSelector.open();
            }
        }

    }

    ColumnLayout {
        anchors.centerIn: parent

        Label {
            text: qsTr("Which Jira server would you like to use today?")
            font.pixelSize: 36
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: serverUrl

            placeholderText: "http://"
            text: JiraProxy.instance.server == "" ? "http://" : JiraProxy.instance.server
            font.pixelSize: 26
            color: Material.color(Material.Amber, Material.Shade300)
            horizontalAlignment: Text.AlignHCenter
            Layout.minimumWidth: 300
            Layout.preferredWidth: serverUrl.contentWidth
            Layout.maximumWidth: 500
            Layout.alignment: Qt.AlignHCenter
            onAccepted: JiraProxy.setupAndValidateServer(text)
            onTextEdited: if (text.startsWith("https") && installCertificatePopup.enabled && !installCertificatePopup.opened) {
                installCertificatePopup.open();
            }

            validator: RegExpValidator {
                regExp: RegExp("^(http|https)://.*")
            }

        }

        RoundButton {
            text: qsTr("\u2713")
            font.pixelSize: 24
            Layout.preferredWidth: 54
            Layout.alignment: Qt.AlignHCenter
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
        onAccepted: function () {
            JiraProxy.instance.caCertificateFile = certificateSelector.fileUrl;
            // there was already an attempt to connect, so
            // let's verify CA certificate and server again
            if (JiraProxy.sslError)
                JiraProxy.setupAndValidateServer(serverUrl.text);
        }
    }

    Connections {
        target: JiraProxy
        onValidatingChanged: if (JiraProxy.validating || JiraProxy.valid) {
            errorPopup.close();
            installCertificatePopup.close();
            installAnotherCertificatePopup.close();
        } else if (JiraProxy.serverError || !JiraProxy.sslError) {
            errorPopup.errorText = JiraProxy.lastErrorText;
            errorPopup.open();
        } else if (JiraProxy.sslError) {
            var certPopup = (JiraProxy.instance.caCertificateFile == "") ? installCertificatePopup
                                                                         : installAnotherCertificatePopup;
            certPopup.enabled = true;
            certPopup.open();
        } else {
            console.warn("Unknown use case");
        }
    }

}

import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
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
            id: networkErrorPopup

            anchors.centerIn: parent
        }

        YesNoPopup {
            id: installCertificatePopup

            anchors.centerIn: parent
            message: qsTr("You might need a CA certificate for this connection. Want to <u>install</u> it?")
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
            text: placeholderText // jira.server
            font.pixelSize: 26
            color: Material.color(Material.Amber, Material.Shade300)
            horizontalAlignment: Text.AlignHCenter
            Layout.minimumWidth: 300
            Layout.preferredWidth: serverUrl.contentWidth
            Layout.maximumWidth: 500
            Layout.alignment: Qt.AlignHCenter

            validator: RegExpValidator {
                regExp: RegExp("^(http|https)://.*")
            }

        }

        RoundButton {
            text: qsTr("✓")
            font.pixelSize: 24
            Layout.preferredWidth: 54
            Layout.alignment: Qt.AlignHCenter

            BusyIndicator {
                anchors.centerIn: parent
            }

        }

    }

}

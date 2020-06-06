import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

Pane {
    padding: 0
    Material.background: Material.color(Material.Grey, Material.Shade800)

    ColumnLayout {
        anchors.fill: parent

        AvatarImage {
            id: currentUserAvatar

            Layout.topMargin: 13
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: 52
            Layout.preferredHeight: 52
        }

        Item {
            Layout.fillHeight: true
        }

    }

    Connections {
        target: JiraProxy
        onAuthenticatedChanged: if (JiraProxy.authenticated) {
            JiraProxy.instance.mySelf(function(status, self) {
                if (status.success)
                    currentUserAvatar.source = self["avatarUrls"]["48x48"];
                else
                    console.warn(status.errors);
            }).getUser();
        }
    }
}

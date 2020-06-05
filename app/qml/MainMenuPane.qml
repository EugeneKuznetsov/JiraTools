import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

Pane {
    Material.background: Material.color(Material.Grey, Material.Shade800)
    padding: 0

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            Layout.topMargin: 10
            Layout.alignment: Qt.AlignCenter
            width: 48
            height: 48
            radius: width / 2
            color: Material.color(Material.Grey)

            Image {
                id: currentUserAvatar

                anchors.centerIn: parent
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    Connections {
        target: JiraProxy
        onValidChanged: if (JiraProxy.authenticated) {
            JiraProxy.instance.mySelf(function(status, self) {
                if (status.success)
                    console.log(JSON.stringify(self));
                else
                    console.warn(status.errors);
            }).getUser();
        }
    }
}

import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

Pane {
    property url userAvatarSource: ""

    padding: 0
    Material.elevation: 3
    Material.background: Material.color(Material.Grey, Material.Shade800)

    ColumnLayout {
        anchors.fill: parent

        AvatarImage {
            id: currentUserAvatar

            Layout.topMargin: 13
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: 52
            Layout.preferredHeight: 52
            source: userAvatarSource
        }

        Item {
            Layout.fillHeight: true
        }

    }

}

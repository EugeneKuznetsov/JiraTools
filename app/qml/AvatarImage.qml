import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtGraphicalEffects 1.14

Rectangle {
    property url source: Qt.resolvedUrl("../assets/default_avatar.svg")

    implicitWidth: 52
    implicitHeight: 52
    radius: width / 2
    color: Material.color(Material.Grey)
    border {
        width: 2
        color: Material.accentColor
    }

    Image {
        id: currentUserAvatar

        anchors.centerIn: parent
        width: avatarRoundingMask.width
        height: avatarRoundingMask.height
        source: parent.source
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: avatarRoundingMask
        }

    }

    BusyIndicator {
        anchors.centerIn: parent
        running: currentUserAvatar.status === Image.Loading
    }

    Rectangle {
        id: avatarRoundingMask

        visible: false
        width: parent.implicitWidth - 4
        height: parent.implicitHeight - 4
        radius: avatarRoundingMask.width / 2
    }

}

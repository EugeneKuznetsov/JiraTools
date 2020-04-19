import QtQuick 2.14
import QtQuick.Controls 2.14
import bricks 1.0 as Bricks

Button {
    Keys.onReturnPressed: clicked()

    contentItem: Bricks.Label {
        color: "#ffffff"
        text: parent.text
    }

    background: Rectangle {
        color: parent.enabled ? ((parent.activeFocus || parent.hovered) ? "#4585ed" : "#1a68e8") : "#696a6b"
        radius: 3

        border {
            color: parent.activeFocus ? "#2e65bf" : "#cfcfcf"
            width: parent.activeFocus ? 3 : 0
        }

    }

}

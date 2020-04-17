import QtQuick 2.14

import bricks 1.0 as Bricks

Item {
    id: root

    Rectangle {
        id: formBorder

        anchors.centerIn: parent
        border {
            width: 1
            color: "#cfcfcf"
        }
        radius: 5
        width: 600
        height: 300

        Bricks.Label {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 20
                bottomMargin: 20
            }
            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            text: "Welcome to Jira Tools!"
        }
    }
}

import QtQuick 2.14
import QtQuick.Controls 2.14

import bricks 1.0 as Bricks

CheckBox {
    id: root

    implicitWidth: indicator.implicitWidth + contentItem.implicitWidth + 5
    indicator: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 18
        implicitHeight: 18
        border {
            color: parent.activeFocus ? "#3b86ff" : "#cfcfcf"
            width: 2
        }
        color: parent.activeFocus ? "#ffffff" : (parent.hovered ? "#efefef" : "#fbfbfb")
        radius: 3

        Rectangle {
            anchors {
                fill: parent
                margins: 5
            }
            visible: root.checked
            color: "#aeaa9a"
        }
    }
    contentItem: Bricks.Label {
        anchors {
            verticalCenter: parent.indicator.verticalCenter
            left: parent.indicator.right
            leftMargin: 5
        }
        text: parent.text
    }
}

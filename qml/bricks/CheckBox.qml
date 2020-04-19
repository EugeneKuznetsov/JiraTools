import QtQuick 2.14
import QtQuick.Controls 2.14 as Controls
import bricks 1.0 as Bricks

Controls.CheckBox {
    id: root

    implicitWidth: indicator.implicitWidth + contentItem.implicitWidth + 5

    indicator: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 18
        implicitHeight: 18
        color: parent.activeFocus ? "#ffffff" : (parent.hovered ? "#efefef" : "#fbfbfb")
        radius: 3

        border {
            color: parent.activeFocus ? "#3b86ff" : "#cfcfcf"
            width: 2
        }

        Rectangle {
            visible: root.checked
            color: "#aeaa9a"

            anchors {
                fill: parent
                margins: 5
            }

        }

    }

    contentItem: Bricks.Label {
        verticalAlignment: Text.AlignVCenter
        text: parent.text

        anchors {
            left: parent.indicator.right
            leftMargin: 5
        }

    }

}

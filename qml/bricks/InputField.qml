import QtQuick 2.14
import QtQuick.Controls 2.14

TextField {
    signal confirm()

    implicitHeight: 34
    Keys.onReturnPressed: confirm()

    font {
        family: "Verdana"
        pointSize: 9
        letterSpacing: 0.6
    }

    background: Rectangle {
        color: parent.activeFocus ? "#ffffff" : (parent.hovered ? "#efefef" : "#fbfbfb")
        radius: 3

        border {
            color: parent.activeFocus ? "#3b86ff" : "#cfcfcf"
            width: 2
        }

    }

}

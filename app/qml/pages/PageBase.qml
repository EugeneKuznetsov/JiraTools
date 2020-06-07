import QtQuick 2.14
import QtQuick.Controls 2.14
import ".." 1.0

Page {
    property bool backButton: false

    RoundButton {
        anchors {
            margins: 5
            top: parent.top
            right: parent.right
        }
        width: 48
        text: qsTr("\u2190")
        font.pixelSize: 20
        visible: backButton
        onReleased: MenuStateMachine.prevPage()
    }

}

import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    signal nextPage()
    signal prevPage()

    property bool backButton: false

    RoundButton {
        anchors {
            margins: 15
            top: parent.top
            right: parent.right
        }
        implicitWidth: 54
        text: qsTr("\u2b8c")
        font.pixelSize: 22
        visible: backButton
        onReleased: prevPage()
    }
}

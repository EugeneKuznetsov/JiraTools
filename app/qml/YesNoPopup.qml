import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Popup {
    property string message: ""

    signal yes()
    signal no()

    topPadding: 2
    bottomPadding: 2
    closePolicy: Popup.NoAutoClose

    RowLayout {
        anchors.fill: parent
        spacing: 8

        Label {
            text: message
            elide: Text.ElideRight
            font.pixelSize: 18
            verticalAlignment: Text.AlignVCenter
            Layout.preferredHeight: 39
            Layout.preferredWidth: 570
        }

        Button {
            text: qsTr("\u2713 Yes")
            font.pixelSize: 18
            Layout.preferredHeight: 39
            Layout.minimumWidth: 75
            Layout.alignment: Qt.AlignVCenter
            onReleased: yes()
        }

        Button {
            text: qsTr("\u2717 No")
            font.pixelSize: 18
            Layout.preferredHeight: 39
            Layout.minimumWidth: 75
            Layout.alignment: Qt.AlignVCenter
            onReleased: {
                no();
                close();
            }
        }

    }

}

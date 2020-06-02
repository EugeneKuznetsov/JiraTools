import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

Popup {
    property string errorText: ""

    signal ok()

    topPadding: 2
    bottomPadding: 2

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Label {
            Layout.preferredWidth: 672
            Layout.preferredHeight: 39
            verticalAlignment: Text.AlignVCenter
            text: errorText
            elide: Text.ElideRight
            font.bold: true
            font.pixelSize: 18
            color: Material.color(Material.Red, Material.Shade400)
        }

        Button {
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: 39
            text: qsTr("OK")
            font.pixelSize: 18
            onReleased: {
                ok();
                close();
            }
        }

    }

}

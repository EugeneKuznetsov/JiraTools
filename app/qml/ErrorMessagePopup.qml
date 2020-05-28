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
            text: errorText
            elide: Text.ElideRight
            font.bold: true
            font.pixelSize: 18
            color: Material.color(Material.Red, Material.Shade400)
            verticalAlignment: Text.AlignVCenter
            Layout.preferredWidth: 672
            Layout.preferredHeight: 39
        }

        Button {
            text: qsTr("OK")
            font.pixelSize: 18
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: 39
            onReleased: {
                ok();
                close();
            }
        }

    }

}

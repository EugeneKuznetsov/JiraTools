import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.14
import ".." 1.0

Item {
    readonly property bool isCurrentItem: GridView.isCurrentItem
    readonly property bool isHovered: hoverArea.containsMouse

    width: GridView.view.cellWidth
    height: GridView.view.cellHeight

    Pane {
        padding: 1
        anchors.fill: parent
        anchors.margins: 10
        Material.elevation: isCurrentItem ? 15 : 3
        Material.background: Material.color(Material.Grey, Material.Shade800)

        ColumnLayout {
            anchors.fill: parent

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: 15

                Image {
                    id: defaultToolImage

                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    visible: false
                    source: Qt.resolvedUrl("../../assets/default_tool_entry.svg")
                }

                ColorOverlay {
                    anchors.fill: defaultToolImage
                    source: defaultToolImage
                    color: isCurrentItem ? Material.accentColor : Material.foreground
                }

            }

            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: 25
                Layout.rightMargin: 25
                height: 1
                color: isCurrentItem ? Material.accentColor : Material.foreground
            }

            Label {
                Layout.bottomMargin: 10
                Layout.alignment: Qt.AlignHCenter
                text: model.name
                font {
                    bold: true
                    pixelSize: 16
                }
                color: isCurrentItem ? Material.accentColor : Material.foreground
                wrapMode: Text.WordWrap
            }

        }

        Rectangle {
            anchors.fill: parent
            visible: isCurrentItem || isHovered
            color: "transparent"
            radius: 2
            border {
                width: 1
                color: isHovered ? Material.primaryTextColor : Material.listHighlightColor
            }

        }

    }

    MouseArea {
        id: hoverArea

        anchors.fill: parent
        hoverEnabled: true
        onClicked: if (model.pageId.length) {
            MenuStateMachine.activatePage(model.pageId);
        } else {
            console.warn("%1 not implemented".arg(model.name));
        }
    }

    Keys.onPressed: if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
        if (!model.pageId.length) {
            console.warn("%1 not implemented".arg(model.name));
        }
        MenuStateMachine.activatePage(model.pageId);
    }

}

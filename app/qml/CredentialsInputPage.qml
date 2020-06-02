import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

PageBase {
    backButton: true

    Item {
        height: 90

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        ErrorMessagePopup {
            id: errorPopup

            anchors.centerIn: parent
        }

    }

    ColumnLayout {
        id: mainLayout

        anchors.centerIn: parent
        spacing: 30

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("How would you like to authenticate?")
            font.pixelSize: 36
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            spacing: 50

            Item {
                Layout.preferredWidth: 200

                Button {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Go anonymous"
                    font.pixelSize: 16
                }

            }

            Rectangle {
                Layout.fillHeight: true
                width: 1
                color: Material.accentColor
            }

            ColumnLayout {
                Layout.maximumWidth: 200
                spacing: 5

                TextField {
                    Layout.fillWidth: true
                    placeholderText: qsTr("Username")
                    font.pixelSize: 18
                    color: Material.color(Material.Amber, Material.Shade300)
                }

                TextField {
                    Layout.fillWidth: true
                    placeholderText: qsTr("Password")
                    font.pixelSize: 18
                    echoMode: TextInput.Password
                    color: Material.color(Material.Amber, Material.Shade300)
                }

                RowLayout {
                    Button {
                        text: qsTr("Login")
                        font.pixelSize: 16
                    }

                    CheckBox {
                        text: qsTr("Remember me")
                        font.pixelSize: 16
                    }

                }

            }

        }

    }

    BusyIndicator {
        anchors {
            top: mainLayout.bottom
            topMargin: 30
            horizontalCenter: mainLayout.horizontalCenter
        }

    }

    Pane {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Material.elevation: 10

        Label {
            anchors.centerIn: parent
            text: JiraProxy.serverPrettyTitle
            font.underline: true
        }

    }

}

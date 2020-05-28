import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

Page {
    Item {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: 10
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            Pane {
                topPadding: 2
                bottomPadding: 2
                //visible: serverUrl.text.startsWith("https")
                Material.elevation: 3
                Material.background: Material.color(Material.Grey, Material.Shade800)

                RowLayout {
                    anchors.fill: parent
                    spacing: 8

                    Label {
                        text: qsTr("You might need a CA certificate for this connection. Want to <u>install</u> it?")
                        elide: Text.ElideRight
                        font.pixelSize: 18
                        verticalAlignment: Text.AlignVCenter
                        Layout.preferredHeight: 39
                        Layout.preferredWidth: 570
                    }

                    Button {
                        text: qsTr("✓ Yes")
                        font.pixelSize: 18
                        Layout.preferredHeight: 39
                        Layout.minimumWidth: 75
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Button {
                        text: qsTr("🗙 No")
                        font.pixelSize: 18
                        Layout.preferredHeight: 39
                        Layout.minimumWidth: 75
                        Layout.alignment: Qt.AlignVCenter
                    }

                }

            }

            Pane {
                topPadding: 2
                bottomPadding: 2
                Material.elevation: 3
                Material.background: Material.color(Material.Grey, Material.Shade800)

                RowLayout {
                    anchors.fill: parent
                    spacing: 0

                    Label {
                        id: errorText

                        text: qsTr("Connection error") // jira.error
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
                    }

                }

            }

        }

    }

    ColumnLayout {
        anchors {
            centerIn: parent
            left: parent.left
            right: parent.right
        }

        Label {
            text: qsTr("Which Jira server would you like to use today?")
            font.pixelSize: 36
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: serverUrl

            placeholderText: "http://"
            text: placeholderText // jira.server
            font.pixelSize: 26
            color: Material.color(Material.Amber, Material.Shade300)
            horizontalAlignment: Text.AlignHCenter
            Layout.minimumWidth: 300
            Layout.preferredWidth: serverUrl.contentWidth
            Layout.maximumWidth: 500
            Layout.alignment: Qt.AlignHCenter

            validator: RegExpValidator {
                regExp: RegExp("^(http|https)://.*")
            }

        }

        RoundButton {
            id: connectButton

            text: qsTr("✓")
            font.pixelSize: 24
            Layout.preferredWidth: 54
            Layout.alignment: Qt.AlignHCenter

            BusyIndicator {
                anchors.centerIn: parent
            }

        }

    }

}

import QtQuick 2.14
import QtQuick.Layouts 1.14

import bricks 1.0 as Bricks

Item {
    id: root

    Rectangle {
        id: formBorder

        anchors.centerIn: parent
        border {
            width: 1
            color: "#cfcfcf"
        }
        radius: 5
        width: 600
        height: 300

        Bricks.Label {
            id: welcomeLabel

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 20
                bottomMargin: 20
            }
            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("Welcome to Jira Tools!")
        }
        GridLayout {
            id: controlsGridLayout

            anchors {
                top: welcomeLabel.bottom
                topMargin: 35
                left: parent.left
                right: parent.right
            }
            columns: 2
            columnSpacing: 15
            rowSpacing: 10

            Bricks.Label {
                text: qsTr("Server")
                horizontalAlignment: Text.AlignRight

                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 125
            }
            Bricks.InputField {
                Layout.preferredWidth: 250
            }
            Bricks.Label {
                text: qsTr("Username")
                horizontalAlignment: Text.AlignRight

                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 125
            }
            Bricks.InputField {
                Layout.preferredWidth: 150
            }
            Bricks.Label {
                text: qsTr("Password")
                horizontalAlignment: Text.AlignRight

                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 125
            }
            Bricks.InputField {
                echoMode: TextInput.Password

                Layout.preferredWidth: 150
            }
            Bricks.CheckBox {
                text: "Remember credentials"

                Layout.row: 3
                Layout.column: 1
            }
            Bricks.ActionButton {
                text: "Login"

                Layout.row: 4
                Layout.column: 1
            }
        }
    }
}

import QtQuick 2.14
import QtQuick.Layouts 1.14
import bricks 1.0 as Bricks

Item {
    readonly property alias server: serverInputField.text
    readonly property alias username: usernameInputField.text
    readonly property alias password: passwordInputField.text
    readonly property alias remember: rememberCredentialsCheckBox.checked
    property alias error: errorMessageLabel.text
    property bool blockLogin: false

    signal login()

    Rectangle {
        anchors.centerIn: parent
        radius: 5
        width: 600
        height: 300 + (errorMessageRectangle.visible ? errorMessageRectangle.implicitHeight + 15 : 0)

        border {
            width: 1
            color: "#cfcfcf"
        }

        Bricks.Label {
            id: welcomeLabel

            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("Welcome to Jira Tools!")

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 20
            }

        }

        Rectangle {
            id: errorMessageRectangle

            radius: 3
            color: "#f7bfbf"
            visible: errorMessageLabel.text.length > 0
            implicitHeight: errorMessageLabel.implicitHeight + 10

            anchors {
                top: welcomeLabel.bottom
                left: parent.left
                right: parent.right
                leftMargin: 25
                rightMargin: 25
                topMargin: 15
            }

            border {
                width: 1
                color: "#efefef"
            }

            Bricks.Label {
                id: errorMessageLabel

                anchors.centerIn: parent
                padding: 10
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.bold: true
                wrapMode: Text.WordWrap
            }

        }

        GridLayout {
            id: controlsGridLayout

            columns: 2
            columnSpacing: 15
            rowSpacing: 10

            anchors {
                top: errorMessageRectangle.visible ? errorMessageRectangle.bottom : welcomeLabel.bottom
                topMargin: 35
                left: parent.left
                right: parent.right
            }

            Bricks.Label {
                text: qsTr("Server")
                horizontalAlignment: Text.AlignRight
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 125
            }

            Bricks.InputField {
                id: serverInputField

                Layout.preferredWidth: 250
            }

            Bricks.Label {
                text: qsTr("Username")
                horizontalAlignment: Text.AlignRight
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 125
            }

            Bricks.InputField {
                id: usernameInputField

                Layout.preferredWidth: 150
            }

            Bricks.Label {
                text: qsTr("Password")
                horizontalAlignment: Text.AlignRight
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 125
            }

            Bricks.InputField {
                id: passwordInputField

                echoMode: TextInput.Password
                Layout.preferredWidth: 150
                onConfirm: login()
            }

            Bricks.CheckBox {
                id: rememberCredentialsCheckBox

                text: "Remember credentials"
                Layout.row: 3
                Layout.column: 1
            }

            Bricks.ActionButton {
                text: "Login"
                enabled: !blockLogin
                Layout.row: 4
                Layout.column: 1
                onClicked: login()
            }

        }

    }

}

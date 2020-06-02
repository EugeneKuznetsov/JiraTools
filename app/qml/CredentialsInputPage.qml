import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

PageBase {
    backButton: true

    Item {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 90

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
                    enabled: !JiraProxy.authenticating
                    onReleased: nextPage()
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
                    id: username

                    Layout.fillWidth: true
                    placeholderText: qsTr("Username")
                    font.pixelSize: 18
                    color: Material.color(Material.Amber, Material.Shade300)
                    enabled: !JiraProxy.authenticating
                    onAccepted: password.forceActiveFocus()
                }

                TextField {
                    id: password

                    Layout.fillWidth: true
                    placeholderText: qsTr("Password")
                    font.pixelSize: 18
                    echoMode: TextInput.Password
                    color: Material.color(Material.Amber, Material.Shade300)
                    enabled: !JiraProxy.authenticating
                    onAccepted: JiraProxy.authenticate(username.text, password.text)
                }

                RowLayout {
                    Button {
                        text: qsTr("Login")
                        font.pixelSize: 16
                        enabled: !JiraProxy.authenticating
                        onReleased: JiraProxy.authenticate(username.text, password.text)
                    }

                    CheckBox {
                        text: qsTr("Remember me")
                        font.pixelSize: 16
                        enabled: !JiraProxy.authenticating
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
        running: JiraProxy.authenticating

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

    Connections {
        target: JiraProxy
        onAuthenticatingChanged: {
            if (JiraProxy.authenticating) {
                errorPopup.close();
            } else if (JiraProxy.authenticated) {
                nextPage();
            } else if (JiraProxy.serverError || JiraProxy.networkError) {
                errorPopup.errorText = JiraProxy.lastErrorText;
                errorPopup.open();
            } else {
                console.warn("Unknown use case?");
            }
        }
    }

}

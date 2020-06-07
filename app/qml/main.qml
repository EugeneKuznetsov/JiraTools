import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import controls 1.0

ApplicationWindow {
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    title: qsTr("Jira Tools - ") + (JiraProxy.valid ? JiraProxy.serverPrettyTitle : qsTr("No server selected"))

    RowLayout {
        anchors.fill: parent

        MainMenuPane {
            id: mainMenu

            Layout.preferredWidth: 66
            Layout.fillHeight: true
            visible: false

        }

        StackView {
            id: mainView

            Layout.fillWidth: true
            Layout.fillHeight: true

        }

    }

    Connections {
        target: JiraProxy
        onAuthenticatedChanged: if (JiraProxy.authenticated) {
            JiraProxy.instance.mySelf(function(status, self) {
                if (status.success)
                    mainMenu.userAvatarSource = self["avatarUrls"]["48x48"];
            }).getUser();
        }
    }

    Component.onCompleted: {
        MenuStateMachine.mainView = mainView;
        MenuStateMachine.mainMenu = mainMenu;
    }
}

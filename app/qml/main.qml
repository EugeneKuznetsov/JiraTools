import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

ApplicationWindow {
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    title: qsTr("Jira Tools - ") + (JiraProxy.valid ? JiraProxy.serverPrettyTitle : qsTr("No server selected"))

    RowLayout {
        anchors.fill: parent

        Pane {
            id: mainMenu

            Layout.preferredWidth: 60
            Layout.fillHeight: true
            visible: false
            Material.background: Material.color(Material.Grey, Material.Shade800)
        }

        StackView {
            id: mainView

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Component.onCompleted: {
        MenuStateMachine.mainView = mainView;
        MenuStateMachine.mainMenu = mainMenu;
    }
}

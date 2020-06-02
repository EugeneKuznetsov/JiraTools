import QtQuick 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    title: qsTr("Jira Tools - ") + (JiraProxy.valid ? JiraProxy.serverPrettyTitle : qsTr("No server selected"))

    StackView {
        id: mainView

        anchors.fill: parent
    }

    Component.onCompleted: MenuStateMachine.mainView = mainView
}

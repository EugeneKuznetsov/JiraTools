import QtQuick 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    title: JiraProxy.serverVersion != "" ? (qsTr("Jira ") + JiraProxy.serverType
                                            + " (" + JiraProxy.serverVersion + ") - "
                                            + JiraProxy.serverTitle )
                                         : qsTr("Jira Tools")

    StackView {
        anchors.fill: parent
        initialItem: Qt.resolvedUrl("ServerSelectionPage.qml")
    }
}

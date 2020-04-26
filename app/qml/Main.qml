import Jira 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Window 2.14
import forms 1.0 as Forms

Window {
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    color: "#f7f7f7"

    Loader {
        anchors.fill: parent
        source: Qt.resolvedUrl("views/LoginView.qml")
        onLoaded: item.jira = jira
    }

    Jira {
        id: jira
    }

}

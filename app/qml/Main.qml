import Jira 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Window 2.14
import forms 1.0 as Forms
import utils 1.0 as Utils

Window {
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    color: "#f7f7f7"

    Loader {
        id: viewsLoader

        anchors.fill: parent
        source: Qt.resolvedUrl(Utils.Urls.getViewUrl("login"))
        onLoaded: item.jira = jira

        Connections {
            target: viewsLoader.item
            enabled: viewsLoader.status === Loader.Ready
            onChangeViewTo: viewsLoader.source = Utils.Urls.getViewUrl(viewName)
        }

    }

    Jira {
        id: jira
    }

}

import QtQuick 2.14
import QtQuick.Layouts 1.14
import bricks 1.0 as Bricks
import forms 1.0 as Forms
import utils 1.0 as Utils

Bricks.View {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Bricks.TopMenu {
            jira: root.jira
            Layout.fillWidth: true
        }

        Loader {
            id: subViewLoader

            Layout.fillWidth: true
            Layout.fillHeight: true
            active: root.ready
            source: Qt.resolvedUrl(Utils.Urls.getSubViewUrl("dashboard"))
            onLoaded: item.jira = root.jira

            Connections {
                target: subViewLoader.item
                enabled: subViewLoader.status === Loader.Ready
                onChangeSubViewTo: subViewLoader.source = Utils.Urls.getSubViewUrl(viewName)
            }

        }

    }

    Connections {
        target: jira
        onNetworkErrorDetails: {
            // To-Do:
            // Disable everything for a while, show error popup
            console.warn(errorString);
        }
    }

}

import QtQuick 2.14
import QtQuick.Layouts 1.14
import bricks 1.0 as Bricks
import forms 1.0 as Forms

Bricks.View {
    id: root

    ColumnLayout {
        anchors.fill: parent

        Bricks.TopMenu {
            jira: root.jira
            Layout.fillWidth: true
        }

        Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
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

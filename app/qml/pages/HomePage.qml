import QtQuick 2.14
import QtQuick.Layouts 1.14
import controls 1.0
import ".." 1.0

PageBase {
    ColumnLayout {
        anchors.fill: parent

        GridView {
            Layout.alignment: Qt.AlignCenter
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            cellWidth: 235
            cellHeight: 180
            focus: true
            model: toolsModel
            delegate: ToolEntryDelegate { }
        }

    }

    ListModel {
        id: toolsModel

        Component.onCompleted: {
            [
                [qsTr("Agile Board"), "BoardSelection", JiraProxy.agileFeatures],
                [qsTr("Reports"), "", !JiraProxy.anonymous],
                [qsTr("Issue Viewer"), "", true],
                [qsTr("Search Issues"), "", true]
            ].forEach(function(element) {
                if (element[2]) {
                    append({name: element[0], pageId: element[1], available: element[2]});
                }
            });
        }

    }

}

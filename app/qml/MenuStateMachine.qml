pragma Singleton

import QtScxml 5.14
import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    property Pane mainMenu: null
    property StackView mainView: null
    property StateMachine instance: scxmlLoader.stateMachine

    StateMachineLoader {
        id: scxmlLoader
        source: Qt.resolvedUrl("../menustatemachine.scxml")
    }

    EventConnection {
        stateMachine: instance
        events: ["replace", "push", "pop"]
        onOccurred: if (event.name === "replace") {
            mainView.replace(event.data.page);
        } else if (event.name === "push") {
            mainView.push(event.data.page);
        } else if (event.name === "pop") {
            mainView.pop();
        }
    }

    EventConnection {
        stateMachine: instance
        events: ["showMenu", "hideMenu"]
        onOccurred: if (event.name === "showMenu") {
            mainMenu.visible = true;
        } else if (event.name === "hideMenu") {
            mainMenu.visible = false;
        }
    }

    Connections {
        target: mainView && mainView.currentItem ? mainView.currentItem : null
        onNextPage: instance.submitEvent("nextPage")
        onPrevPage: instance.submitEvent("prevPage")
    }
}

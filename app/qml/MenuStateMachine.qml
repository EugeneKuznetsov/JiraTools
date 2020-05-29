import QtQml.StateMachine 1.14 as DSM
import QtQuick 2.14
import QtQuick.Controls 2.14
pragma Singleton

QtObject {
    property StackView mainView: null
    readonly property DSM.StateMachine
    instance: DSM.StateMachine {
        running: mainView
        initialState: welcomePage

        DSM.State {
            id: welcomePage

            onEntered: mainView.push(Qt.resolvedUrl("WelcomePage.qml"))

            DSM.TimeoutTransition {
                targetState: serverSetup
                timeout: 1500
            }

        }

        DSM.State {
            id: serverSetup

            initialState: serverSelectionPage

            DSM.State {
                id: serverSelectionPage

                onEntered: mainView.replace(Qt.resolvedUrl("ServerSelectionPage.qml"))
            }

        }

    }

}

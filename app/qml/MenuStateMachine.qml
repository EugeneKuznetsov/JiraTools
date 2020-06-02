import QtQml.StateMachine 1.14 as DSM
import QtQuick 2.14
import QtQuick.Controls 2.14
pragma Singleton

QtObject {
    property StackView mainView: null
    readonly property PageBase currentPage: mainView && mainView.currentItem ? mainView.currentItem : instance.emptyPage
    readonly property DSM.StateMachine
    instance: DSM.StateMachine {
        readonly property PageBase
        emptyPage: PageBase {
        }

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
            onEntered: mainView.replace(Qt.resolvedUrl("ServerSelectionPage.qml"))

            DSM.State {
                id: serverSelectionPage

                DSM.SignalTransition {
                    targetState: credentialsInputPage
                    signal: currentPage.nextPage
                    onTriggered: mainView.push(Qt.resolvedUrl("CredentialsInputPage.qml"))
                }

            }

            DSM.State {
                id: credentialsInputPage
            }

            DSM.SignalTransition {
                targetState: serverSelectionPage
                signal: currentPage.prevPage
            }

        }

        // default handler for all "back" transitions
        DSM.SignalTransition {
            signal: currentPage.prevPage
            onTriggered: mainView.pop()
        }

    }

}

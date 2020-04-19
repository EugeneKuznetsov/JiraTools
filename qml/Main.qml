import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Window 2.14
import forms 1.0 as Forms

Window {
    id: root

    visible: true
    maximumWidth: Screen.width
    maximumHeight: Screen.height
    minimumWidth: 800
    minimumHeight: 600
    flags: Qt.WindowCloseButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint | Qt.WindowMinMaxButtonsHint
    color: "#f7f7f7"

    StackLayout {
        id: rootLayout

        anchors.fill: parent

        Forms.LoginForm {
        }

    }

}

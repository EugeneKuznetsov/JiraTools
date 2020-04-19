import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Window 2.14
import forms 1.0 as Forms

Window {
    id: root

    visible: true
    minimumWidth: 800
    minimumHeight: 600
    color: "#f7f7f7"

    StackLayout {
        id: rootLayout

        anchors.fill: parent

        Forms.LoginForm {
        }

    }

}

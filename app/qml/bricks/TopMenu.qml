import Jira 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.14
import bricks 1.0 as Bricks

Bricks.JiraItem {
    onReady: jira.userByUsername(function(status, user) {
        if (!status.success)
            console.warn(status.errors);
        else
            userAvatar.source = user.avatarUrls["32x32"];
    }, jira.options.username)
    implicitHeight: 40

    Rectangle {
        color: "#2b2bdc"
        anchors.fill: parent

        Image {
            id: userAvatar

            anchors.centerIn: parent
            height: parent.height - 8
            width: parent.width - 8
            fillMode: Image.PreserveAspectFit
        }

    }

}

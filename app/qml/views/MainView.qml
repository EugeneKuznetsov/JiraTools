import QtQuick 2.14
import bricks 1.0 as Bricks
import forms 1.0 as Forms

Bricks.View {
    onReady: {
        jira.userByUsername(function(status, user) {
            if (status.success)
                console.warn("Display name: " + user.displayName)
        }, jira.options.username);
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

import QtQuick 2.14
import bricks 1.0 as Bricks
import forms 1.0 as Forms

Bricks.View {
    Forms.LoginForm {
        id: loginForm

        anchors.centerIn: parent
        onLogin: {
            error = "";
            blockLogin = true;
            jira.options.server = server;
            jira.options.username = username;
            jira.options.password = password;
            jira.login(function(status) {
                blockLogin = false;
                if (!status.success)
                    error = (status.errors.length) ? status.errors : qsTr("Undocumented error ") + status.code;

            });
        }
    }

    Connections {
        target: jira
        onNetworkErrorDetails: {
            loginForm.blockLogin = false;
            loginForm.error = errorString;
        }
    }

}

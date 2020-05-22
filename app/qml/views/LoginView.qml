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
            jira.server = server;
            var session = jira.session(function(status) {
                blockLogin = false;
                if (!status.success)
                    error = (status.errors.length) ? status.errors : qsTr("Undocumented error ") + status.code;
                else
                    changeViewTo("main");
            });
            session.username = username;
            session.password = password;
            session.login();
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

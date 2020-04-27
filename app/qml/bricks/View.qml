import Jira 1.0
import QtQuick 2.14

Item {
    property Jira jira: null

    signal changeViewTo(string viewName)
    signal ready()

    onJiraChanged: if (jira !== null) {
        ready();
    }
}

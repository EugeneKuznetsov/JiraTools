import Jira 1.0
import QtQuick 2.14

Item {
    property Jira jira: null

    signal ready()

    onJiraChanged: if (jira !== null) {
        ready();
    }
}

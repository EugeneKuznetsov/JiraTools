import Jira 1.1
import QtQuick 2.14

Item {
    property Jira jira: null
    property bool ready: (jira !== null)
}

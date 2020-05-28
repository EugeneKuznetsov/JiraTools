import Jira 1.1
import QtQuick 2.14
pragma Singleton

QtObject {
    property Jira instance
    readonly property bool validating: _int.validating
    readonly property bool valid: _int.valid
    readonly property string lastServerError: _int.lastServerError
    readonly property QtObject
    internals: QtObject {
        id: _int

        property bool validating: false
        property bool valid: false
        property string lastServerError: ""
    }

    function setupAndValidateServer(serverUrl) {
        _int.validating = true;
        instance.server = serverUrl;
        instance.serverInfo(function(status, info) {
            if (!status.success)
                _int.lastServerError = "Not a valid Jira server";

            _int.valid = status.success;
            _int.validating = false;
        }).getServerInfo();
    }

    instance: Jira {
        onNetworkErrorDetails: _int.validating = false
    }

}

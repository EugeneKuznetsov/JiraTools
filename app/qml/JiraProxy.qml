import Jira 1.1
import QtQuick 2.14
pragma Singleton

QtObject {
    property Jira instance
    readonly property bool validating: _int.validating
    readonly property bool valid: _int.valid
    readonly property bool networkError: _int.networkError
    readonly property bool sslError: _int.sslError
    readonly property bool serverError: _int.serverError
    readonly property string lastErrorText: _int.lastErrorText
    readonly property string serverTitle: _int.serverTitle
    readonly property string serverVersion: _int.serverVersion
    readonly property string serverType: _int.serverDeployment
    readonly property QtObject
    internals: QtObject {
        id: _int

        property bool validating: false
        property bool valid: false
        property bool networkError: false
        property bool sslError: false
        property bool serverError: false
        property string lastErrorText: ""
        property string serverTitle: ""
        property string serverVersion: ""
        property string serverDeployment: ""

        function reset() {
            _int.validating = true;
            _int.valid = false;
            _int.networkError = false;
            _int.sslError = false;
            _int.serverError = false;
            _int.lastErrorText = "";
            _int.serverTitle = "";
            _int.serverVersion = "";
            _int.serverDeployment = "";
        }
    }

    function setupAndValidateServer(serverUrl) {
        _int.reset();
        instance.server = serverUrl;
        instance.serverInfo(function(status, info) {
            if (!status.success) {
                _int.serverError = true;
                _int.lastErrorText = "Not a valid Jira server";
            } else {
                _int.serverTitle = info["serverTitle"];
                _int.serverVersion = info["version"];
                _int.serverDeployment = info["deploymentType"];
                console.log(JSON.stringify(info));
            }
            _int.valid = status.success;
            _int.validating = false;
        }).getServerInfo();
    }

    instance: Jira {
        onNetworkErrorDetails: function (errorString, sslError) {
            _int.lastErrorText = errorString;
            _int.networkError = true;
            _int.sslError = sslError;
            _int.validating = false;
        }
    }

}

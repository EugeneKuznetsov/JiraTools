import Jira 1.1
import QtQuick 2.14
pragma Singleton

QtObject {
    property Jira instance
    readonly property bool validating: _internal.validating
    readonly property bool valid: _internal.valid
    readonly property bool networkError: _internal.networkError
    readonly property bool sslError: _internal.sslError
    readonly property bool serverError: _internal.serverError
    readonly property string lastErrorText: _internal.lastErrorText
    readonly property string serverPrettyTitle: "%1 %2 (%3)".arg(serverTitle).arg(serverType).arg(serverVersion)
    readonly property string serverTitle: _internal.serverTitle
    readonly property string serverVersion: _internal.serverVersion
    readonly property string serverType: _internal.serverDeployment
    readonly property QtObject
    internals: QtObject {
        id: _internal

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
            _internal.validating = true;
            _internal.valid = false;
            _internal.networkError = false;
            _internal.sslError = false;
            _internal.serverError = false;
            _internal.lastErrorText = "";
            _internal.serverTitle = "";
            _internal.serverVersion = "";
            _internal.serverDeployment = "";
        }
    }

    function setupAndValidateServer(serverUrl) {
        _internal.reset();
        instance.server = serverUrl;
        instance.serverInfo(function(status, info) {
            if (!status.success) {
                _internal.serverError = true;
                _internal.lastErrorText = qsTr("Not a valid Jira server");
            } else {
                _internal.serverTitle = info["serverTitle"];
                _internal.serverVersion = info["version"];
                _internal.serverDeployment = info["deploymentType"];
                console.log(JSON.stringify(info));
            }
            _internal.valid = status.success;
            _internal.validating = false;
        }).getServerInfo();
    }

    instance: Jira {
        onNetworkErrorDetails: function (errorString, sslError) {
            _internal.lastErrorText = errorString;
            _internal.networkError = true;
            _internal.sslError = sslError;
            _internal.validating = false;
        }
    }

}

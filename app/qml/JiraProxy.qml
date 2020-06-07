pragma Singleton

import Jira 1.1
import QtQuick 2.14

Item {
    property Jira instance
    readonly property bool authenticating: _internal.authenticating
    readonly property bool authenticated: _internal.authenticated
    readonly property bool validating: _internal.validating
    readonly property bool valid: _internal.valid
    readonly property bool networkError: _internal.networkError
    readonly property bool sslError: _internal.sslError
    readonly property bool serverError: _internal.serverError
    readonly property string lastErrorText: _internal.lastErrorText
    readonly property string serverPrettyTitle: "%1 - Jira %2 (%3)".arg(serverTitle).arg(serverType).arg(serverVersion)
    readonly property string serverTitle: _internal.serverTitle
    readonly property string serverVersion: _internal.serverVersion
    readonly property string serverType: _internal.serverDeployment
    readonly property variant permissions: _internal.permissions
    readonly property bool browsePermission: _internal.permissions && _internal.permissions["BROWSE"]["havePermission"]
    readonly property bool anonymous: _internal.permissions && !_internal.permissions.length
    readonly property bool agileFeatures: _internal.agile

    function setupAndValidateServer(serverUrl) {
        _internal.reset();
        _internal.validating = true;
        instance.server = serverUrl;
        instance.serverInfo(function(status, info) {
            if (!status.success) {
                _internal.serverError = true;
                _internal.lastErrorText = qsTr("Not a valid Jira server");
            } else {
                _internal.serverTitle = info.hasOwnProperty("serverTitle") ? info["serverTitle"] : "";
                _internal.serverVersion = info.hasOwnProperty("version") ? info["version"] : "";
                _internal.serverDeployment = info.hasOwnProperty("deploymentType") ? info["deploymentType"] : "";
            }
            _internal.valid = status.success;
            _internal.validating = false;
        }).getServerInfo();
    }

    function authenticate(username, password) {
        _internal.authenticating = true;
        var session = instance.session(function(status) {
            if (!status.success) {
                _internal.serverError = true;
                _internal.lastErrorText = status.errors;
            }
            _internal.authenticated = status.success;
            _internal.authenticating = false;
        });
        session.username = username;
        session.password = password;
        session.login();
    }

    QtObject {
        id: _internal

        property bool authenticating: false
        property bool authenticated: false
        property bool validating: false
        property bool valid: false
        property bool networkError: false
        property bool sslError: false
        property bool serverError: false
        property string lastErrorText: ""
        property string serverTitle: ""
        property string serverVersion: ""
        property string serverDeployment: ""
        property variant permissions: null
        property bool agile: false

        function reset() {
            _internal.authenticating = false;
            _internal.authenticated = false;
            _internal.validating = false;
            _internal.valid = false;
            _internal.networkError = false;
            _internal.sslError = false;
            _internal.serverError = false;
            _internal.lastErrorText = "";
            _internal.serverTitle = "";
            _internal.serverVersion = "";
            _internal.serverDeployment = "";
            _internal.permissions = null;
            _internal.agile = false;
        }

    }

    instance: Jira {
        onNetworkErrorDetails: function(errorString, sslError) {
            _internal.lastErrorText = errorString;
            _internal.networkError = true;
            _internal.sslError = sslError;
            _internal.validating = false;
            _internal.authenticating = false;
        }
    }

    onValidChanged: if (valid) {
        instance.api2(function(status, permissions) {
            if (status.success)
                _internal.permissions = permissions["permissions"];
        }).getPermissions("", "", "", "");
    }

    onAuthenticatedChanged: if (authenticated) {
        instance.api2(function(status, permissions) {
            if (status.success)
                _internal.permissions = permissions["permissions"];
        }).getPermissions("", "", "", "");
        instance.agileBoard(function(status, boards) {
            _internal.agile = status.success;
        }).getAllBoards(0, 1, "", "");
    }
}

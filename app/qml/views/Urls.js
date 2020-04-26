.pragma library

function getViewUrl(viewName) {
    var views = {
        "login": Qt.resolvedUrl("LoginView.qml")
    }
    if (views[viewName] === undefined)
        console.warn("View " + viewName + " does not exist")
    return views[viewName]
}

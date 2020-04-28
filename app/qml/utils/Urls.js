.pragma library

function getViewUrl(viewName) {
    var views = {
        "login": Qt.resolvedUrl("../views/LoginView.qml"),
        "main": Qt.resolvedUrl("../views/MainView.qml")
    }
    if (views[viewName] === undefined)
        console.warn("View \"" + viewName + "\" does not exist")
    return views[viewName]
}

function getSubViewUrl(viewName) {
    var views = {
        "dashboard": Qt.resolvedUrl("../subviews/DashboardSubView.qml")
    }
    if (views[viewName] === undefined)
        console.warn("Subview \"" + viewName + "\" does not exist")
    return views[viewName]
}

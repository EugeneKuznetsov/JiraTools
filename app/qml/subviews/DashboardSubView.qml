import QtQuick 2.14
import bricks 1.0 as Bricks

Bricks.SubView {
    onReadyChanged: console.warn("Loaded Dashboard with active Jira instance [" + jira + "]")
}

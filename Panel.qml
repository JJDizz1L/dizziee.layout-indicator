import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Ui
import qs.Commons

BarWidget {
  id: root
  moduleName: "dizziee.layout-indicator"
  // The focused workspace's tiling layout, read straight from its IPC
  // object over the persistent Hyprland socket — no hyprctl spawn. Unknown
  // or not-yet-polled values fall back to dwindle until the first poll lands.
  readonly property string layout: {
    const ws = Hyprland.focusedWorkspace
    const ipc = ws ? ws.lastIpcObject : null
    const next = ipc ? String(ipc.tiledLayout || "") : ""
    return root.glyphFor(next) !== "" ? next : "dwindle"
  }

  function glyphFor(layout) {
    if (layout === "dwindle") return "󰕰"
    if (layout === "master") return "󰕬"
    if (layout === "monocle") return "󰖯"
    if (layout === "scrolling") return ""
    return ""
  }

  function refresh() {
    Hyprland.refreshWorkspaces()
  }

  Component.onCompleted: refresh()

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (!event || !event.name) return
      var name = String(event.name)
      if (name === "workspacev2" || name === "workspace" || name === "configreloaded") root.refresh()
    }
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.glyphFor(root.layout)
    fixedWidth: root.bar && root.bar.vertical ? -1 : Style.space(27)
    fixedHeight: root.bar && root.bar.vertical ? Style.space(26) : -1
    tooltipText: "Layout: " + root.layout
  }
}

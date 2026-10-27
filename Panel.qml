import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Ui
import qs.Commons
import qs.Commons as Commons
import "Model.js" as Model

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
    return Model.cleanLayout(next)
  }

  function glyphFor(layout) {
    return Model.glyphFor(layout)
  }

  Commons.Translations {
    id: strings
    directory: Qt.resolvedUrl("i18n")
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

  // Hyprland emits no event when a workspace's tiledLayout changes (its
  // activelayout event is the keyboard layout). A slow socket read catches
  // changes made by layout actions or `hyprctl keyword general:layout`
  // without polling at a visible cadence.
  Timer {
    interval: 30000
    running: true
    repeat: true
    onTriggered: root.refresh()
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
    tooltipText: strings.t("layout.tooltip").arg(root.layout)
  }
}

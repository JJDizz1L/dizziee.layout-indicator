// The focused workspace's tiling layout comes from Hyprland IPC (local,
// but not ours to trust). Only the four known layouts pass through;
// everything else falls back to dwindle.
var KNOWN_LAYOUTS = ["dwindle", "master", "monocle", "scrolling"]

function cleanLayout(value) {
  var next = typeof value === "string" ? value.trim() : ""
  return KNOWN_LAYOUTS.indexOf(next) !== -1 ? next : "dwindle"
}

function glyphFor(layout) {
  if (layout === "dwindle") return "󰕰"
  if (layout === "master") return "󰕬"
  if (layout === "monocle") return "󰖯"
  if (layout === "scrolling") return ""
  return ""
}

if (typeof module !== "undefined") {
  module.exports = {
    cleanLayout: cleanLayout,
    glyphFor: glyphFor,
    KNOWN_LAYOUTS: KNOWN_LAYOUTS
  }
}

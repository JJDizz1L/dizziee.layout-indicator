// Run with: node --test tests/
const test = require("node:test")
const assert = require("node:assert/strict")
const Model = require("../Model.js")

test("cleanLayout allowlists known layouts", () => {
  assert.equal(Model.cleanLayout("dwindle"), "dwindle")
  assert.equal(Model.cleanLayout("master"), "master")
  assert.equal(Model.cleanLayout("monocle"), "monocle")
  assert.equal(Model.cleanLayout("scrolling"), "scrolling")
  assert.equal(Model.cleanLayout(""), "dwindle")
  assert.equal(Model.cleanLayout(null), "dwindle")
})

test("markup-shaped layout falls back to dwindle", () => {
  const evil = '<img src="https://example.invalid/tracker">'
  assert.equal(Model.cleanLayout(evil), "dwindle")
  assert.equal(Model.glyphFor(evil), "")
})

test("glyphFor covers known layouts", () => {
  for (const id of Model.KNOWN_LAYOUTS) {
    assert.notEqual(Model.glyphFor(id), "")
  }
})

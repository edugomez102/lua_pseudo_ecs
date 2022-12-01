------------
-- Component constructors
--

local CMP = {
  transform = require("engine.cmp.transform"),
  physics   = require("engine.cmp.physics"),
  render    = require("engine.cmp.render"),
  input     = require("engine.cmp.input"),
  ai        = require("engine.cmp.ai"),
  collision = require("engine.cmp.collision"),
  animation = require("engine.cmp.animation"),
}

return CMP

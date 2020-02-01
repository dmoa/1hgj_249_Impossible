lg = love.graphics
la = love.audio
lm = love.math
lk = love.keyboard
le = love.event
lw = love.window

love.graphics.setDefaultFilter("nearest", "nearest", 1)

local push = require "libs/push"
gameWidth, gameHeight = 128, 128
push:setupScreen(gameWidth, gameHeight, 512, 512, {fullscreen = false, resizable = true})

local screen = require "libs/shack"
screen:setDimensions(push:getDimensions())


map = require("Map")
map:generateTiles()

function love.draw()
    push:start()

    map:draw()

    push:finish()
end

function love.update(dt)
end

function love.keypressed(key)
    if key == "escape" then love.event.quit() end
    if key == "return" and love.keyboard.isDown("lalt") then push:switchFullscreen() end
    if key == "space" then map:generateTiles() end
end

function love.resize(w, h)
    push:resize(w, h)
end
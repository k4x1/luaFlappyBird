-- main.lua
local StateManager = require "stateManager"
local MainMenu = require "mainMenu"
local GameScene = require "gameScene"
local DeathScene = require "deathScene"
local Button = require "button"

function love.load()
    love.window.setTitle("FLOPPY BIRD")
    stateManager = StateManager:new()
    stateManager:add('mainMenu', MainMenu)
    stateManager:add('game', GameScene)
    stateManager:add('death', DeathScene)
    stateManager:switch('mainMenu')
 --   effect = love.graphics.newShader("shader.ps")   
end
function love.conf(t)
    t.window.fullscreen = false  -- Disable fullscreen mode

    -- Swap width and height to set portrait mode
    local temp = t.window.width
    t.window.width = t.window.height
    t.window.height = temp

    -- Optional: Set specific dimensions for portrait mode
    t.window.width = 720
    t.window.height = 1280
end
function love.update(dt)
    stateManager:update(dt)
end

function love.draw()
    stateManager:draw()
end

function love.keypressed(key)
    stateManager:keypressed(key)
end
function love.mousepressed(x, y, button)

    if button == 1 then -- Left mouse button
        stateManager:mousepressed(x, y)
        
    end
end
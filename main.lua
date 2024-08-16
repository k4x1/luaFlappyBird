-- main.lua
local StateManager = require "stateManager"
local MainMenu = require "mainMenu"
local GameScene = require "gameScene"
local DeathScene = require "deathScene"
local Button = require "button"
function love.load()
    stateManager = StateManager:new()
    stateManager:add('mainMenu', MainMenu)
    stateManager:add('game', GameScene)
    stateManager:add('death', DeathScene)
    stateManager:switch('mainMenu')
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
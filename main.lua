-- main.lua
local StateManager = require "stateManager"
local MainMenu = require "mainMenu"
local GameScene = require "gameScene"
local DeathScene = require "deathScene"

function love.load()
    stateManager = StateManager:new()
    stateManager:add('main_menu', MainMenu)
    stateManager:add('game', GameScene)
    stateManager:add('death', DeathScene)
    stateManager:switch('main_menu')
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

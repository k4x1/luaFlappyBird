local MainMenu = {}
local Button = require "button"
MainMenu.__index = MainMenu


function MainMenu:load()
    VIRTUAL_WIDTH = love.graphics.getWidth()
    VIRTUAL_HEIGHT = love.graphics.getHeight()
    love.graphics.setDefaultFilter("nearest", "nearest")
    self.startButton = Button:new("Start Game", (VIRTUAL_WIDTH/2)-100, (VIRTUAL_HEIGHT/2)-25, 200, 50, function()
        stateManager:switch('game')
    end)
end
function MainMenu:update(dt)
    -- Update main menu
end

function MainMenu:draw()
    love.graphics.print("Main Menu", 100, 50)
    self.startButton:draw()
end


function MainMenu:keypressed(key)
    if key == 'return' then
        stateManager:switch('game')
    end
end
function MainMenu:mousepressed(x, y)
    self.startButton:click(x, y)
end

return MainMenu

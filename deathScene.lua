local DeathScene = {}
local Button = require "button"
DeathScene.__index = DeathScene

function DeathScene:load()
    self.startButton = Button:new("Start Game", (VIRTUAL_WIDTH/2)-100, (VIRTUAL_HEIGHT/2)-25, 200, 50, function()
        stateManager:switch('game')
    end)
end

function DeathScene:update(dt)
    -- Update death scene
end

function DeathScene:draw()
    love.graphics.print("You Died - Press Enter to Restart", 100, 100)
    self.startButton:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Score: " .. Score, 10, 10)
end

function DeathScene:keypressed(key)
    if key == 'return' then
        stateManager:switch('game')
    end
end

function DeathScene:mousepressed(x, y)
    self.startButton:click(x, y)
end
return DeathScene

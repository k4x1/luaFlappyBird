local DeathScene = {}
DeathScene.__index = DeathScene

function DeathScene:load()
    -- Initialize death scene
end

function DeathScene:update(dt)
    -- Update death scene
end

function DeathScene:draw()
    love.graphics.print("You Died - Press Enter to Restart", 100, 100)
end

function DeathScene:keypressed(key)
    if key == 'return' then
        stateManager:switch('game')
    end
end

return DeathScene

local MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu:load()
    -- Initialize main menu
end

function MainMenu:update(dt)
    -- Update main menu
end

function MainMenu:draw()
    love.graphics.print("Main Menu - Press Enter to Start", 100, 100)
end

function MainMenu:keypressed(key)
    if key == 'return' then
        stateManager:switch('game')
    end
end

return MainMenu

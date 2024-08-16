local GameScene = {}
local Bird = require "bird"
local Obstacle = require "obstacle"
GameScene.__index = GameScene

function GameScene:load()
    -- Initialize game scene
    love.window.setFullscreen(false)

    bird = Bird:new()
    obstacles = {}
    for i = 1, 3 do
        local topObstacle, bottomObstacle = Obstacle:new(i * (VIRTUAL_WIDTH/3))
        table.insert(obstacles, topObstacle)
        table.insert(obstacles, bottomObstacle)
    end
end

function GameScene:update(dt)
    bird:update(dt)
    for _, obstacle in ipairs(obstacles) do
        obstacle:update(dt)
    end
    if bird:CheckCollision(obstacles) then
        DebugMsg = "collided"
        bird = Bird:new()
        stateManager:switch('death')
    end
end

function GameScene:draw()
    love.graphics.setBackgroundColor(255, 255, 255)
    love.graphics.setColor(1, 1, 1, 1)
    bird:render()
    for _, obstacle in ipairs(obstacles) do
        obstacle:render()
    end

end

function GameScene:keypressed(key)
    if key == 'space' then
        bird:jump()
    end
end

function GameScene:mousepressed(x, y)
    -- Placeholder for mousepressed in game scene
end
return GameScene

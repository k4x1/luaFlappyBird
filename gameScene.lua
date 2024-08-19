local GameScene = {}
local Bird = require "bird"
local Obstacle = require "obstacle"
Score = 0
GameScene.__index = GameScene

function GameScene:load()
    -- Initialize game scene
    love.window.setFullscreen(false)

    bird = Bird:new()
    obstacles = {}
    for i = 1, 3  do
        local topObstacle, bottomObstacle = Obstacle:new(i * (VIRTUAL_WIDTH/3)+VIRTUAL_WIDTH/2)
        table.insert(obstacles, topObstacle)
        table.insert(obstacles, bottomObstacle)
    end
    Score = 0
end
function drawCollisionBoxes()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle("line", bird.x+bird.width*5, bird.y+bird.height*5, bird.width*5, bird.height*5)

    love.graphics.setColor(1, 0, 0, 1) 
    for _, obstacle in ipairs(obstacles) do
        love.graphics.rectangle("line", obstacle.x, obstacle.y, obstacle.width, obstacle.height)
    end
end
function GameScene:update(dt)
    bird:update(dt)
    for _, obstacle in ipairs(obstacles) do
        obstacle:update(dt)
        if not obstacle.passed and bird.x > obstacle.x + obstacle.width then
            obstacle.passed = true
            Score = Score + 0.5
        end
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
    drawCollisionBoxes()

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Score: " .. Score, 10, 10)
end

function GameScene:keypressed(key)
    if key == 'space' then
        bird:jump()
    end
end

function GameScene:mousepressed(x, y)
    bird:jump()
end
return GameScene

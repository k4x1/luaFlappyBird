local Bird = require "bird"
local Obstacle = require "obstacle"
 DebugMsg = "debug"
function love.load()
    love.window.setFullscreen(false)
  
    VIRTUAL_WIDTH = love.graphics.getWidth()
    VIRTUAL_HEIGHT = love.graphics.getHeight()
   
    love.graphics.setDefaultFilter("nearest", "nearest")
    bird = Bird:new()

    obstacles = {}
    for i = 1, 3 do
        local topObstacle, bottomObstacle = Obstacle:new(i * (VIRTUAL_WIDTH/3))
        table.insert(obstacles, topObstacle)
        table.insert(obstacles, bottomObstacle)
    end
    
end
function drawCollisionBoxes()
    -- Draw bird's collision box
    love.graphics.setColor(0, 1, 0, 1) -- Green color
    love.graphics.rectangle("line", bird.x+12, bird.y+12, bird.width*10, bird.height*10)

    -- Draw obstacles' collision boxes
    love.graphics.setColor(1, 0, 0, 1) -- Red color
    for _, obstacle in ipairs(obstacles) do
        love.graphics.rectangle("line", obstacle.x, obstacle.y, obstacle.width, obstacle.height)
    end

    -- Reset color to white
    love.graphics.setColor(1, 1, 1, 1)
end
function love.update(dt)
    bird:update(dt)
    for _, obstacle in ipairs(obstacles) do
        obstacle:update(dt)
    end
    if bird:CheckCollision(obstacles) then
        DebugMsg = "collided"
        bird =Bird:new()
    end

end

function love.draw()
    love.graphics.setBackgroundColor(255, 255, 255)
    bird:render()
    for _, obstacle in ipairs(obstacles) do
        obstacle:render()
    end
    drawCollisionBoxes() 
end
;
function love.keypressed(key)
    if key == 'space' then
        bird:jump()
    end
end
function love.touchpressed(id, x, y, dx, dy)

    bird:jump()

end

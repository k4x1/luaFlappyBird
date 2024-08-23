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
    for i = 1, 3 do
        local topObstacle, bottomObstacle = Obstacle:new(i * (VIRTUAL_WIDTH / 3) + VIRTUAL_WIDTH / 2)
        table.insert(obstacles, topObstacle)
        table.insert(obstacles, bottomObstacle)
    end
    Score = 0

    -- Load fisheye shader
    self.fishEye = love.graphics.newShader("fisheye.glsl")

    self.blurShader = love.graphics.newShader("blur.glsl")
    self.blurShader:send("radius",0.0005);

    self.edgeShader = love.graphics.newShader("edge.glsl")
    self.edgeShader:send("texSize", {VIRTUAL_WIDTH, VIRTUAL_HEIGHT})

    self.chromaticAberrationShader = love.graphics.newShader("chromaticAberration.glsl")
    self.chromaticAberrationShader:send("aberrationAmount", 0.01);
    -- Create a canvas for rendering
    self.canvas = love.graphics.newCanvas(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function drawCollisionBoxes()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle("line", bird.x + (bird.width * 5) / 4, bird.y + bird.height * 5 / 4, bird.width * 5 / 4, bird.height * 5 / 4)

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

    -- Render the scene to the canvas
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()

    bird:render()
    for _, obstacle in ipairs(obstacles) do
        obstacle:render()
    end

    love.graphics.setCanvas()  -- Reset canvas

    -- Apply fisheye shader and draw the canvas
   -- love.graphics.setShader(self.fishEye)
  --  love.graphics.setShader(self.edgeShader)
   -- love.graphics.setShader(self.blurShader)
  --  love.graphics.setShader(self.chromaticAberrationShader)
    love.graphics.draw(self.canvas, 0, 0)
    love.graphics.setShader()  -- Reset shader

    -- drawCollisionBoxes()

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

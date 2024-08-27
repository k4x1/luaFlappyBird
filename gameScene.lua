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

    self.blurShader = love.graphics.newShader("blur.glsl")
    self.blurRadius = 0.02 
    self.blurDecreasing  = true
    -- Load shaders
    -- self.fishEye = love.graphics.newShader("fisheye.glsl")
    -- self.blurShader = love.graphics.newShader("blur.glsl")
    -- self.blurShader:send("radius", 0.0005)
    -- self.edgeShader = love.graphics.newShader("edge.glsl")
    -- self.edgeShader:send("texSize", {VIRTUAL_WIDTH, VIRTUAL_HEIGHT})
     self.chromaticAberrationShader = love.graphics.newShader("chromaticAberration.glsl")
     self.chromaticAberrationShader:send("aberrationAmount", 2)
    
    -- Create a canvas for rendering
    self.canvas = love.graphics.newCanvas(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- Load background image
    self.backgroundImage = love.graphics.newImage("background.png")
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
    if self.blurDecreasing then
        self.blurRadius = self.blurRadius - dt * 0.02  
        if self.blurRadius <= 0 then
            self.blurRadius = 0
            self.blurDecreasing = false
        end
        return
    end
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
    love.graphics.setBackgroundColor(0.239, 0.533, 0.659)
    local scaleX = 0.5  
    local scaleY = 0.5  

    local bgX = (VIRTUAL_WIDTH - self.backgroundImage:getWidth() * scaleX) / 2
    local bgY = (VIRTUAL_HEIGHT - self.backgroundImage:getHeight() * scaleY)


    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.draw(self.backgroundImage, bgX, bgY, 0, scaleX, scaleY)
    love.graphics.setColor(1, 1, 1, 1)

    bird:render()
    for _, obstacle in ipairs(obstacles) do
        obstacle:render()
    end

    love.graphics.setCanvas() 

  
    self.blurShader:send("radius", self.blurRadius)
    love.graphics.setShader(self.blurShader)
    love.graphics.draw(self.canvas, 0, 0)
    love.graphics.print("Score: " .. Score, 10, 10)
    love.graphics.setShader() 

    -- drawCollisionBoxes()

end


function GameScene:keypressed(key)
    if key == 'space' then
        bird:jump()
    end
end

function GameScene:mousepressed(x, y)
    bird:jump()
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    bird:jump()
end

return GameScene

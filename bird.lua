Bird = {}
Bird.__index = Bird
require "obstacle"
local GRAVITY = 20
local JUMP_VELOCITY = -7
local PIXEL_SCALE = 4
function AABB(a, b)
    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y
end

function Bird:init()
    self.image = love.graphics.newImage('bird_spritesheet.png')
    self.width = (self.image:getWidth()/4)
    self.height = (self.image:getHeight())

    self.origin = {self.width / 2, self.height / 2}
    self.x = VIRTUAL_WIDTH / 2 - self.origin[1]
    self.y = VIRTUAL_HEIGHT / 2 - self.origin[2]

    self.dy = 0

    self.frames = {}
    for i = 0, 3 do
        table.insert(self.frames, love.graphics.newQuad(i * self.width, 0, self.width, self.height, self.image:getDimensions()))
    end
    self.currentFrame = 1
    self.animationTimer = 0
    self.animationDuration = 0.1

        -- Load particle image and create particle system
    local particleImage = love.graphics.newImage('particle.png')
    self.pSystem = love.graphics.newParticleSystem(particleImage, 320)
    self.pSystem:setParticleLifetime(0.3, 0.8)  -- Particles live between 0.5 and 1 second
    self.pSystem:setLinearAcceleration(-400, 0, 0, 400)  -- Random movement in all directions
    self.pSystem:setSpeed(-200,0)
  
    self.pSystem:setSizes(0.1, 0.1)
    self.pSystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) 
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy
    self.animationTimer = self.animationTimer + dt
    if self.animationTimer >= self.animationDuration and self.currentFrame <4 then
        self.animationTimer = self.animationTimer - self.animationDuration
        self.currentFrame = self.currentFrame % #self.frames + 1
    end
    self.pSystem:update(dt)
end

function Bird:jump()
    self.dy = JUMP_VELOCITY
    self.currentFrame = 1
    self.animationTimer = 0
    self.pSystem:setPosition(self.x + self.width*2, self.y + self.height)
    self.pSystem:emit(32)
end

function Bird:render()
    love.graphics.draw(self.pSystem)
    love.graphics.draw(self.image, self.frames[self.currentFrame], self.x, self.y, 0, PIXEL_SCALE, PIXEL_SCALE)
end



function Bird:new()
    local me = setmetatable({}, Bird)
    me:init()
    return me
end
function Bird:CheckCollision(obstacles)
  
    local birdBox = {x = self.x+(self.width*5)/4, y = self.y+self.height*5/4, width = self.width*5/4, height = self.height*5/4}
    for _, obstacle in ipairs(obstacles) do

        local obstacleBox = {x = obstacle.x, y = obstacle.y, width = obstacle.width, height = obstacle.height}
        if AABB(birdBox, obstacleBox) then
            return true
        end
    end
    return false
end
return Bird

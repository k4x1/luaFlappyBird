Bird = {}
Bird.__index = Bird
require "obstacle"
local GRAVITY = 20
local JUMP_VELOCITY = -7
local PIXEL_SCALE = 0.2
function AABB(a, b)
    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y
end

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth() * PIXEL_SCALE
    self.height = self.image:getHeight() * PIXEL_SCALE

    self.origin = {self.width / 2, self.height / 2}
    self.x = VIRTUAL_WIDTH / 2 - self.origin[1]
    self.y = VIRTUAL_HEIGHT / 2 - self.origin[2]

    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy
end

function Bird:jump()
    self.dy = JUMP_VELOCITY
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y, 0, self.width, self.height)
end


function Bird:new()
    local me = setmetatable({}, Bird)
    me:init()
    return me
end
function Bird:CheckCollision(obstacles)
  
    local birdBox = {x = self.x+self.width*5, y = self.y+self.height*5, width = self.width*5, height = self.height*5}
    for _, obstacle in ipairs(obstacles) do

        local obstacleBox = {x = obstacle.x, y = obstacle.y, width = obstacle.width, height = obstacle.height}
        if AABB(birdBox, obstacleBox) then
            return true
        end
    end
    return false
end
return Bird

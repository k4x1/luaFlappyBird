Obstacle = {}
Obstacle.__index = Obstacle

local PIXEL_SCALE = 6
local GAP_HEIGHT = 200 

function Obstacle:init(pos, isTop, pairedObstacle)
    self.image = love.graphics.newImage('pipeTop.png')
    self.botImage = love.graphics.newImage('pipeBottom.png')
    self.isTop = isTop
    self.pairedObstacle = pairedObstacle

    self.width = self.image:getWidth() * PIXEL_SCALE
    self.height = self.image:getHeight() * PIXEL_SCALE

    self.offsetX = 28 * PIXEL_SCALE 
    self.offsetY = self.isTop and -1 * self.height or 1

    self.speed = 500

    self.x = pos
    self.y = self.isTop and love.math.random(-self.height,-self.height+VIRTUAL_HEIGHT-GAP_HEIGHT) or (self.pairedObstacle.y + self.pairedObstacle.height + GAP_HEIGHT)

end

function Obstacle:update(dt)
    self.x = self.x - (self.speed * dt)
    if self.x < 0 then
        self.x = VIRTUAL_WIDTH
        self.y = self.isTop and love.math.random(-self.height,-self.height+VIRTUAL_HEIGHT-GAP_HEIGHT) or (self.pairedObstacle.y + self.pairedObstacle.height + GAP_HEIGHT)
    end
end

function Obstacle:render()
    if self.isTop then 
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.draw(self.image, self.x + self.width , self.y+self.height, 3.14, PIXEL_SCALE, PIXEL_SCALE)
    else
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.draw(self.image, self.x, self.y, 0, PIXEL_SCALE, PIXEL_SCALE)
    end
   
end  

function Obstacle:new(pos)
    local topObstacle = setmetatable({}, Obstacle)
    local botObstacle = setmetatable({}, Obstacle)
    
    topObstacle:init(pos, true, botObstacle)
    botObstacle:init(pos, false, topObstacle)
    
    return topObstacle, botObstacle
end

return Obstacle

local MainMenu = {}
local Button = require "button"
MainMenu.__index = MainMenu

function MainMenu:load()
    VIRTUAL_WIDTH = love.graphics.getWidth()
    VIRTUAL_HEIGHT = love.graphics.getHeight()
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Load images
    self.backgroundImage = love.graphics.newImage("background.png")
    self.birdImage = love.graphics.newImage("bird.png")
    self.birdSize = 10
    local fontSize =20 
    self.titleFont = love.graphics.newFont("figmaFont.otf",  math.min(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)/10)
    self.buttonFont = love.graphics.newFont("figmaFont.otf",  math.min(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)/20)
    -- Create start button
    self.startButton = Button:new("START", (VIRTUAL_WIDTH/2)-100, (VIRTUAL_HEIGHT/2)+100, 200, 50, function()
        stateManager:switch('game')
    end)
end

function MainMenu:update(dt)
    -- Update main menu
end

function MainMenu:draw()
    love.graphics.setBackgroundColor(0.239, 0.533, 0.659)
    -- Calculate scaling factors to reduce the background size
    local scaleX = 0.5  -- Scale down to 80% of the original width
    local scaleY = 0.5  -- Scale down to 80% of the original height
    
    -- Calculate the position to center the scaled background
    local bgX = (VIRTUAL_WIDTH - self.backgroundImage:getWidth() * scaleX) / 2
    local bgY = (VIRTUAL_HEIGHT - self.backgroundImage:getHeight() * scaleY)
    -- Draw title
    love.graphics.setColor(1, 1, 1,0.5)
    love.graphics.draw(self.backgroundImage, bgX, bgY, 0, scaleX, scaleY)
    
    -- Draw bird image
    local birdX = (VIRTUAL_WIDTH / 2) - (self.birdImage:getWidth()*self.birdSize)/2
    local birdY = (VIRTUAL_HEIGHT / 2) - (self.birdImage:getHeight() / 2) - 100
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.birdImage, birdX, birdY,0, self.birdSize, self.birdSize)
    
    -- Draw title
    love.graphics.setFont(self.titleFont)
    love.graphics.printf("FLOPPY BORD", 0, birdY - 100, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(self.buttonFont)
    -- Draw start button
    self.startButton:draw()
end

function MainMenu:keypressed(key)
    if key == 'return' then
        stateManager:switch('game')
    end
end

function MainMenu:mousepressed(x, y)
    self.startButton:click(x, y)
end

function MainMenu:touchpressed(x, y)
    self.startButton:click(x, y)
end

return MainMenu

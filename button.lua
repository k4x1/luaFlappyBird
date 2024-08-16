local Button = {}
Button.__index = Button

function Button:new(text, x, y, width, height, callback)
    local this = {
        text = text,
        x = x,
        y = y,
        width = width,
        height = height,
        callback = callback,
        clicked = false
    }
    setmetatable(this, Button)
    return this
end

function Button:draw()
    love.graphics.setColor(0, 200, 255, 255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(self.text, self.x + (self.width / 4), self.y + (self.height / 4))
end

function Button:isMouseOver(x, y)
    return x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height
end

function Button:click(x, y)
    if self:isMouseOver(x, y) then
        self.clicked = true
        if self.callback then
            self.callback()
        end
    end
end

function Button:wasClicked()
    local clicked = self.clicked
    self.clicked = false
    return clicked
end

return Button

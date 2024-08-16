
local StateManager = {}
StateManager.__index = StateManager

function StateManager:new()
    local this = {
        states = {},
        current = nil
    }
    setmetatable(this, StateManager)
    return this
end

function StateManager:add(name, state)
    self.states[name] = state
end

function StateManager:switch(name)
    self.current = self.states[name]
    if self.current and self.current.load then
        self.current:load()
    end
end

function StateManager:update(dt)
    if self.current and self.current.update then
        self.current:update(dt)
    end
end

function StateManager:draw()
    if self.current and self.current.draw then
        self.current:draw()
    end
end

function StateManager:keypressed(key)
    if self.current and self.current.keypressed then
        self.current:keypressed(key)
    end
end

return StateManager

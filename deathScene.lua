local DeathScene = {}
local Button = require "button"
DeathScene.__index = DeathScene

local highScores = {}

local function loadHighScores()
    local file = love.filesystem.read("highscores.lua")
    if file then
        io.write("File content: ", file)  -- Debugging: Print file content
        local chunk, err = loadstring(file)
        if chunk then
            local loadedScores = chunk()
            io.write("Loaded scores type: ", type(loadedScores))  -- Debugging: Print type of loadedScores
            if type(loadedScores) == "table" then
                highScores = loadedScores
            else
                highScores = {0, 0, 0, 0, 0}
            end
        else
            io.write("Error loading chunk: ", err)  -- Debugging: Print error if chunk loading fails
            highScores = {0, 0, 0, 0, 0}
        end
    else
        highScores = {0, 0, 0, 0, 0}
    end
end

local function saveHighScores()
    local scoresString = "return {"
    for i, score in ipairs(highScores) do
        scoresString = scoresString .. score
        if i < #highScores then
            scoresString = scoresString .. ", "
        end
    end
    scoresString = scoresString .. "}"
    love.filesystem.write("highscores.lua", scoresString)
end

local function updateHighScores(newScore)
    table.insert(highScores, newScore)
    table.sort(highScores, function(a, b) return a > b end)
    if #highScores > 5 then
        table.remove(highScores)
    end
    saveHighScores()
end

function DeathScene:load()
    self.startButton = Button:new("Start Game", (VIRTUAL_WIDTH/2)-100, (VIRTUAL_HEIGHT/2)-25, 200, 50, function()
        stateManager:switch('game')
    end)
    loadHighScores()
end

function DeathScene:update(dt)
    -- Update death scene
end

function DeathScene:draw()
    love.graphics.print("You Died - Press Enter to Restart", 100, 100)
    self.startButton:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Score: " .. Score, 10, 10)

    love.graphics.print("High Scores:", 100, 150)
    for i, score in ipairs(highScores) do
        love.graphics.print(i .. ". " .. score, 100, 150 + i * 20)
    end
end

function DeathScene:keypressed(key)
    if key == 'return' then
        stateManager:switch('game')
    end
end

function DeathScene:mousepressed(x, y)
    self.startButton:click(x, y)
end

function DeathScene:enter()
    updateHighScores(Score)
end

return DeathScene

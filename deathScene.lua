local DeathScene = {}
local Button = require "button"
DeathScene.__index = DeathScene

local highScores = {}

local function loadHighScores()
    local file = love.filesystem.read("highscores.lua")
    if file then
        io.write("File content: ", file, "\n")  -- Debugging: Print file content
        local chunk, err = loadstring(file)
        if chunk then
            local loadedScores = chunk()
            io.write("Loaded scores type: ", type(loadedScores), "\n")  -- Debugging: Print type of loadedScores
            if type(loadedScores) == "table" then
                highScores = loadedScores
            else
                highScores = {0, 0, 0, 0, 0}
            end
        else
            io.write("Error loading chunk: ", err, "\n")  -- Debugging: Print error if chunk loading fails
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
    io.write("Saving scores: ", scoresString, "\n")  -- Debugging: Print the string being saved
    local success, message = love.filesystem.write("highscores.lua", scoresString)
    if not success then
        io.write("Error writing file: ", message, "\n")  -- Debugging: Print error if file writing fails
    else
        io.write("File written successfully\n")  -- Debugging: Confirm file writing success
    end
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
    -- Load background image
    self.backgroundImage = love.graphics.newImage("background.png")

    -- Load custom fonts
    self.titleFont = love.graphics.newFont("figmaFont.otf", math.min(VIRTUAL_WIDTH, VIRTUAL_HEIGHT) / 10)
    self.buttonFont = love.graphics.newFont("figmaFont.otf", math.min(VIRTUAL_WIDTH, VIRTUAL_HEIGHT) / 20)

    -- Create start button
    self.startButton = Button:new("START", VIRTUAL_WIDTH - 300, VIRTUAL_HEIGHT / 2, 200, 50, function()
        stateManager:switch('game')
    end)

    -- Create save score button
    self.saveScoreButton = Button:new("SAVE "..Score, VIRTUAL_WIDTH - 300, VIRTUAL_HEIGHT / 2 + 60, 200, 50, function()
        updateHighScores(Score)
    end)

    loadHighScores()
end

function DeathScene:update(dt)
    -- Update death scene
end

function DeathScene:draw()
    love.graphics.setBackgroundColor(0.239, 0.533, 0.659)

    -- Calculate scaling factors to reduce the background size
    local scaleX = 0.5  -- Scale down to 50% of the original width
    local scaleY = 0.5  -- Scale down to 50% of the original height

    -- Calculate the position to center the scaled background
    local bgX = (VIRTUAL_WIDTH - self.backgroundImage:getWidth() * scaleX) / 2
    local bgY = (VIRTUAL_HEIGHT - self.backgroundImage:getHeight() * scaleY) / 2

    -- Draw background image with scaling
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.draw(self.backgroundImage, bgX, bgY, 0, scaleX, scaleY)

    -- Draw title
    love.graphics.setFont(self.titleFont)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("HIGHSCORES", 0, 50, VIRTUAL_WIDTH, "center")

    -- Draw high scores on the left
    local scoreBoxWidth = 200
    local scoreBoxHeight = 300
    local scoreBoxX = 50
    local scoreBoxY = (VIRTUAL_HEIGHT / 2) - scoreBoxHeight / 2

    love.graphics.setColor(0.5, 0.8, 0.5)
    love.graphics.rectangle("fill", scoreBoxX, scoreBoxY, scoreBoxWidth, scoreBoxHeight)

    love.graphics.setFont(self.buttonFont)
    love.graphics.setColor(1, 1, 1)
    local labels = {"st", "nd", "rd", "th", "th"}
    for i, score in ipairs(highScores) do
        love.graphics.printf(i .. labels[i].."-" .. score, scoreBoxX, scoreBoxY + (i - 1) * 40 + 20, scoreBoxWidth, "center")
    end

    -- Draw start button on the right
    self.startButton:draw()

    -- Draw save score button on the right
    self.saveScoreButton:draw()
end

function DeathScene:keypressed(key)
    if key == 'return' then
        stateManager:switch('game')
    end
end

function DeathScene:mousepressed(x, y)
    self.startButton:click(x, y)
    self.saveScoreButton:click(x, y)
end 

function DeathScene:touchpressed(x, y)
    self.startButton:click(x, y)
    self.saveScoreButton:click(x, y)
end

function DeathScene:enter()
    updateHighScores(Score)
end

function love.quit()
    saveHighScores()
end

return DeathScene

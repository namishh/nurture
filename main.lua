local nurture = require("nurture")

N = nurture:new()

local CURRENT_EXAMPLE = "boxtest"
local currentExampleModule = nil

function love.load()
    love.window.setMode(900, 650)
    love.window.setTitle("nurture - " .. (CURRENT_EXAMPLE or "blank"))
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.15, 0.15, 0.2)
    love.graphics.setColor(1, 1, 1)

    N:registerFont('assets/BoldPixels.ttf', 'title', 24, true)
    N:registerFont('assets/BoldPixels.ttf', 'bigtitle', 32, false)
    N:registerFont('assets/BoldPixels.ttf', 'subtitle', 18, false)
    N:registerFont('assets/BoldPixels.ttf', 'BodyFont', 14, false)

    if CURRENT_EXAMPLE then
        currentExampleModule = require("examples." .. CURRENT_EXAMPLE)
        if currentExampleModule and currentExampleModule.load then
            print("Loading example: " .. CURRENT_EXAMPLE)
            currentExampleModule.load(nurture, N)
        else
            error("Example '" .. CURRENT_EXAMPLE .. "' does not have a load() function")
        end
    else
        print("No example loaded. Starting with blank canvas.")
    end
end

function love.update(dt)
    N:update(dt)
end

function love.draw()
    N:draw()

    love.graphics.setColor(1, 1, 1, 0.5)
    local currentExample = CURRENT_EXAMPLE or "blank"
    love.graphics.print("Example: " .. currentExample, 10, love.graphics.getHeight() - 40)
    love.graphics.print("Press ESC to quit", 10, love.graphics.getHeight() - 20)
    love.graphics.setColor(1, 1, 1, 1)
end

function love.mousepressed(x, y, button)
    N:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    N:mousereleased(x, y, button)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if currentExampleModule and currentExampleModule.keypressed then
        currentExampleModule.keypressed(key)
    end
end

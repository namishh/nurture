local nurture = require("nurture")
local moonshine = require("assets.moonshine")

N = nurture:new()

local CURRENT_EXAMPLE = "stacktest"
local currentExampleModule = nil


local postChain 

function love.load()
    love.window.setMode(1280, 720)
    love.window.setTitle("nurture - " .. (CURRENT_EXAMPLE or "blank"))
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.15, 0.15, 0.2)
    love.graphics.setColor(1, 1, 1)

    N:registerFont('assets/BoldPixels.ttf', 'title', 24, true)
    N:registerFont('assets/BoldPixels.ttf', 'bigtitle', 32, false)
    N:registerFont('assets/BoldPixels.ttf', 'biggertitle', 64, false)
    N:registerFont('assets/BoldPixels.ttf', 'reallybigtitle', 120, false)
    N:registerFont('assets/BoldPixels.ttf', 'subtitle', 18, false)
    N:registerFont('assets/BoldPixels.ttf', 'BodyFont', 14, false)

    postChain = moonshine(moonshine.effects.scanlines)
        .chain(moonshine.effects.crt)
        .chain(moonshine.effects.vignette)
        .chain(moonshine.effects.glow)
    postChain.parameters = {
        crt = {
            distortionFactor = { 1, 1.0125 },
            scaleFactor = 0.98,
            feather = 0,
        },
        scanlines = {
            opacity = 0.35,
            phase = 1
        },
        glow = {
            strength = 2,
            min_luma = 0.8
        },
        vignette = {
            opacity = 0,
            radius = 0.9,
            softness = 0.5,
            color = { 0, 0, 0 }
        }
    }

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
    
    if currentExampleModule and currentExampleModule.update then
        currentExampleModule.update(dt)
    end
end

function love.draw()
    postChain(function()
    N:draw()

    love.graphics.setColor(1, 1, 1, 0.5)
    local currentExample = CURRENT_EXAMPLE or "blank"
    love.graphics.print("Example: " .. currentExample, 10, love.graphics.getHeight() - 40)
    love.graphics.print("Press  to quit", 10, love.graphics.getHeight() - 20)
    love.graphics.setColor(1, 1, 1, 1)
    end)
end

function love.mousepressed(x, y, button)
    N:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    N:mousereleased(x, y, button)
end

function love.mousemoved(x, y, dx,dy)
    N:mousemoved(x,y,dx,dy)
end

function love.keypressed(key, scancode, isrepeat)
    N:keypressed(key, scancode, isrepeat)

    if key == "0" then
        love.event.quit()
    end

    if currentExampleModule and currentExampleModule.keypressed then
        currentExampleModule.keypressed(key, scancode, isrepeat)
    end
end

function love.textinput(text)
   N:textinput(text) 
end

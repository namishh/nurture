local nurture = require("nurture")

N = nurture:new()

function love.load()
    love.window.setTitle("Hello World - Love2D")
    love.graphics.setBackgroundColor(0.2, 0.3, 0.5)
    love.graphics.setColor(1, 1, 1)
    N:registerFont('assets/BoldPixels.ttf', 'MyFontName', 24, true)

    N:setFont('MyFontName')
end

function love.draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    local text = "Hello World!"
    
    local textWidth = N:font('MyFontName'):getWidth(text)
    local textHeight = N:font('MyFontName'):getHeight()
    
    local x = (width - textWidth) / 2
    local y = (height - textHeight) / 2
    
    love.graphics.print(text, x, y)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

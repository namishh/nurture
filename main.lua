local nurture = require("nurture")

N = nurture:new()


function love.load()
    love.window.setTitle("nurture")
    love.graphics.setBackgroundColor(0.2, 0.3, 0.5)
    love.graphics.setColor(1, 1, 1)

    N:registerFont('assets/BoldPixels.ttf', 'title', 48, true)
    N:registerFont('assets/BoldPixels.ttf', 'subtitle', 32, false)
    N:registerFont('assets/BoldPixels.ttf', 'body', 20, false)

    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    local titleLabel = nurture.TextLabel:new(N, "ui library lmao", "title")
    titleLabel:setPosition(width / 2 - titleLabel.width / 2, height / 2 - 80)
    titleLabel:setColor(1, 1, 0.8, 1)

    local lerpLabel = nurture.TextLabel:new(N, "this color changes text", "subtitle")
    lerpLabel:setPosition(width / 2 - lerpLabel.width / 2, height / 2 + 100)
    lerpLabel:setColor(1, 0, 0, 1)

    local lerpTime = 0
    local color1 = { 0.8, 0.4, 0.9, 1 }
    local color2 = { 0.5, 0.5, 1, 1 }

    lerpLabel:setUpdateCallback(function(widget, dt)
        lerpTime = lerpTime + dt * 1
        local t = (math.sin(lerpTime) + 1) / 2

        local r = color1[1] + (color2[1] - color1[1]) * t
        local g = color1[2] + (color2[2] - color1[2]) * t
        local b = color1[3] + (color2[3] - color1[3]) * t
        local a = color1[4] + (color2[4] - color1[4]) * t

        widget:setColor(r, g, b, a)
    end)

    local originalX, originalY = lerpLabel.x, lerpLabel.y
    lerpLabel:setDrawCallback(function(widget)
        love.graphics.push()
        love.graphics.translate(originalX + widget.width / 2, originalY + widget.height / 2)
        love.graphics.rotate(math.rad(10))
        love.graphics.translate(-widget.width / 2, -widget.height / 2)
        widget.x = 0
        widget.y = 0
    end)
end

function love.update(dt)
    N:update(dt)
end

function love.draw()
    N:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

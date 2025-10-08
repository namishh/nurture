local nurture = require("nurture")

N = nurture:new()


function love.load()
    love.window.setTitle("nurture")
    love.graphics.setBackgroundColor(0.2, 0.3, 0.5)
    love.graphics.setColor(1, 1, 1)

    N:registerFont('assets/BoldPixels.ttf', 'title', 48, true)
    N:registerFont('assets/BoldPixels.ttf', 'subtitle', 32, false)
    N:registerFont('assets/BoldPixels.ttf', 'BodyFont', 20, false)


    local followText = nurture.TextLabel:new(N, "I follow you!", "BodyFont", {
        shadow = {
            x = 2,
            y = 2,
            color = { 0, 0, 0, 1 }
        }
    })
    followText:setColor(1, 1, 1, 1)

    local followBox = nurture.Box:new(N, {
        padding = 20,
        forcedWidth = 200,
        zIndex = 2,
        forcedHeight = 200,
        backgroundColor = { 0.1, 0.1, 0.2, 0.8 },
        valign = "bottom",
        halign = "right"
    })

    followBox:setChild(followText)

    followBox:setUpdateCallback(function(widget, dt)
        local mx, my = love.mouse.getPosition()
        widget:setPosition(mx, my)
        followText:setText("I follow you! " .. mx .. ", " .. my)
    end)

    local hbox = nurture.HBox:new(N, {
        x = 0,
        y = 0,
        spacing = 20,
        forcedWidth = 800,
        justify = "space-evenly",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 100,
                padding = 2,
                backgroundColor = { 0.1, 0.1, 0.2, 0.4 },
            }),
            nurture.Box:new(N, {
                padding = 2,
                forcedWidth = 200,
                forcedHeight = 50,
                vertAlign = "center",
                backgroundColor = { 0.5, 0.7, 0.2, 0.4 },
            })
        }
    })


    hbox:setAddChildCallback(function(widget, child)
        print("Added child to hbox")
    end)


    local box = nurture.Box:new(N, {
        forcedWidth = 60,
        forcedHeight = 60,
        vertAlign = "bottom",
        padding = 2,
        backgroundColor = { 0.8, 0.1, 0.6, 0.4 },
        children = {
            nurture.TextLabel:new(N, "Hello", "BodyFont", {
                color = { 1, 0.5, 1, 1 },
            }),
        }
    })
    hbox:addChild(box)
    
    local shaderBox = nurture.Box:new(N, {
        x = 100,
        y = 150,
        forcedWidth = 150,
        forcedHeight = 150,
        padding = 10,
        backgroundColor = { 1, 1, 1, 1 },
        backgroundShader = "assets/grad.glsl",
        children = {
            nurture.TextLabel:new(N, "Spinning!", "BodyFont", {
                color = { 1, 1, 1, 1 },
            }),
        }
    })
    
    shaderBox:setUpdateCallback(function(widget, dt)
        widget:setBackgroundShaderValue("time", love.timer.getTime())
    end)
    
    local fullShaderBox = nurture.Box:new(N, {
        x = 300,
        y = 150,
        forcedWidth = 150,
        forcedHeight = 150,
        padding = 10,
        backgroundColor = { 1, 1, 1, 1 },
        shader = "assets/grad.glsl",
        children = {
            nurture.TextLabel:new(N, "Full Shader!", "BodyFont", {
                color = { 1, 1, 1, 1 },
            }),
        }
    })
    
    fullShaderBox:setUpdateCallback(function(widget, dt)
        widget:setShaderValue("time", love.timer.getTime())
    end)
end

function love.update(dt)
    N:update(dt)
end

function love.draw()
    N:draw()
end

function love.mousepressed(x, y, button)
    N:mousepressed(x, y, button)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

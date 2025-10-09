local function load(nurture, N)
    local circle1 = nurture.Shape.Circle:new(N, {
        x = 70,
        y = 70,
        radius = 50,
        color = { 0.8, 0.3, 0.3, 1 },
        classname = "circle-filled"
    })

    local circle2 = nurture.Shape.Circle:new(N, {
        x = 200,
        y = 70,
        radius = 50,
        mode = "line",
        lineWidth = 3,
        color = { 0.3, 0.8, 0.3, 1 },
        classname = "circle-line"
    })

    local circle3 = nurture.Shape.Circle:new(N, {
        x = 330,
        y = 70,
        radius = 30,
        color = { 0.3, 0.3, 0.8, 1 },
        classname = "circle-animated"
    })
    
    local circleTime = 0
    circle3:setUpdateCallback(function(widget, dt)
        circleTime = circleTime + dt
        local radius = 30 + math.sin(circleTime * 3) * 15
        widget:setRadius(radius)
    end)

    local rect1 = nurture.Shape.Rectangle:new(N, {
        x = 450,
        y = 20,
        width = 100,
        height = 80,
        color = { 0.8, 0.5, 0.3, 1 },
        classname = "rect-filled"
    })

    local rect2 = nurture.Shape.Rectangle:new(N, {
        x = 570,
        y = 20,
        width = 100,
        height = 80,
        mode = "line",
        lineWidth = 2,
        color = { 0.5, 0.3, 0.8, 1 },
        classname = "rect-line"
    })

    local rect3 = nurture.Shape.Rectangle:new(N, {
        x = 690,
        y = 20,
        width = 100,
        height = 80,
        rx = 15,
        ry = 15,
        color = { 0.3, 0.8, 0.8, 1 },
        classname = "rect-rounded"
    })

    local triangle = nurture.Shape.Polygon:new(N, {
        vertices = { 70, 200, 20, 280, 120, 280 },
        color = { 0.9, 0.3, 0.3, 1 },
        classname = "polygon-triangle"
    })

    local pentagon = nurture.Shape.Polygon:new(N, {
        vertices = {
            200, 180,
            230, 200,
            215, 235,
            185, 235,
            170, 200
        },
        mode = "line",
        lineWidth = 3,
        color = { 0.3, 0.9, 0.3, 1 },
        classname = "polygon-pentagon"
    })

    local star = nurture.Shape.Polygon:new(N, {
        vertices = {
            330, 180,
            342, 215,
            378, 215,
            348, 237,
            360, 272,
            330, 250,
            300, 272,
            312, 237,
            282, 215,
            318, 215
        },
        color = { 0.9, 0.9, 0.3, 1 },
        classname = "polygon-star"
    })

    -- LINES
    local line1 = nurture.Shape.Line:new(N, {
        points = { 450, 180, 550, 240 },
        lineWidth = 3,
        color = { 0.8, 0.3, 0.8, 1 },
        classname = "line-simple"
    })

    local line2 = nurture.Shape.Line:new(N, {
        points = { 580, 180, 620, 220, 660, 190, 700, 240, 740, 200 },
        lineWidth = 4,
        color = { 0.3, 0.8, 0.9, 1 },
        classname = "line-poly"
    })

    local line3 = nurture.Shape.Line:new(N, {
        points = { 450, 260, 550, 260 },
        lineWidth = 5,
        color = { 0.9, 0.5, 0.3, 1 },
        classname = "line-animated"
    })
    
    local lineTime = 0
    line3:setUpdateCallback(function(widget, dt)
        lineTime = lineTime + dt
        local offset = math.sin(lineTime * 2) * 30
        widget:setPoints({ 450, 260, 500, 260 + offset, 550, 260 })
    end)

    -- POINTS
    local point1 = nurture.Shape.Point:new(N, {
        x = 70,
        y = 350,
        size = 10,
        color = { 1, 0, 0, 1 },
        classname = "point-single"
    })

    local points = {}
    for i = 1, 10 do
        local angle = (i / 10) * math.pi * 2
        local x = 200 + math.cos(angle) * 40
        local y = 380 + math.sin(angle) * 40
        points[i] = nurture.Shape.Point:new(N, {
            x = x,
            y = y,
            size = 8,
            color = { 0.3 + i * 0.05, 0.8, 0.9 - i * 0.05, 1 },
            classname = "point-pattern"
        })
    end

    local pointTime = 0
    for i, point in ipairs(points) do
        point:setUpdateCallback(function(widget, dt)
            pointTime = pointTime + dt / 10
            local angle = (i / 10) * math.pi * 2 + pointTime
            local x = 200 + math.cos(angle) * 40
            local y = 380 + math.sin(angle) * 40
            widget:setPosition(x, y)
        end)
    end

    -- SHADER EXAMPLES
    local shader = nil
    local shaderPath = "assets/grad.glsl"
    local info = love.filesystem.getInfo(shaderPath)
    if info and info.type == "file" then
        local success, result = pcall(love.graphics.newShader, shaderPath)
        if success then
            shader = result
        end
    end

    if shader then
        local circle4 = nurture.Shape.Circle:new(N, {
            x = 380,
            y = 350,
            radius = 60,
            shader = shader,
            color = { 1, 1, 1, 1 },
            classname = "circle-shader"
        })
    end

    if shader then
        local rect4 = nurture.Shape.Rectangle:new(N, {
            x = 480,
            y = 320,
            width = 120,
            height = 80,
            shader = shader,
            color = { 1, 1, 1, 1 },
            classname = "rect-shader"
        })
    end

    if shader then
        local hexagon = nurture.Shape.Polygon:new(N, {
            vertices = {
                650, 340,
                680, 360,
                680, 390,
                650, 410,
                620, 390,
                620, 360
            },
            shader = shader,
            color = { 1, 1, 1, 1 },
            classname = "polygon-shader"
        })
    end

    local rotatingPoly = nurture.Shape.Polygon:new(N, {
        vertices = {
            70, 450,
            100, 450,
            100, 480,
            70, 480
        },
        color = { 0.9, 0.6, 0.3, 1 },
        classname = "polygon-rotating"
    })

    local polyRotTime = 0
    rotatingPoly:setUpdateCallback(function(widget, dt)
        polyRotTime = polyRotTime + dt
        local centerX = 85
        local centerY = 465
        local size = 30
        local angle = polyRotTime
        
        local vertices = {}
        for i = 0, 3 do
            local a = angle + (i / 4) * math.pi * 2
            vertices[i * 2 + 1] = centerX + math.cos(a) * size
            vertices[i * 2 + 2] = centerY + math.sin(a) * size
        end
        
        widget:setVertices(vertices)
    end)

    local colorTime = 0
    local colorCircle = nurture.Shape.Circle:new(N, {
        x = 200,
        y = 500,
        radius = 40,
        classname = "circle-color-change"
    })

    colorCircle:setUpdateCallback(function(widget, dt)
        colorTime = colorTime + dt
        local r = 0.5 + math.sin(colorTime) * 0.5
        local g = 0.5 + math.sin(colorTime + 2) * 0.5
        local b = 0.5 + math.sin(colorTime + 4) * 0.5
        widget:setColor(r, g, b, 1)
    end)
end

return {
    load = load
}


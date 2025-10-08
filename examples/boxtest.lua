local function load(nurture, N)
    local box1 = nurture.Box:new(N, {
        x = 50,
        y = 50,
        forcedWidth = 200,
        forcedHeight = 100,
        backgroundColor = { 0.2, 0.5, 0.8, 0.9 },
        rounding = 15,
        padding = 10,
        halign = "center",
        valign = "center",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "Centered Text", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    })

    local box2 = nurture.Box:new(N, {
        x = 280,
        y = 50,
        forcedWidth = 200,
        forcedHeight = 100,
        backgroundColor = { 0.8, 0.4, 0.3, 0.9 },
        rounding = 10,
        padding = 15,
        halign = "left",
        valign = "top",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "Top Left", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    })

    local box3 = nurture.Box:new(N, {
        x = 510,
        y = 50,
        forcedWidth = 200,
        forcedHeight = 100,
        backgroundColor = { 0.3, 0.8, 0.5, 0.9 },
        rounding = 20,
        padding = 15,
        halign = "right",
        valign = "bottom",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "Bottom Right", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    })

    local box4 = nurture.Box:new(N, {
        x = 50,
        y = 180,
        forcedWidth = 300,
        forcedHeight = 120,
        backgroundColor = { 1, 1, 1, 1 },
        backgroundShader = "assets/grad.glsl",
        rounding = 25,
        padding = 20,
        halign = "center",
        valign = "center",
        zIndex = 2,
        children = {
            nurture.TextLabel:new(N, "Shader Background!", "title", {
                color = { 0, 0, 0, 1 },
            })
        }
    })

    local time = 0
    box4:setUpdateCallback(function(widget, dt)
        time = time + dt * 0.5
        widget:setBackgroundShaderValue("time", time)
    end)

    local boxBack = nurture.Box:new(N, {
        x = 400,
        y = 200,
        forcedWidth = 250,
        forcedHeight = 100,
        backgroundColor = { 0.6, 0.3, 0.7, 0.8 },
        rounding = 15,
        padding = 15,
        halign = "center",
        valign = "center",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "Behind (z=1)", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    })

    local boxFront = nurture.Box:new(N, {
        x = 450,
        y = 230,
        forcedWidth = 250,
        forcedHeight = 100,
        backgroundColor = { 0.9, 0.7, 0.2, 0.9 },
        rounding = 15,
        padding = 15,
        halign = "center",
        valign = "center",
        zIndex = 3,
        children = {
            nurture.TextLabel:new(N, "In Front (z=3)", "subtitle", {
                color = { 0, 0, 0, 1 },
            })
        }
    })

    local box5 = nurture.Box:new(N, {
        x = 50,
        y = 330,
        forcedWidth = 150,
        forcedHeight = 80,
        backgroundColor = { 0.8, 0.3, 0.5, 0.9 },
        rounding = { rx = 30, ry = 10 },
        padding = 10,
        halign = "center",
        valign = "center",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "Oval Rounding", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    })

    local box6 = nurture.Box:new(N, {
        x = 230,
        y = 330,
        forcedWidth = 150,
        forcedHeight = 80,
        backgroundColor = { 0.4, 0.6, 0.8, 0.9 },
        rounding = 5,
        padding = 10,
        halign = "center",
        valign = "center",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "Small Rounding", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    })

    local box7 = nurture.Box:new(N, {
        x = 410,
        y = 330,
        forcedWidth = 150,
        forcedHeight = 80,
        backgroundColor = { 0.5, 0.3, 0.8, 0.9 },
        rounding = 40,
        padding = 10,
        halign = "center",
        valign = "center",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "Large Rounding", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    })
end

return {
    load = load
}


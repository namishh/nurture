local function load(nurture, N)
    local textLabel1 = nurture.TextLabel:new(N, "Normal Text", "BodyFont", {
        color = { 1, 1, 1, 1 }
    })
    textLabel1:setPosition(100, 50)

    local textLabel2 = nurture.TextLabel:new(N, "Rotated 45°", "BodyFont", {
        color = { 1, 0.5, 0.5, 1 }
    })
    textLabel2:setPosition(250, 50)
    textLabel2.rotation = math.rad(45)
    textLabel2.scaleX = 1
    textLabel2.scaleY = 1

    local textLabel3 = nurture.TextLabel:new(N, "Scaled 1.5x", "BodyFont", {
        color = { 0.5, 1, 0.5, 1 }
    })
    textLabel3:setPosition(400, 50)
    textLabel3.rotation = 0
    textLabel3.scaleX = 1.5
    textLabel3.scaleY = 1.5

    local textLabel4 = nurture.TextLabel:new(N, "Both!", "BodyFont", {
        color = { 0.5, 0.5, 1, 1 }
    })
    textLabel4:setPosition(580, 50)
    textLabel4.rotation = math.rad(-30)
    textLabel4.scaleX = 1.3
    textLabel4.scaleY = 1.3

    local box1 = nurture.Box:new(N, {
        x = 100,
        y = 120,
        forcedWidth = 100,
        forcedHeight = 60,
        backgroundColor = { 0.8, 0.3, 0.3, 0.9 },
        rounding = 10
    })
    box1.rotation = 0
    box1.scaleX = 1
    box1.scaleY = 1

    local box2 = nurture.Box:new(N, {
        x = 250,
        y = 120,
        forcedWidth = 100,
        forcedHeight = 60,
        backgroundColor = { 0.3, 0.8, 0.3, 0.9 },
        rounding = 10
    })
    box2.rotation = math.rad(25)
    box2.scaleX = 1
    box2.scaleY = 1

    local box3 = nurture.Box:new(N, {
        x = 400,
        y = 120,
        forcedWidth = 100,
        forcedHeight = 60,
        backgroundColor = { 0.3, 0.3, 0.8, 0.9 },
        rounding = 10
    })
    box3.rotation = 0
    box3.scaleX = 1.2
    box3.scaleY = 0.8

    local box4 = nurture.Box:new(N, {
        x = 550,
        y = 120,
        forcedWidth = 100,
        forcedHeight = 60,
        backgroundColor = { 0.8, 0.8, 0.3, 0.9 },
        rounding = 10
    })
    box4.rotation = math.rad(-20)
    box4.scaleX = 1.3
    box4.scaleY = 1.3

    local box5 = nurture.Box:new(N, {
        x = 100,
        y = 230,
        forcedWidth = 120,
        forcedHeight = 80,
        backgroundColor = { 0.6, 0.4, 0.8, 0.9 },
        rounding = 10,
        padding = 10,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "Normal", "BodyFont", {
                color = { 1, 1, 1, 1 }
            })
        }
    })
    box5.rotation = 0
    box5.scaleX = 1
    box5.scaleY = 1

    local box6 = nurture.Box:new(N, {
        x = 260,
        y = 230,
        forcedWidth = 120,
        forcedHeight = 80,
        backgroundColor = { 0.8, 0.4, 0.6, 0.9 },
        rounding = 10,
        padding = 10,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "Rotated", "BodyFont", {
                color = { 1, 1, 1, 1 }
            })
        }
    })
    box6.rotation = math.rad(30)
    box6.scaleX = 1
    box6.scaleY = 1

    local box7 = nurture.Box:new(N, {
        x = 420,
        y = 230,
        forcedWidth = 120,
        forcedHeight = 80,
        backgroundColor = { 0.4, 0.8, 0.8, 0.9 },
        rounding = 10,
        padding = 10,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "Scaled", "BodyFont", {
                color = { 1, 1, 1, 1 }
            })
        }
    })
    box7.rotation = 0
    box7.scaleX = 1.4
    box7.scaleY = 1.4

    local button1 = nurture.Button:new(N, {
        x = 100,
        y = 360,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.9, 0.5, 0.2, 1.0 },
            hoveredColor = { 1.0, 0.6, 0.3, 1.0 },
            pressedColor = { 0.8, 0.4, 0.1, 1.0 }
        },
        onClick = function(btn)
            print("Normal button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Click", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    button1.rotation = 0
    button1.scaleX = 1
    button1.scaleY = 1

    local button2 = nurture.Button:new(N, {
        x = 220,
        y = 360,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.2, 0.7, 0.5, 1.0 },
            hoveredColor = { 0.3, 0.8, 0.6, 1.0 },
            pressedColor = { 0.1, 0.6, 0.4, 1.0 }
        },
        onClick = function(btn)
            print("Rotated button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Rotated", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    button2.rotation = math.rad(15)
    button2.scaleX = 1
    button2.scaleY = 1

    local button3 = nurture.Button:new(N, {
        x = 360,
        y = 360,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.7, 0.3, 0.7, 1.0 },
            hoveredColor = { 0.8, 0.4, 0.8, 1.0 },
            pressedColor = { 0.6, 0.2, 0.6, 1.0 }
        },
        onClick = function(btn)
            print("Scaled button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Big!", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    button3.rotation = 0
    button3.scaleX = 1.5
    button3.scaleY = 1.5

    local hbox1 = nurture.HBox:new(N, {
        x = 100,
        y = 460,
        spacing = 8,
        padding = 0,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "H1", "BodyFont", { color = { 1, 0.5, 0.5, 1 } }),
            nurture.TextLabel:new(N, "H2", "BodyFont", { color = { 0.5, 1, 0.5, 1 } }),
            nurture.TextLabel:new(N, "H3", "BodyFont", { color = { 0.5, 0.5, 1, 1 } })
        }
    })
    hbox1.rotation = 0
    hbox1.scaleX = 1
    hbox1.scaleY = 1

    local hbox2 = nurture.HBox:new(N, {
        x = 300,
        y = 460,
        spacing = 8,
        padding = 0,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "A", "BodyFont", { color = { 1, 1, 0.5, 1 } }),
            nurture.TextLabel:new(N, "B", "BodyFont", { color = { 1, 0.5, 1, 1 } }),
            nurture.TextLabel:new(N, "C", "BodyFont", { color = { 0.5, 1, 1, 1 } })
        }
    })
    hbox2.rotation = math.rad(20)
    hbox2.scaleX = 1.2
    hbox2.scaleY = 1.2

    local vbox1 = nurture.VBox:new(N, {
        x = 500,
        y = 460,
        spacing = 5,
        padding = 0,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "V1", "BodyFont", { color = { 1, 0.8, 0.5, 1 } }),
            nurture.TextLabel:new(N, "V2", "BodyFont", { color = { 0.5, 0.8, 1, 1 } }),
            nurture.TextLabel:new(N, "V3", "BodyFont", { color = { 0.8, 0.5, 1, 1 } })
        }
    })
    vbox1.rotation = 0
    vbox1.scaleX = 1
    vbox1.scaleY = 1

    local vbox2 = nurture.VBox:new(N, {
        x = 600,
        y = 460,
        spacing = 5,
        padding = 0,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "X", "BodyFont", { color = { 1, 0.6, 0.6, 1 } }),
            nurture.TextLabel:new(N, "Y", "BodyFont", { color = { 0.6, 1, 0.6, 1 } }),
            nurture.TextLabel:new(N, "Z", "BodyFont", { color = { 0.6, 0.6, 1, 1 } })
        }
    })
    vbox2.rotation = math.rad(-25)
    vbox2.scaleX = 1.3
    vbox2.scaleY = 1.3

    local hboxChild = nurture.HBox:new(N, {
        spacing = 10,
        padding = 0,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "🎮", "BodyFont", { color = { 1, 0.8, 0.2, 1 } }),
            nurture.TextLabel:new(N, "Complex", "BodyFont", { color = { 1, 1, 1, 1 } })
        }
    })

    local complexButton = nurture.Button:new(N, {
        x = 500,
        y = 360,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.2, 0.5, 0.8, 1.0 },
            hoveredColor = { 0.3, 0.6, 0.9, 1.0 },
            pressedColor = { 0.1, 0.4, 0.7, 1.0 }
        },
        onClick = function(btn)
            print("Complex button clicked!")
        end,
        child = hboxChild
    })
    complexButton.rotation = math.rad(-10)
    complexButton.scaleX = 1.1
    complexButton.scaleY = 1.1

    local animBox1 = nurture.Box:new(N, {
        x = 100,
        y = 570,
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 1, 0.5, 0.5, 0.9 },
        rounding = 5
    })
    animBox1.rotation = 0
    animBox1.scaleX = 1
    animBox1.scaleY = 1
    animBox1:setUpdateCallback(function(widget, dt)
        widget.rotation = widget.rotation + dt * 2
    end)

    local animBox2 = nurture.Box:new(N, {
        x = 200,
        y = 570,
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 0.5, 1, 0.5, 0.9 },
        rounding = 5
    })
    animBox2.rotation = 0
    animBox2.scaleX = 1
    animBox2.scaleY = 1
    animBox2:setUpdateCallback(function(widget, dt)
        widget.rotation = widget.rotation - dt * 1.5
        widget.scaleX = 1 + math.sin(love.timer.getTime() * 2) * 0.3
        widget.scaleY = 1 + math.sin(love.timer.getTime() * 2) * 0.3
    end)

    local animBox3 = nurture.Box:new(N, {
        x = 300,
        y = 570,
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 0.5, 0.5, 1, 0.9 },
        rounding = 5,
        padding = 10,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "Hi", "BodyFont", {
                color = { 1, 1, 1, 1 }
            })
        }
    })
    animBox3.rotation = 0
    animBox3.scaleX = 1
    animBox3.scaleY = 1
    animBox3:setUpdateCallback(function(widget, dt)
        widget.rotation = widget.rotation + dt * 3
        widget.scaleX = 1 + math.cos(love.timer.getTime() * 3) * 0.2
        widget.scaleY = 1 + math.sin(love.timer.getTime() * 3) * 0.2
    end)

    local pulseButton = nurture.Button:new(N, {
        x = 400,
        y = 560,
        padding = 20,
        rounding = 15,
        colors = {
            primaryColor = { 0.9, 0.3, 0.5, 1.0 },
            hoveredColor = { 1.0, 0.4, 0.6, 1.0 },
            pressedColor = { 0.8, 0.2, 0.4, 1.0 }
        },
        onClick = function(btn)
            print("Pulse button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Pulse", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    pulseButton.rotation = 0
    pulseButton.scaleX = 1
    pulseButton.scaleY = 1
    pulseButton:setUpdateCallback(function(widget, dt)
        local pulse = 1 + math.sin(love.timer.getTime() * 4) * 0.15
        widget.scaleX = pulse
        widget.scaleY = pulse
    end)

    -- Spinning text
    local spinText = nurture.TextLabel:new(N, "Spinning!", "subtitle", {
        color = { 1, 0.8, 0.2, 1 }
    })
    spinText:setPosition(550, 580)
    spinText.rotation = 0
    spinText.scaleX = 1
    spinText.scaleY = 1
    spinText:setUpdateCallback(function(widget, dt)
        widget.rotation = widget.rotation + dt * 4
    end)

    -- Labels
    local label1 = nurture.TextLabel:new(N, "TextLabels:", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    label1:setPosition(10, 50)

    local label2 = nurture.TextLabel:new(N, "Boxes (no children):", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    label2:setPosition(10, 140)

    local label3 = nurture.TextLabel:new(N, "Boxes (with children):", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    label3:setPosition(10, 250)

    local label4 = nurture.TextLabel:new(N, "Buttons:", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    label4:setPosition(10, 380)

    local label5 = nurture.TextLabel:new(N, "HBox & VBox:", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    label5:setPosition(10, 475)

    local label6 = nurture.TextLabel:new(N, "Animated:", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    label6:setPosition(10, 585)
end

return {
    load = load
}


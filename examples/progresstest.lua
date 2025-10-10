local function load(nurture, N)
    local basicProgress = nurture.Progress:new(N, {
        x = 50,
        y = 60,
        value = 35,
        maxValue = 100,
        text = {
            visible = true,
            label = "Mana"
        }
    })

    local coloredProgress = nurture.Progress:new(N, {
        x = 50,
        y = 120,
        forcedWidth = 300,
        forcedHeight = 25,
        value = 65,
        maxValue = 100,
        color = {
            background = { 0.2, 0.2, 0.3, 1.0 },
            color = { 0.8, 0.3, 0.3, 1.0 },
            shadow = { 0, 0, 0, 0.5 }
        }
    })

    local styledProgress = nurture.Progress:new(N, {
        x = 50,
        y = 180,
        forcedWidth = 250,
        forcedHeight = 30,
        value = 80,
        maxValue = 100,
        color = {
            background = { 0.1, 0.1, 0.1, 0.9 },
            color = { 0.2, 0.8, 0.4, 1.0 },
            shadow = { 0.1, 0.1, 0.1, 0.8 }
        },
        text = {
            visible = true,
            fontName = "BodyFont",
            color = { 1, 1, 1, 1 },
            horizAlign = "center",
            vertAlign = "center",
            shadow = {
                x = 1,
                y = 1,
                color = { 0, 0, 0, 0.8 }
            }
        }
    })

    local animatedProgress = nurture.Progress:new(N, {
        x = 50,
        y = 300,
        forcedWidth = 280,
        forcedHeight = 20,
        value = 0,
        maxValue = 100,
        text = {
            visible = true,
        },
        color = {
            background = { 0.2, 0.2, 0.4, 1.0 },
            color = { 0.4, 0.6, 0.9, 1.0 },
            shadow = { 0.1, 0.1, 0.2, 0.6 }
        }
    })

    animatedProgress:setUpdateCallback(function(widget, dt)
        widget.value = widget.value + dt * 15
        if widget.value > widget.maxValue then
            widget.value = 0
        end
    end)

    local verticalProgress1 = nurture.Progress:new(N, {
        x = 450,
        y = 60,
        forcedWidth = 25,
        forcedHeight = 150,
        value = 70,
        maxValue = 100,
        orientation = "vertical",
        fill = "start", -- top to bottom
        color = {
            background = { 0.2, 0.3, 0.2, 1.0 },
            color = { 0.3, 0.7, 0.3, 1.0 }
        }
    })

    local verticalProgress2 = nurture.Progress:new(N, {
        x = 500,
        y = 60,
        forcedWidth = 25,
        forcedHeight = 150,
        value = 40,
        maxValue = 100,
        orientation = "vertical",
        fill = "end", -- bottom to top
        color = {
            background = { 0.3, 0.2, 0.2, 1.0 },
            color = { 0.8, 0.4, 0.4, 1.0 }
        }
    })

    local horizontalStartProgress = nurture.Progress:new(N, {
        x = 550,
        y = 60,
        forcedWidth = 150,
        forcedHeight = 20,
        value = 60,
        maxValue = 100,
        orientation = "horizontal",
        fill = "start", -- left to right
        color = {
            background = { 0.2, 0.2, 0.5, 1.0 },
            color = { 0.4, 0.4, 0.9, 1.0 }
        }
    })

    local horizontalEndProgress = nurture.Progress:new(N, {
        x = 550,
        y = 90,
        forcedWidth = 150,
        forcedHeight = 20,
        value = 75,
        maxValue = 100,
        orientation = "horizontal",
        fill = "end", -- right to left
        color = {
            background = { 0.5, 0.2, 0.5, 1.0 },
            color = { 0.9, 0.4, 0.9, 1.0 }
        }
    })

    local verticalProgress3 = nurture.Progress:new(N, {
        x = 550,
        y = 140,
        forcedWidth = 30,
        forcedHeight = 100,
        value = 85,
        maxValue = 100,
        orientation = "vertical",
        fill = "start",
        color = {
            background = { 0.2, 0.2, 0.5, 1.0 },
            color = { 0.4, 0.4, 0.9, 1.0 }
        },
        text = {
            visible = false
        }
    })

    local verticalProgress4 = nurture.Progress:new(N, {
        x = 600,
        y = 140,
        forcedWidth = 30,
        forcedHeight = 100,
        value = 30,
        maxValue = 100,
        orientation = "vertical",
        fill = "end",
        color = {
            background = { 0.5, 0.5, 0.2, 1.0 },
            color = { 0.9, 0.9, 0.4, 1.0 }
        },
        text = {
            visible = false
        }
    })

    local healthBar = nurture.Progress:new(N, {
        x = 50,
        y = 380,
        forcedWidth = 200,
        forcedHeight = 25,
        value = 85,
        maxValue = 100,
        color = {
            background = { 0.2, 0.1, 0.1, 0.9 },
            color = { 0.8, 0.2, 0.2, 1.0 },
            shadow = { 0.1, 0.05, 0.05, 0.8 }
        },
        text = {
            visible = true,
            color = { 1, 1, 1, 1 },
            horizAlign = "center",
            vertAlign = "center"
        }
    })

    local manaBar = nurture.Progress:new(N, {
        x = 50,
        y = 420,
        forcedWidth = 200,
        forcedHeight = 25,
        value = 42,
        maxValue = 100,
        color = {
            background = { 0.1, 0.1, 0.2, 0.9 },
            color = { 0.2, 0.4, 0.9, 1.0 },
            shadow = { 0.05, 0.05, 0.1, 0.8 }
        },
        text = {
            visible = true,
            color = { 1, 1, 1, 1 },
            horizAlign = "center",
            vertAlign = "center"
        }
    })

    local interactiveProgress = nurture.Progress:new(N, {
        x = 50,
        y = 480,
        forcedWidth = 250,
        forcedHeight = 30,
        value = 50,
        maxValue = 100,
        color = {
            background = { 0.2, 0.2, 0.2, 1.0 },
            color = { 0.6, 0.3, 0.8, 1.0 },
            shadow = { 0.1, 0.1, 0.1, 0.6 }
        }
    })

    local decreaseBtn = nurture.Button:new(N, {
        x = 50,
        y = 520,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.8, 0.3, 0.3, 1.0 },
            hoveredColor = { 0.9, 0.4, 0.4, 1.0 },
            pressedColor = { 0.7, 0.2, 0.2, 1.0 }
        },
        onClick = function(btn)
            interactiveProgress.value = math.max(0, interactiveProgress.value - 10)
        end,
        child = nurture.TextLabel:new(N, "-10", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local increaseBtn = nurture.Button:new(N, {
        x = 120,
        y = 520,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.3, 0.8, 0.3, 1.0 },
            hoveredColor = { 0.4, 0.9, 0.4, 1.0 },
            pressedColor = { 0.2, 0.7, 0.2, 1.0 }
        },
        onClick = function(btn)
            interactiveProgress.value = math.min(interactiveProgress.maxValue, interactiveProgress.value + 10)
        end,
        child = nurture.TextLabel:new(N, "+10", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local resetBtn = nurture.Button:new(N, {
        x = 190,
        y = 520,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.5, 0.5, 0.5, 1.0 },
            hoveredColor = { 0.6, 0.6, 0.6, 1.0 },
            pressedColor = { 0.4, 0.4, 0.4, 1.0 }
        },
        onClick = function(btn)
            interactiveProgress.value = 50
        end,
        child = nurture.TextLabel:new(N, "Reset", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local customMaxProgress = nurture.Progress:new(N, {
        x = 450,
        y = 380,
        forcedWidth = 200,
        forcedHeight = 25,
        value = 150,
        maxValue = 200,
        color = {
            background = { 0.2, 0.3, 0.3, 1.0 },
            color = { 0.3, 0.8, 0.8, 1.0 }
        }
    })

    local basicLabel = nurture.TextLabel:new(N, "Basic Progress (35%)", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    basicLabel:setPosition(50, 35)

    local coloredLabel = nurture.TextLabel:new(N, "Custom Colors (65%)", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    coloredLabel:setPosition(50, 95)

    local styledLabel = nurture.TextLabel:new(N, "Styled Text with Shadow (80%)", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    styledLabel:setPosition(50, 155)


    local animatedLabel = nurture.TextLabel:new(N, "Animated Progress", "BodyFont", {
        color = { 1, 1, 0.5, 1 }
    })
    animatedLabel:setPosition(50, 275)


    local moreVerticalLabel = nurture.TextLabel:new(N, "More Vertical Examples", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    moreVerticalLabel:setPosition(550, 115)

    local rpgLabel = nurture.TextLabel:new(N, "RPG Style Bars", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    rpgLabel:setPosition(50, 355)

    local healthLabel = nurture.TextLabel:new(N, "Health", "BodyFont", {
        color = { 0.8, 0.2, 0.2, 1 }
    })
    healthLabel:setPosition(10, 385)

    local manaLabel = nurture.TextLabel:new(N, "Mana", "BodyFont", {
        color = { 0.2, 0.4, 0.9, 1 }
    })
    manaLabel:setPosition(10, 425)

    local interactiveLabel = nurture.TextLabel:new(N, "Interactive Progress", "BodyFont", {
        color = { 1, 1, 0.5, 1 }
    })
    interactiveLabel:setPosition(50, 455)

    local customMaxLabel = nurture.TextLabel:new(N, "Custom Max Value (150/200)", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    customMaxLabel:setPosition(450, 355)

    local toggleOrientationBtn = nurture.Button:new(N, {
        x = 260,
        y = 520,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.3, 0.3, 0.8, 1.0 },
            hoveredColor = { 0.4, 0.4, 0.9, 1.0 },
            pressedColor = { 0.2, 0.2, 0.7, 1.0 }
        },
        onClick = function(btn)
            if interactiveProgress.orientation == "horizontal" then
                interactiveProgress:setOrientation("vertical")
                interactiveProgress:setForcedSize(30, 250)
            else
                interactiveProgress:setOrientation("horizontal")
                interactiveProgress:setForcedSize(250, 30)
            end
        end,
        child = nurture.TextLabel:new(N, "Toggle Orient", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local toggleFillBtn = nurture.Button:new(N, {
        x = 370,
        y = 520,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.8, 0.3, 0.8, 1.0 },
            hoveredColor = { 0.9, 0.4, 0.9, 1.0 },
            pressedColor = { 0.7, 0.2, 0.7, 1.0 }
        },
        onClick = function(btn)
            if interactiveProgress.fill == "start" then
                interactiveProgress:setFill("end")
            else
                interactiveProgress:setFill("start")
            end
        end,
        child = nurture.TextLabel:new(N, "Toggle Fill", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local instructionLabel = nurture.TextLabel:new(N, "Use buttons to control interactive progress bar:", "BodyFont", {
        color = { 0.8, 0.8, 0.8, 0.7 }
    })
    instructionLabel:setPosition(50, 560)

end

return {
    load = load
}

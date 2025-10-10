local function load(nurture, N)
    local basicKnob = nurture.Shape.Rectangle:new(N, {
        width = 20,
        height = 30,
        color = { 0.9, 0.9, 0.9, 1.0 },
        rx = 5,
        ry = 5
    })

    local basicSlider = nurture.Slider:new(N, {
        x = 50,
        y = 60,
        width = 250,
        height = 15,
        minValue = 0,
        maxValue = 100,
        value = 50,
        trackColor = { 0.3, 0.3, 0.3, 1.0 },
        trackRounding = 7,
        fillColor = { 0.4, 0.6, 0.9, 1.0 },
        fillType = "left",
        knob = basicKnob,
        onValueChange = function(slider, value)
            print("Basic slider value: " .. math.floor(value))
        end
    })

    -- Slider with image as knob
    local imageKnob = nurture.Image:new(N, "assets/image.jpeg", {
        forcedWidth = 30,
        forcedHeight = 30
    })

    local imageSlider = nurture.Slider:new(N, {
        x = 50,
        y = 120,
        width = 250,
        height = 15,
        minValue = 0,
        maxValue = 100,
        value = 25,
        trackColor = { 0.25, 0.25, 0.35, 1.0 },
        trackRounding = 7,
        fillColor = { 0.8, 0.4, 0.6, 1.0 },
        fillType = "left",
        knob = imageKnob,
        onValueChange = function(slider, value)
            print("Image slider value: " .. math.floor(value))
        end
    })

    local ridgedKnob = nurture.Box:new(N, {
        padding = {
            top = 5,
            bottom = 5,
            left = 8,
            right = 8
        },
        rounding = 5,
        backgroundColor = { 0.3, 0.3, 0.3, 1.0 },
        children = {
            nurture.VBox:new(N, {
                spacing = 3,
                children = {
                    nurture.Shape.Rectangle:new(N, {
                        width = 18,
                        height = 2,
                        color = { 0.8, 0.8, 0.8, 1.0 },
                        rx = 1,
                        ry = 1
                    }),
                    nurture.Shape.Rectangle:new(N, {
                        width = 18,
                        height = 2,
                        color = { 0.8, 0.8, 0.8, 1.0 },
                        rx = 1,
                        ry = 1
                    }),
                    nurture.Shape.Rectangle:new(N, {
                        width = 18,
                        height = 2,
                        color = { 0.8, 0.8, 0.8, 1.0 },
                        rx = 1,
                        ry = 1
                    })
                }
            })
        }
    })

    local ridgedSlider = nurture.Slider:new(N, {
        x = 50,
        y = 180,
        width = 250,
        height = 15,
        minValue = 0,
        maxValue = 100,
        value = 75,
        trackColor = { 0.2, 0.3, 0.2, 1.0 },
        trackRounding = 7,
        fillColor = { 0.4, 0.8, 0.5, 1.0 },
        fillType = "left",
        knob = ridgedKnob,
        onValueChange = function(slider, value)
            print("Ridged slider value: " .. math.floor(value))
        end
    })

    local circleKnob = nurture.Shape.Circle:new(N, {
        radius = 15,
        color = { 0.9, 0.7, 0.3, 1.0 },
        segments = 32
    })

    local noFillSlider = nurture.Slider:new(N, {
        x = 50,
        y = 240,
        width = 250,
        height = 15,
        minValue = 0,
        maxValue = 100,
        value = 50,
        trackColor = { 0.3, 0.3, 0.3, 1.0 },
        trackRounding = 7,
        fillColor = { 0.9, 0.7, 0.3, 0.7 },
        fillType = "none",
        knob = circleKnob,
        onValueChange = function(slider, value)
            print("No fill slider value: " .. math.floor(value))
        end
    })

    -- Right fill slider
    local rightFillKnob = nurture.Shape.Rectangle:new(N, {
        width = 18,
        height = 28,
        color = { 0.8, 0.3, 0.3, 1.0 },
        rx = 4,
        ry = 4
    })

    local rightFillSlider = nurture.Slider:new(N, {
        x = 50,
        y = 300,
        width = 250,
        height = 15,
        minValue = 0,
        maxValue = 100,
        value = 35,
        trackColor = { 0.3, 0.3, 0.3, 1.0 },
        trackRounding = 7,
        fillColor = { 0.8, 0.3, 0.3, 0.7 },
        fillType = "right",
        knob = rightFillKnob,
        onValueChange = function(slider, value)
            print("Right fill slider value: " .. math.floor(value))
        end
    })

    -- VERTICAL SLIDERS

    -- Basic vertical slider
    local vertKnob1 = nurture.Shape.Rectangle:new(N, {
        width = 30,
        height = 20,
        color = { 0.9, 0.9, 0.9, 1.0 },
        rx = 5,
        ry = 5
    })

    local verticalSlider1 = nurture.Slider:new(N, {
        x = 400,
        y = 60,
        width = 20,
        height = 200,
        orientation = "vertical",
        minValue = 0,
        maxValue = 100,
        value = 60,
        trackColor = { 0.3, 0.3, 0.3, 1.0 },
        trackRounding = 10,
        fillColor = { 0.5, 0.4, 0.8, 1.0 },
        fillType = "top",
        knob = vertKnob1,
        onValueChange = function(slider, value)
            print("Vertical slider 1 value: " .. math.floor(value))
        end
    })

    local vertRidgedKnob = nurture.Box:new(N, {
        padding = {
            top = 5,
            bottom = 5,
            left = 8,
            right = 8
        },
        rounding = 5,
        backgroundColor = { 0.3, 0.3, 0.3, 1.0 },
        children = {
            nurture.VBox:new(N, {
                spacing = 3,
                children = {
                    nurture.Shape.Rectangle:new(N, {
                        width = 28,
                        height = 3,
                        color = { 0.9, 0.6, 0.3, 1.0 },
                        rx = 1.5,
                        ry = 1.5
                    }),
                    nurture.Shape.Rectangle:new(N, {
                        width = 28,
                        height = 3,
                        color = { 0.9, 0.6, 0.3, 1.0 },
                        rx = 1.5,
                        ry = 1.5
                    }),
                    nurture.Shape.Rectangle:new(N, {
                        width = 28,
                        height = 3,
                        color = { 0.9, 0.6, 0.3, 1.0 },
                        rx = 1.5,
                        ry = 1.5
                    })
                }
            })
        }
    })


    local verticalSlider2 = nurture.Slider:new(N, {
        x = 470,
        y = 60,
        width = 20,
        height = 200,
        orientation = "vertical",
        minValue = 0,
        maxValue = 100,
        value = 40,
        trackColor = { 0.35, 0.25, 0.2, 1.0 },
        trackRounding = 10,
        fillColor = { 0.9, 0.6, 0.3, 0.8 },
        fillType = "bottom",
        knob = vertRidgedKnob,
        onValueChange = function(slider, value)
            print("Vertical ridged slider value: " .. math.floor(value))
        end
    })

    local vertImageKnob = nurture.Image:new(N, "assets/image.jpeg", {
        forcedWidth = 35,
        forcedHeight = 25
    })

    local verticalSlider3 = nurture.Slider:new(N, {
        x = 550,
        y = 60,
        width = 20,
        height = 200,
        orientation = "vertical",
        minValue = 0,
        maxValue = 100,
        value = 80,
        trackColor = { 0.2, 0.3, 0.35, 1.0 },
        trackRounding = 10,
        fillColor = { 0.3, 0.8, 0.8, 0.8 },
        fillType = "top",
        knob = vertImageKnob,
        onValueChange = function(slider, value)
            print("Vertical image slider value: " .. math.floor(value))
        end
    })

    -- Vertical slider with circular knob and top fill
    local vertCircleKnob = nurture.Shape.Circle:new(N, {
        radius = 12,
        color = { 0.3, 0.9, 0.4, 1.0 },
        segments = 32
    })

    local verticalSlider4 = nurture.Slider:new(N, {
        x = 630,
        y = 60,
        width = 20,
        height = 200,
        orientation = "vertical",
        minValue = 0,
        maxValue = 100,
        value = 50,
        trackColor = { 0.3, 0.3, 0.3, 1.0 },
        trackRounding = 10,
        fillColor = { 0.3, 0.9, 0.4, 0.6 },
        fillType = "top",
        knob = vertCircleKnob,
        onValueChange = function(slider, value)
            print("Vertical circle slider value: " .. math.floor(value))
        end
    })

    -- Volume control example with animated indicator
    local volumeKnob = nurture.Shape.Rectangle:new(N, {
        width = 25,
        height = 35,
        color = { 0.2, 0.7, 0.9, 1.0 },
        rx = 6,
        ry = 6
    })

    local volumeSlider = nurture.Slider:new(N, {
        x = 50,
        y = 380,
        width = 300,
        height = 20,
        minValue = 0,
        maxValue = 100,
        value = 70,
        trackColor = { 0.2, 0.2, 0.25, 1.0 },
        trackRounding = 10,
        fillColor = { 0.2, 0.7, 0.9, 0.7 },
        fillType = "left",
        knob = volumeKnob,
        onValueChange = function(slider, value)
            print("Volume: " .. math.floor(value) .. "%")
        end
    })

    -- Step slider with larger step size
    local stepKnob = nurture.Shape.Rectangle:new(N, {
        width = 20,
        height = 30,
        color = { 0.8, 0.5, 0.8, 1.0 },
        rx = 0,
        ry = 0
    })

    local stepSlider = nurture.Slider:new(N, {
        x = 50,
        y = 450,
        width = 300,
        height = 20,
        minValue = 0,
        maxValue = 100,
        value = 5,
        stepSize = 10,
        trackColor = { 0.3, 0.3, 0.3, 1.0 },
        trackRounding = 0,
        fillColor = { 0.8, 0.5, 0.8, 0.7 },
        fillType = "left",
        knob = stepKnob,
        onValueChange = function(slider, value)
            print("Step value: " .. math.floor(value))
        end
    })

    -- Labels for all sliders
    local labels = {
        { text = "Basic Horizontal Slider",      x = 50,  y = 35 },
        { text = "Slider with Image Knob",       x = 50,  y = 95 },
        { text = "Slider with Ridged VBox Knob", x = 50,  y = 155 },
        { text = "No Fill Slider",               x = 50,  y = 215 },
        { text = "Right Fill Slider",            x = 50,  y = 275 },
        { text = "Volume Control (0-100)",       x = 50,  y = 355 },
        { text = "Step Slider (steps of 10)",    x = 50,  y = 425 },
        { text = "Vertical",                     x = 385, y = 35 },
        { text = "Vert+Ridged",                  x = 445, y = 35 },
        { text = "Vert+Image",                   x = 520, y = 35 },
        { text = "Vert+Circle",                  x = 600, y = 35 },
    }

    for _, labelData in ipairs(labels) do
        local label = nurture.TextLabel:new(N, labelData.text, "BodyFont", {
            color = { 1, 1, 1, 0.8 }
        })
        label:setPosition(labelData.x, labelData.y)
    end

    -- Interactive buttons to control a slider
    local targetSlider = basicSlider

    local resetBtn = nurture.Button:new(N, {
        x = 50,
        y = 500,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.5, 0.5, 0.5, 1.0 },
            hoveredColor = { 0.6, 0.6, 0.6, 1.0 },
            pressedColor = { 0.4, 0.4, 0.4, 1.0 }
        },
        onClick = function(btn)
            basicSlider:setValue(50)
            imageSlider:setValue(25)
            ridgedSlider:setValue(75)
            noFillSlider:setValue(50)
            rightFillSlider:setValue(35)
        end,
        child = nurture.TextLabel:new(N, "Reset All", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local minBtn = nurture.Button:new(N, {
        x = 150,
        y = 500,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.8, 0.3, 0.3, 1.0 },
            hoveredColor = { 0.9, 0.4, 0.4, 1.0 },
            pressedColor = { 0.7, 0.2, 0.2, 1.0 }
        },
        onClick = function(btn)
            basicSlider:setValue(0)
        end,
        child = nurture.TextLabel:new(N, "Min", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local maxBtn = nurture.Button:new(N, {
        x = 210,
        y = 500,
        padding = 8,
        rounding = 5,
        colors = {
            primaryColor = { 0.3, 0.8, 0.3, 1.0 },
            hoveredColor = { 0.4, 0.9, 0.4, 1.0 },
            pressedColor = { 0.2, 0.7, 0.2, 1.0 }
        },
        onClick = function(btn)
            basicSlider:setValue(100)
        end,
        child = nurture.TextLabel:new(N, "Max", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    -- Instructions
    local instructions = nurture.TextLabel:new(N,
        "Drag sliders to change values. Check console for value updates.", "BodyFont", {
            color = { 1, 1, 1, 0.6 }
        })
    instructions:setPosition(50, 545)
end

return {
    load = load
}

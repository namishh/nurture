local function load(nurture, N)
    local redBox = nurture.Box:new(N, {
        forcedWidth = 150,
        forcedHeight = 100,
        backgroundColor = { 0.8, 0.2, 0.2, 0.8 },
        rounding = 10,
        classname = "red_box",
        child = nurture.TextLabel:new(N, "Red Box", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local blueBox = nurture.Box:new(N, {
        forcedWidth = 120,
        forcedHeight = 80,
        backgroundColor = { 0.2, 0.2, 0.8, 0.8 },
        rounding = 10,
        classname = "blue_box",
        child = nurture.TextLabel:new(N, "Blue Box", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local greenBox = nurture.Box:new(N, {
        forcedWidth = 100,
        forcedHeight = 60,
        backgroundColor = { 0.2, 0.8, 0.2, 0.8 },
        rounding = 10,
        classname = "green_box",
        child = nurture.TextLabel:new(N, "Green Box", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local stack1 = nurture.Stack:new(N, {
        x = 50,
        y = 50,
        forcedWidth = 200,
        forcedHeight = 150,
        children = { redBox, blueBox, greenBox }
    })

    local yellowBox = nurture.Box:new(N, {
        forcedWidth = 80,
        forcedHeight = 50,
        backgroundColor = { 0.9, 0.9, 0.2, 0.8 },
        rounding = 5,
        child = nurture.TextLabel:new(N, "Center", "BodyFont", {
            color = { 0, 0, 0, 1 }
        })
    })
    yellowBox.stackHorizAlign = "center"
    yellowBox.stackVertAlign = "center"

    local purpleBox = nurture.Box:new(N, {
        forcedWidth = 60,
        forcedHeight = 40,
        backgroundColor = { 0.8, 0.2, 0.8, 0.8 },
        rounding = 5,
        child = nurture.TextLabel:new(N, "BR", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    purpleBox.stackHorizAlign = "right"
    purpleBox.stackVertAlign = "bottom"

    local cyanBox = nurture.Box:new(N, {
        forcedWidth = 70,
        forcedHeight = 35,
        backgroundColor = { 0.2, 0.8, 0.8, 0.8 },
        rounding = 5,
        child = nurture.TextLabel:new(N, "TL", "BodyFont", {
            color = { 0, 0, 0, 1 }
        })
    })
    cyanBox.stackHorizAlign = "left"
    cyanBox.stackVertAlign = "top"

    local stack2 = nurture.Stack:new(N, {
        x = 300,
        y = 50,
        forcedWidth = 200,
        forcedHeight = 150,
        children = { yellowBox, purpleBox, cyanBox }
    })

    local hboxContent = nurture.HBox:new(N, {
        spacing = 10,
        children = {
            nurture.TextLabel:new(N, "H1", "BodyFont", { color = { 1, 0.5, 0.5, 1 } }),
            nurture.TextLabel:new(N, "H2", "BodyFont", { color = { 0.5, 1, 0.5, 1 } }),
            nurture.TextLabel:new(N, "H3", "BodyFont", { color = { 0.5, 0.5, 1, 1 } })
        }
    })

    local vboxContent = nurture.VBox:new(N, {
        spacing = 5,
        children = {
            nurture.TextLabel:new(N, "V1", "BodyFont", { color = { 1, 1, 0.5, 1 } }),
            nurture.TextLabel:new(N, "V2", "BodyFont", { color = { 0.5, 1, 1, 1 } }),
            nurture.TextLabel:new(N, "V3", "BodyFont", { color = { 1, 0.5, 1, 1 } })
        }
    })

    local backgroundBox = nurture.Box:new(N, {
        backgroundColor = { 0.1, 0.1, 0.1, 0.9 },
        rounding = 8,
        classname = "background"
    })

    local stack3 = nurture.Stack:new(N, {
        x = 550,
        y = 50,
        forcedWidth = 180,
        forcedHeight = 120,
        children = { backgroundBox, hboxContent, vboxContent }
    })

    hboxContent.stackHorizAlign = "center"
    hboxContent.stackVertAlign = "top"
    
    vboxContent.stackHorizAlign = "center"
    vboxContent.stackVertAlign = "bottom"

    local button1 = nurture.Button:new(N, {
        padding = 15,
        rounding = 5,
        colors = {
            primaryColor = { 0.3, 0.7, 0.4, 0.5 },
            hoveredColor = { 0.4, 0.8, 0.5, 0.1 },
            pressedColor = { 0.2, 0.6, 0.3, 0.1 }
        },
        onClick = function(btn)
            print("Button 1 clicked!")
        end,
        child = nurture.TextLabel:new(N, "Button 1", "BodyFont", {
            color = { 1, 1, 1, 1 }
        }),
        classname = "btn1"
    })

    local button2 = nurture.Button:new(N, {
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.7, 0.3, 0.4, 0.5 },
            hoveredColor = { 0.8, 0.4, 0.5, 0.5 },
            pressedColor = { 0.6, 0.2, 0.3, 0.5 }
        },
        onClick = function(btn)
            print("Button 2 clicked!")
        end,
        child = nurture.TextLabel:new(N, "Button 2", "BodyFont", {
            color = { 1, 1, 1, 1 }
        }),
        classname = "btn2"
    })

    local button3 = nurture.Button:new(N, {
        padding = 12,
        rounding = 5,
        colors = {
            primaryColor = { 0.4, 0.3, 0.7, 0.5 },
            hoveredColor = { 0.5, 0.4, 0.8, 0.5 },
            pressedColor = { 0.3, 0.2, 0.6, 0.5 }
        },
        onClick = function(btn)
            print("Button 3 clicked!")
        end,
        child = nurture.TextLabel:new(N, "Button 3", "BodyFont", {
            color = { 1, 1, 1, 1 }
        }),
        classname = "btn3"
    })

    button1.stackHorizAlign = "left"
    button1.stackVertAlign = "top"
    
    button2.stackHorizAlign = "left"
    button2.stackVertAlign = "top"
    
    button3.stackHorizAlign = "center"
    button3.stackVertAlign = "center"

    local stack4 = nurture.Stack:new(N, {
        x = 50,
        y = 250,
        forcedWidth = 200,
        forcedHeight = 100,
        children = { button1, button2, button3 }
    })

    local stretchBox1 = nurture.Box:new(N, {
        backgroundColor = { 0.5, 0.3, 0.7, 0.6 },
        rounding = 5,
        child = nurture.TextLabel:new(N, "Stretched", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local nonStretchBox = nurture.Box:new(N, {
        forcedWidth = 80,
        forcedHeight = 40,
        backgroundColor = { 0.7, 0.5, 0.3, 0.8 },
        rounding = 5,
        child = nurture.TextLabel:new(N, "Fixed", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    nonStretchBox.stackHorizAlign = "center"
    nonStretchBox.stackVertAlign = "center"

    local stack5 = nurture.Stack:new(N, {
        x = 300,
        y = 250,
        forcedWidth = 150,
        forcedHeight = 100,
        children = { stretchBox1, nonStretchBox }
    })

    local bringBtn1ToFront = nurture.Button:new(N, {
        x = 50,
        y = 380,
        padding = 5,
        rounding = 3,
        colors = {
            primaryColor = { 0.2, 0.5, 0.8, 1.0 },
            hoveredColor = { 0.3, 0.6, 0.9, 1.0 },
            pressedColor = { 0.1, 0.4, 0.7, 1.0 }
        },
        onClick = function(btn)
            stack4:bringToFrontByClassname("btn1")
            print("Brought Button 1 to front")
        end,
        child = nurture.TextLabel:new(N, "Btn1 Front", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local sendBtn2ToBack = nurture.Button:new(N, {
        x = 150,
        y = 380,
        padding = 5,
        rounding = 3,
        colors = {
            primaryColor = { 0.8, 0.5, 0.2, 1.0 },
            hoveredColor = { 0.9, 0.6, 0.3, 1.0 },
            pressedColor = { 0.7, 0.4, 0.1, 1.0 }
        },
        onClick = function(btn)
            stack4:sendToBackByClassname("btn2")
            print("Sent Button 2 to back")
        end,
        child = nurture.TextLabel:new(N, "Btn2 Back", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local moveBtn3Forward = nurture.Button:new(N, {
        x = 250,
        y = 380,
        padding = 5,
        rounding = 3,
        colors = {
            primaryColor = { 0.5, 0.8, 0.2, 1.0 },
            hoveredColor = { 0.6, 0.9, 0.3, 1.0 },
            pressedColor = { 0.4, 0.7, 0.1, 1.0 }
        },
        onClick = function(btn)
            stack4:sendOneFront(button3)
            print("Moved Button 3 one forward")
        end,
        child = nurture.TextLabel:new(N, "Btn3 +1", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local moveBtn1Back = nurture.Button:new(N, {
        x = 350,
        y = 380,
        padding = 5,
        rounding = 3,
        colors = {
            primaryColor = { 0.8, 0.2, 0.5, 1.0 },
            hoveredColor = { 0.9, 0.3, 0.6, 1.0 },
            pressedColor = { 0.7, 0.1, 0.4, 1.0 }
        },
        onClick = function(btn)
            stack4:sendOneBack(button1)
            print("Moved Button 1 one back")
        end,
        child = nurture.TextLabel:new(N, "Btn1 -1", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local label1 = nurture.TextLabel:new(N, "Stack 1: Default (left, top)", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    label1:setPosition(50, 25)

    local label2 = nurture.TextLabel:new(N, "Stack 2: Mixed alignments", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    label2:setPosition(300, 25)

    local label3 = nurture.TextLabel:new(N, "Stack 3: Container compatibility", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    label3:setPosition(550, 25)

    local label4 = nurture.TextLabel:new(N, "Stack 4: Reordering test", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    label4:setPosition(50, 225)

    local label5 = nurture.TextLabel:new(N, "Stack 5: Stretch vs Fixed", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    label5:setPosition(300, 225)

    local instructionLabel = nurture.TextLabel:new(N, "Use buttons below to test reordering:", "BodyFont", {
        color = { 1, 1, 0.5, 1 }
    })
    instructionLabel:setPosition(50, 360)

    local debugLabel = nurture.TextLabel:new(N, "Click buttons to see stacking order changes", "BodyFont", {
        color = { 0.8, 0.8, 0.8, 0.7 }
    })
    debugLabel:setPosition(50, 420)
end

return {
    load = load
}

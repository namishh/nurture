local function load(nurture, N)
    local basicInput = nurture.Input:new(N, {
        x = 50,
        y = 60,
        width = 250,
        height = 40,
        placeholder = "Enter text here...",
        padding = 10,
        rounding = 5
    })

    local styledInput = nurture.Input:new(N, {
        x = 50,
        y = 120,
        width = 300,
        height = 45,
        placeholder = "Styled input with custom colors",
        padding = 12,
        rounding = 8,
        backgroundColor = { 0.15, 0.15, 0.2, 1 },
        textColor = { 1, 1, 1, 1 },
        borderColor = { 0.4, 0.4, 0.5, 1 },
        focusedBorderColor = { 0.3, 0.7, 1.0, 1 },
        placeholderColor = { 0.5, 0.5, 0.6, 1 }
    })

    local limitedInput = nurture.Input:new(N, {
        x = 50,
        y = 190,
        width = 200,
        height = 40,
        placeholder = "Max 10 characters",
        padding = 10,
        rounding = 5,
        maxLength = 10,
        backgroundColor = { 0.2, 0.2, 0.3, 1 },
        focusedBorderColor = { 1.0, 0.7, 0.3, 1 }
    })

    local callbackInput = nurture.Input:new(N, {
        x = 50,
        y = 260,
        width = 350,
        height = 40,
        placeholder = "Type something (prints to console)...",
        padding = 10,
        rounding = 5,
        text = "",
        onTextChanged = function(widget, text)
            print("Text changed: " .. text)
        end,
        onFocus = function(widget)
            print("Input focused")
        end,
        onUnfocus = function(widget)
            print("Input unfocused")
        end
    })

    local thickBorderInput = nurture.Input:new(N, {
        x = 50,
        y = 400,
        width = 300,
        height = 45,
        placeholder = "Thick border input",
        padding = 12,
        rounding = 10,
        borderWidth = 4,
        backgroundColor = { 0.2, 0.25, 0.2, 1 },
        borderColor = { 0.3, 0.5, 0.3, 1 },
        focusedBorderColor = { 0.4, 0.8, 0.4, 1 }
    })

    local prefilledInput = nurture.Input:new(N, {
        x = 450,
        y = 60,
        width = 300,
        height = 40,
        text = "Pre-filled text",
        padding = 10,
        rounding = 5,
        backgroundColor = { 0.25, 0.2, 0.25, 1 },
        focusedBorderColor = { 0.7, 0.4, 0.9, 1 }
    })

    local roundedInput = nurture.Input:new(N, {
        x = 450,
        y = 130,
        width = 250,
        height = 40,
        placeholder = "Very rounded corners",
        padding = 10,
        rounding = 20,
        backgroundColor = { 0.2, 0.3, 0.35, 1 },
        focusedBorderColor = { 0.3, 0.8, 0.9, 1 }
    })

    local interactiveInput = nurture.Input:new(N, {
        x = 450,
        y = 260,
        width = 300,
        height = 40,
        placeholder = "Interactive test",
        padding = 10,
        rounding = 5
    })

    local clearBtn = nurture.Button:new(N, {
        x = 450,
        y = 310,
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.8, 0.3, 0.3, 1.0 },
            hoveredColor = { 0.9, 0.4, 0.4, 1.0 },
            pressedColor = { 0.7, 0.2, 0.2, 1.0 }
        },
        onClick = function(btn)
            interactiveInput:setText("")
        end,
        child = nurture.TextLabel:new(N, "Clear", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local setTextBtn = nurture.Button:new(N, {
        x = 520,
        y = 310,
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.3, 0.6, 0.9, 1.0 },
            hoveredColor = { 0.4, 0.7, 1.0, 1.0 },
            pressedColor = { 0.2, 0.5, 0.8, 1.0 }
        },
        onClick = function(btn)
            interactiveInput:setText("Hello, World!")
        end,
        child = nurture.TextLabel:new(N, "Set Text", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local getTextBtn = nurture.Button:new(N, {
        x = 610,
        y = 310,
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.3, 0.8, 0.4, 1.0 },
            hoveredColor = { 0.4, 0.9, 0.5, 1.0 },
            pressedColor = { 0.2, 0.7, 0.3, 1.0 }
        },
        onClick = function(btn)
            print("Input text: " .. interactiveInput:getText())
        end,
        child = nurture.TextLabel:new(N, "Get Text", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local basicLabel = nurture.TextLabel:new(N, "Basic Input", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    basicLabel:setPosition(50, 35)

    local styledLabel = nurture.TextLabel:new(N, "Styled with Custom Colors", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    styledLabel:setPosition(50, 95)

    local limitedLabel = nurture.TextLabel:new(N, "Limited Length (10 chars)", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    limitedLabel:setPosition(50, 165)

    local callbackLabel = nurture.TextLabel:new(N, "With Callbacks (check console)", "BodyFont", {
        color = { 1, 1, 0.5, 1 }
    })
    callbackLabel:setPosition(50, 235)

    local thickLabel = nurture.TextLabel:new(N, "Thick Border", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    thickLabel:setPosition(50, 375)

    local prefilledLabel = nurture.TextLabel:new(N, "Pre-filled Text", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    prefilledLabel:setPosition(450, 35)

    local roundedLabel = nurture.TextLabel:new(N, "Very Rounded", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    roundedLabel:setPosition(450, 105)

    local interactiveLabel = nurture.TextLabel:new(N, "Interactive Controls", "BodyFont", {
        color = { 1, 1, 0.5, 1 }
    })
    interactiveLabel:setPosition(450, 235)

    local instructions = nurture.TextLabel:new(N,
        "Click on input fields to type. Press ESC to unfocus. Use arrow keys, Home, End to navigate.",
        "BodyFont", {
        color = { 1, 1, 1, 0.6 }
    })
    instructions:setPosition(50, 470)
end

return {
    load = load
}


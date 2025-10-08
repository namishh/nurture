local function load(nurture, N)
    local box1 = nurture.Box:new(N, {
        x = 50,
        y = 50,
        forcedWidth = 300,
        forcedHeight = 150,
        backgroundColor = { 0.2, 0.5, 0.8, 0.9 },
        rounding = 15,
        padding = 20,
        halign = "left",
        valign = "top",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "This is a long text that will wrap around the width of its parent box. It demonstrates the text wrapping feature with left alignment.", "BodyFont", {
                shadow = {
                    x = 3,
                    y = 3,
                    color = { 0, 0, 0, 0.7 }
                },
                color = { 1, 1, 1, 1 },
                wrapping = true,
                wrapAlign = "left"
            })
        }
    })

    local box2 = nurture.Box:new(N, {
        x = 380,
        y = 50,
        forcedWidth = 300,
        forcedHeight = 150,
        backgroundColor = { 0.8, 0.4, 0.3, 0.9 },
        rounding = 15,
        padding = 20,
        halign = "left",
        valign = "top",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "This text is wrapped with center alignment. Notice how each line is centered within the parent box's width.", "BodyFont", {
                color = { 1, 1, 1, 1 },
                wrapping = true,
                wrapAlign = "center"
            })
        }
    })

    -- Example 3: Wrapped text with right alignment
    local box3 = nurture.Box:new(N, {
        x = 50,
        y = 220,
        forcedWidth = 300,
        forcedHeight = 150,
        backgroundColor = { 0.3, 0.8, 0.5, 0.9 },
        rounding = 15,
        padding = 20,
        halign = "left",
        valign = "top",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "This text demonstrates right-aligned wrapping. Each line aligns to the right edge of the container.", "BodyFont", {
                color = { 1, 1, 1, 1 },
                wrapping = true,
                wrapAlign = "right"
            })
        }
    })

    local box4 = nurture.Box:new(N, {
        x = 380,
        y = 220,
        forcedWidth = 300,
        forcedHeight = 150,
        backgroundColor = { 0.6, 0.3, 0.7, 0.9 },
        rounding = 15,
        padding = 20,
        halign = "left",
        valign = "top",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "This text uses justified alignment. The text is spread out to fill the entire width of the container, creating clean edges on both sides.", "BodyFont", {
                color = { 1, 1, 1, 1 },
                wrapping = true,
                wrapAlign = "justify"
            })
        }
    })

    local box5 = nurture.Box:new(N, {
        x = 50,
        y = 470,
        forcedWidth = 300,
        forcedHeight = 60,
        backgroundColor = { 0.9, 0.7, 0.2, 0.9 },
        rounding = 15,
        padding = 15,
        halign = "left",
        valign = "center",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "This text is NOT wrapped", "BodyFont", {
                color = { 0, 0, 0, 1 },
                wrapping = false
            })
        }
    })

    local box6 = nurture.Box:new(N, {
        x = 380,
        y = 390,
        forcedWidth = 300,
        forcedHeight = 140,
        backgroundColor = { 0.1, 0.1, 0.15, 0.95 },
        rounding = 15,
        padding = 20,
        halign = "left",
        valign = "top",
        zIndex = 1,
        children = {
            nurture.TextLabel:new(N, "This wrapped text has a shadow effect applied to it. The shadow also respects the wrapping behavior.", "BodyFont", {
                color = { 1, 1, 1, 1 },
                wrapping = true,
                wrapAlign = "left",
                shadow = {
                    x = 2,
                    y = 2,
                    color = { 0, 0, 0, 0.7 }
                }
            })
        }
    })
end

return {
    load = load
}


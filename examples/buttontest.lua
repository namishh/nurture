local function load(nurture, N)
    local basicButton = nurture.Button:new(N, {
        x = 50,
        y = 50,
        padding = 15,
        rounding = 10,
        onClick = function(btn)
            print("Basic button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Click Me!", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local colorButton = nurture.Button:new(N, {
        x = 200,
        y = 50,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.8, 0.2, 0.3, 1.0 },
            hoveredColor = { 0.9, 0.3, 0.4, 1.0 },
            pressedColor = { 0.6, 0.1, 0.2, 1.0 },
            disabledColor = { 0.4, 0.4, 0.4, 0.5 }
        },
        onClick = function(btn)
            print("Custom color button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Custom Colors", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local shadowButton = nurture.Button:new(N, {
        x = 400,
        y = 50,
        padding = 15,
        rounding = 10,
        shadow = {
            x = 4,
            y = 4,
            color = { 0, 0, 0, 0.5 }
        },
        onClick = function(btn)
            print("Shadow button clicked!")
        end,
        child = nurture.TextLabel:new(N, "With Shadow", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local sizedButton = nurture.Button:new(N, {
        x = 550,
        y = 50,
        forcedWidth = 150,
        forcedHeight = 80,
        padding = 10,
        rounding = 10,
        halign = "center",
        valign = "center",
        onClick = function(btn)
            print("Sized button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Fixed Size", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local hoverButton = nurture.Button:new(N, {
        x = 50,
        y = 150,
        padding = 15,
        rounding = 10,
        onMouseOver = function(btn)
            print("Mouse entered button!")
        end,
        onMouseLeave = function(btn)
            print("Mouse left button!")
        end,
        onClick = function(btn)
            print("Hover button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Hover Events", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local disabledButton = nurture.Button:new(N, {
        x = 230,
        y = 150,
        padding = 15,
        rounding = 10,
        disabled = true,
        onClick = function(btn)
            print("This should not print - button is disabled")
        end,
        child = nurture.TextLabel:new(N, "Disabled", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local hboxChild = nurture.HBox:new(N, {
        spacing = 10,
        padding = 0,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "Icon", "BodyFont", {
                color = { 1, 0.8, 0.2, 1 }
            }),
            nurture.TextLabel:new(N, "Button", "BodyFont", {
                color = { 1, 1, 1, 1 }
            })
        }
    })

    local hboxButton = nurture.Button:new(N, {
        x = 400,
        y = 150,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.3, 0.7, 0.4, 1.0 },
            hoveredColor = { 0.4, 0.8, 0.5, 1.0 },
            pressedColor = { 0.2, 0.6, 0.3, 1.0 }
        },
        onClick = function(btn)
            print("HBox button clicked!")
        end,
        child = hboxChild
    })

    local vboxChild = nurture.VBox:new(N, {
        spacing = 5,
        padding = 0,
        halign = "center",
        valign = "center",
        children = {
            nurture.TextLabel:new(N, "Multi", "BodyFont", {
                color = { 1, 1, 1, 1 }
            }),
            nurture.TextLabel:new(N, "Line", "BodyFont", {
                color = { 0.8, 0.8, 1, 1 }
            })
        }
    })

    local vboxButton = nurture.Button:new(N, {
        x = 600,
        y = 150,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.6, 0.4, 0.8, 1.0 },
            hoveredColor = { 0.7, 0.5, 0.9, 1.0 },
            pressedColor = { 0.5, 0.3, 0.7, 1.0 }
        },
        onClick = function(btn)
            print("VBox button clicked!")
        end,
        child = vboxChild
    })

    local paddingButton = nurture.Button:new(N, {
        x = 50,
        y = 250,
        padding = {
            left = 30,
            right = 30,
            top = 10,
            bottom = 10
        },
        rounding = 8,
        onClick = function(btn)
            print("Custom padding button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Custom Padding", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local leftTopButton = nurture.Button:new(N, {
        x = 270,
        y = 250,
        forcedWidth = 150,
        forcedHeight = 70,
        padding = 10,
        rounding = 10,
        halign = "left",
        valign = "top",
        colors = {
            primaryColor = { 0.9, 0.6, 0.2, 1.0 },
            hoveredColor = { 1.0, 0.7, 0.3, 1.0 },
            pressedColor = { 0.8, 0.5, 0.1, 1.0 }
        },
        onClick = function(btn)
            print("Left-top aligned button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Left Top", "BodyFont", {
            color = { 0, 0, 0, 1 }
        })
    })

    local rightBottomButton = nurture.Button:new(N, {
        x = 450,
        y = 250,
        forcedWidth = 150,
        forcedHeight = 70,
        padding = 10,
        rounding = 10,
        halign = "right",
        valign = "bottom",
        colors = {
            primaryColor = { 0.2, 0.8, 0.8, 1.0 },
            hoveredColor = { 0.3, 0.9, 0.9, 1.0 },
            pressedColor = { 0.1, 0.7, 0.7, 1.0 }
        },
        onClick = function(btn)
            print("Right-bottom aligned button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Right Bottom", "BodyFont", {
            color = { 0, 0, 0, 1 }
        })
    })

    local ovalButton = nurture.Button:new(N, {
        x = 50,
        y = 350,
        padding = 20,
        rounding = {
            rx = 40,
            ry = 15
        },
        colors = {
            primaryColor = { 0.8, 0.3, 0.8, 1.0 },
            hoveredColor = { 0.9, 0.4, 0.9, 1.0 },
            pressedColor = { 0.7, 0.2, 0.7, 1.0 }
        },
        onClick = function(btn)
            print("Oval button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Oval Rounding", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local toggleState = false
    local toggleButton = nurture.Button:new(N, {
        x = 250,
        y = 350,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.5, 0.5, 0.5, 1.0 },
            hoveredColor = { 0.6, 0.6, 0.6, 1.0 },
            pressedColor = { 0.4, 0.4, 0.4, 1.0 }
        },
        child = nurture.TextLabel:new(N, "OFF", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    toggleButton:setOnClick(function(btn)
        toggleState = not toggleState
        local child = btn.nurture:getFromUUID(btn.childUUID)
        if toggleState then
            child:setText("ON")
            btn:setPrimaryColor(0.2, 0.8, 0.2, 1.0)
            btn:setHoveredColor(0.3, 0.9, 0.3, 1.0)
            btn:setPressedColor(0.1, 0.7, 0.1, 1.0)
        else
            child:setText("OFF")
            btn:setPrimaryColor(0.5, 0.5, 0.5, 1.0)
            btn:setHoveredColor(0.6, 0.6, 0.6, 1.0)
            btn:setPressedColor(0.4, 0.4, 0.4, 1.0)
        end
        print("Toggle state: " .. tostring(toggleState))
    end)

    local textWithShadow = nurture.TextLabel:new(N, "Shadow Text", "BodyFont", {
        color = { 1, 1, 1, 1 },
        shadow = {
            x = 2,
            y = 2,
            color = { 0, 0, 0, 0.8 }
        }
    })

    local textShadowButton = nurture.Button:new(N, {
        x = 430,
        y = 350,
        padding = 15,
        rounding = 10,
        colors = {
            primaryColor = { 0.1, 0.1, 0.15, 1.0 },
            hoveredColor = { 0.15, 0.15, 0.2, 1.0 },
            pressedColor = { 0.05, 0.05, 0.1, 1.0 }
        },
        onClick = function(btn)
            print("Text shadow button clicked!")
        end,
        child = textWithShadow
    })

    local disableButton = nurture.Button:new(N, {
        x = 50,
        y = 450,
        padding = 15,
        rounding = 10,
        child = nurture.TextLabel:new(N, "Click to Disable", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    disableButton:setOnClick(function(btn)
        print("Disabling button...")
        btn:setDisabled(true)
        local child = btn.nurture:getFromUUID(btn.childUUID)
        child:setText("Disabled")
    end)

    local wrappedText = nurture.TextLabel:new(N, "This is a button with wrapped text that spans multiple lines",
        "BodyFont", {
        color = { 1, 1, 1, 1 },
        wrapping = true,
        wrapAlign = "center"
    })

    local wrappedButton = nurture.Button:new(N, {
        x = 250,
        y = 450,
        forcedWidth = 200,
        padding = 15,
        rounding = 10,
        halign = "center",
        valign = "center",
        colors = {
            primaryColor = { 0.3, 0.5, 0.7, 1.0 },
            hoveredColor = { 0.4, 0.6, 0.8, 1.0 },
            pressedColor = { 0.2, 0.4, 0.6, 1.0 }
        },
        onClick = function(btn)
            print("Wrapped text button clicked!")
        end,
        child = wrappedText
    })

    local glowButton = nurture.Button:new(N, {
        x = 480,
        y = 450,
        padding = 20,
        rounding = 15,
        shadow = {
            x = 0,
            y = 0,
            color = { 0.3, 0.8, 1.0, 0.6 }
        },
        colors = {
            primaryColor = { 0.1, 0.6, 0.9, 1.0 },
            hoveredColor = { 0.2, 0.7, 1.0, 1.0 },
            pressedColor = { 0.05, 0.5, 0.8, 1.0 }
        },
        onClick = function(btn)
            print("Glow button clicked!")
        end,
        child = nurture.TextLabel:new(N, "Glow Effect", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local button3D = nurture.Button:new(N, {
        x = 50,
        y = 520,
        padding = 20,
        rounding = 12,
        shadow = {
            x = 5,
            y = 5,
            color = { 0, 0, 0, 0.6 }
        },
        colors = {
            primaryColor = { 0.9, 0.5, 0.2, 1.0 },
            hoveredColor = { 1.0, 0.6, 0.3, 1.0 },
            pressedColor = { 0.8, 0.4, 0.1, 1.0 }
        },
        onClick = function(btn)
            print("3D button clicked!")
        end,
        child = nurture.TextLabel:new(N, "3D Press Effect", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local original3DX = button3D.x
    local original3DY = button3D.y
    local original3DShadowX = button3D.shadow.x
    local original3DShadowY = button3D.shadow.y

    local original3DMouseOver = button3D.onMouseOver
    button3D.onMouseOver = function(self, x, y)
        original3DMouseOver(self, x, y)
    end

    button3D.onMousePressed = function(self, x, y, btn)
        if self:isPointInside(x, y) then
            self._isPressed = true
            self.x = original3DX + 4
            self.y = original3DY + 4
            self:setShadowOffset(1, 1)
            self:updateSize()
            self:_updateCurrentColor()
        end
    end

    button3D.onMouseReleased = function(self, x, y, btn)
        if self._isPressed then
            self.x = original3DX
            self.y = original3DY
            self:setShadowOffset(original3DShadowX, original3DShadowY)
            self:updateSize()

            if self:isPointInside(x, y) then
                self:onClick(x, y, btn)
            end
        end
    end

    local instructions = nurture.TextLabel:new(N,
        "Click buttons to test events. Check console for output. Notice the 3D press effect!", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    instructions:setPosition(250, 575)
end

return {
    load = load
}

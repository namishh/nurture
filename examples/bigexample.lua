local flux = require("assets.flux")

IS_OVERLAY_OPEN = false
IS_PAUSED_OPEN = false
IS_PROFILE_OPEN = false
IS_SHOP_OPEN = false
IS_OPTIONS_OPEN = false

SHOULD_DISABLE_BUTTONS = IS_PAUSED_OPEN or IS_PROFILE_OPEN or IS_SHOP_OPEN or IS_OPTIONS_OPEN

PROFILE = "nam"

local function load(nurture, N)

    local closeButton =             nurture.Button:new(N, {
        forcedWidth = 20,
        colors = {
            primaryColor = { 0.1, 0.1, 0.1, 0 },
            hoveredColor = { 0.1, 0.1, 0.1, 0 },
            pressedColor = { 0.1, 0.1, 0.1, 0 },
        },
        zIndex = 100000,
        forcedHeight = 20,
        onClick = function(self)
            IS_OVERLAY_OPEN = false 
            if IS_PAUSED_OPEN then
                IS_PAUSED_OPEN = false
            end
            if IS_SHOP_OPEN then
                IS_SHOP_OPEN = false
            end
            if IS_PROFILE_OPEN then
                IS_PROFILE_OPEN = false
            end
            if IS_OPTIONS_OPEN then
                IS_OPTIONS_OPEN = false
            end
        
            SHOULD_DISABLE_BUTTONS = IS_PAUSED_OPEN or IS_PROFILE_OPEN or IS_SHOP_OPEN or IS_OPTIONS_OPEN
        end,
        children = {
            nurture.Image:new(N, "assets/close.png", {
                x = 0,
                y = 0,
                forcedWidth = 30,
                forcedHeight = 30,
            })
        }
    })

    local overlayAlphaState = { value = 0 }

    local overlay = nurture.Box:new(N, {
        x = 0,
        zIndex = 1000,
        y = 0,
        padding = 40,
        forcedHeight = love.graphics.getHeight(),
        forcedWidth = love.graphics.getWidth(),
        backgroundColor = { 0.1, 0.1, 0.1, 0 },
        halign = "right",
        valign = "top",
        children = {
            closeButton
        }
    })

    overlay:setUpdateCallback(function(self, dt)
        if IS_OVERLAY_OPEN and overlayAlphaState.value < 0.7 then
            overlayAlphaState.value = math.min(0.7, overlayAlphaState.value + dt * 3)
        elseif not IS_OVERLAY_OPEN and overlayAlphaState.value > 0 then
            overlayAlphaState.value = math.max(0, overlayAlphaState.value - dt * 3)
        end

        self.backgroundColor[4] = overlayAlphaState.value

        if IS_OVERLAY_OPEN then
            self:show() 
        else
            self:hide()
        end
    end)

    local profileInput = nurture.Input:new(N, {
        width = 360,
        height = 40,
        rounding = 0,
        text=PROFILE,
        backgroundColor = { 0.2, 0.2, 0.2, 0 },
        borderColor = { 0.5, 0.5, 0.5, 0 },
        textColor = { 1, 1, 1, 0 },
        focusedBorderColor = { 0.3, 0.6, 0.9, 0 },
        cursorColor = { 1, 1, 1, 0 }
    })

    local profile = nurture.Box:new(N, {
        classname = "profile-box",
        stackVertAlign = "bottom",
        stackHorizAlign = "right",
        zIndex = 10,
        children = {
            nurture.Button:new(N, {
                classname = "profile-button",
                padding = {
                    top = 5,
                    bottom = 5,
                    left = 10,
                    right = 10
                },
                colors = {
                    primaryColor = { 0.2, 0.2, 0.2, 1.0 },
                    hoveredColor = { 0.4, 0.4, 0.4, 1.0 },
                    pressedColor = { 0.3, 0.3, 0.3, 1.0 }
                },
                onClick = function(self)
                    if SHOULD_DISABLE_BUTTONS then
                        return
                    end

                    IS_PROFILE_OPEN = true
                    IS_OVERLAY_OPEN = true
                end,
                shadow = {
                    x = 6,
                    y = 6,
                    color = { 0, 0, 0, 0.7 }
                },
                children = {
                    nurture.TextLabel:new(N, PROFILE, "bigtitle", {
                        classname = "profile-label",
                        color = { 1, 1, 1, 1 },
                        shadow = {
                            x = 6,
                            y = 6,
                            color = { 0, 0, 0, 0.7 }
                        }
                    })
                }
            })
        }
    }) 

    local profileBoxAlphaState = { value = 0 }

    local profileBox = nurture.Box:new(N, {
        backgroundColor = { 0.04, 0.04, 0.04, 0 },
        rounding = 10,
        shadow = {
            x = 7,
            y = 7,
            color = { 0, 0, 0, 0 }
        },
        padding = 20,
        x = love.graphics.getWidth()/2 - 150,
        y = love.graphics.getHeight()/2 - 150,
        zIndex = 1001,
        children = {
            nurture.VBox:new(N, {
                spacing = 10,
                children = {
                    nurture.TextLabel:new(N, "Set Profile", "bigtitle", {
                        color = { 1, 1, 1, 0 },
                        shadow = {
                            x = 6,
                            y = 6,
                            color = { 0, 0, 0, 0 }
                        }
                    }),
                    profileInput,
                    nurture.HFracBox:new(N, {
                        spacing = 10,
                        children = {
                            nurture.Button:new(N, {
                                padding = 6,
                                colors = {
                                    primaryColor = { 0.3, 0.5, 0.8, 0 },
                                    hoveredColor = { 0.4, 0.6, 0.9, 0 },
                                    pressedColor = { 0.2, 0.4, 0.7, 0 }
                                },
                                children = {
                                    nurture.TextLabel:new(N, "Save", "title", {
                                        color = { 1, 1, 1, 0 },
                                    })
                                },
                                onClick = function(self)
                                    PROFILE = profileInput.text
                                    local label = N:get_all_by_classname("profile-label")[1]
                                    label:setText(PROFILE)
                                    IS_PROFILE_OPEN = false
                                    IS_OVERLAY_OPEN = false
                                end
                            }),
                            nurture.Button:new(N, {
                                padding = 6,
                                colors = {
                                    primaryColor = { 1, 0.2, 0.2, 0 },
                                    hoveredColor = { 1, 0.4, 0.4, 0 },
                                    pressedColor = { 1, 0.3, 0.3, 0 }
                                },
                                onClick = function(self)
                                    IS_PROFILE_OPEN = false
                                    IS_OVERLAY_OPEN = false
                                end,
                                children = {
                                    nurture.TextLabel:new(N, "Cancel", "title", {
                                        color = { 1, 1, 1, 0 },
                                    })
                                }
                            })
                        }
                    })
                }
            })
        }
    })

    profileBox._scaleX = 0.8
    profileBox._scaleY = 0.8
    profileBox._targetScale = 1.0

    profileBox:setUpdateCallback(function(self, dt)
        if IS_PROFILE_OPEN and profileBoxAlphaState.value < 1.0 then
            profileBoxAlphaState.value = math.min(1.0, profileBoxAlphaState.value + dt * 5)
            self._targetScale = 1.0
        elseif not IS_PROFILE_OPEN and profileBoxAlphaState.value > 0 then
            profileBoxAlphaState.value = math.max(0, profileBoxAlphaState.value - dt * 5)
            self._targetScale = 0.8
        end

        -- Smooth scale animation
        self._scaleX = self._scaleX + (self._targetScale - self._scaleX) * dt * 10
        self._scaleY = self._scaleY + (self._targetScale - self._scaleY) * dt * 10

        local currentAlpha = profileBoxAlphaState.value
        self.backgroundColor[4] = currentAlpha
        self.shadow.color[4] = currentAlpha
        self.scaleX = self._scaleX
        self.scaleY = self._scaleY

        local vbox = self.nurture:getFromUUID(self.childUUID)
        if vbox then
            local children = vbox:getChildren()
            for _, child in ipairs(children) do
                if child.type == "TextLabel" then
                    child.color[4] = currentAlpha
                    if child.shadow and child.shadow.color then
                        child.shadow.color[4] = currentAlpha * 0.7
                    end
                elseif child.type == "Input" then
                    -- Animate input field
                    if child.backgroundColor then
                        child.backgroundColor[4] = currentAlpha
                    end
                    if child.borderColor then
                        child.borderColor[4] = currentAlpha
                    end
                    if child.textColor then
                        child.textColor[4] = currentAlpha
                    end
                    if child.focusedBorderColor then
                        child.focusedBorderColor[4] = currentAlpha
                    end
                    if child.cursorColor then
                        child.cursorColor[4] = currentAlpha
                    end
                elseif child.type == "HFracBox" then
                    local buttons = child:getChildren()
                    for _, btn in ipairs(buttons) do
                        if btn.type == "Button" then
                            btn.colors.primaryColor[4] = currentAlpha
                            btn.colors.hoveredColor[4] = currentAlpha
                            btn.colors.pressedColor[4] = currentAlpha
                            btn:_updateCurrentColor()
                            local textLabel = btn.nurture:getFromUUID(btn.childUUID)
                            if textLabel then
                                textLabel.color[4] = currentAlpha
                            end
                        end
                    end
                end
            end
        end

        if IS_PROFILE_OPEN then
            self:show()
        else
            self:hide()
        end
    end)

    local pauseMenuLabel = nurture.TextLabel:new(N, "PAUSED", "bigtitle", {
        color = { 1, 1, 1, 0 },
        justify = "center",
        horizAlign = "center",
    })
    
    pauseMenuLabel._scaleX = 1.0
    pauseMenuLabel._scaleY = 1.0
    pauseMenuLabel._rotation = 0
    
    local function createLabelBreathing()
        flux.to(pauseMenuLabel, 1.5, { _scaleX = 1.02, _scaleY = 1.02, _rotation = math.rad(3) })
            :ease("sineinout")
            :after(pauseMenuLabel, 1.5, { _scaleX = 1.0, _scaleY = 1.0, _rotation = math.rad(-3) })
            :ease("sineinout")
            :after(pauseMenuLabel, 1.5, { _scaleX = 1.02, _scaleY = 1.02, _rotation = 0 })
            :ease("sineinout")
            :oncomplete(createLabelBreathing)
    end
    
    createLabelBreathing()

    local pauseDots = {}
    for i = 1, 16 do
        local dot = nurture.Box:new(N, {
            forcedWidth = 5,
            forcedHeight = 5,
            backgroundColor = { 1, 1, 1, 0 },
            rounding = 4,
        })
        dot._yOffset = 0
        dot._baseY = 0
        table.insert(pauseDots, dot)
    end

    for i, dot in ipairs(pauseDots) do
        local delay = (i - 1) * 0.05

        local function createOscillation()
            flux.to(dot, 0.4, { _yOffset = 3 })
                :ease("sineinout")
                :delay(delay)
                :after(dot, 0.4, { _yOffset = -3 })
                :ease("sineinout")
                :oncomplete(createOscillation)
        end

        createOscillation()
    end

    local pauseDottedLine = nurture.HBox:new(N, {
        spacing = 8,
        padding = 0,
        halign = "center",
        valign = "center",
        children = pauseDots
    })

    local pauseAlphaState = { value = 0 }

    local function createPauseMenuButton(text, primaryColor, hoveredColor, pressedColor, isDisabled)
        local button = nurture.Button:new(N, {
            padding = 12,
            rounding = 8,
            zIndex = 1000,
            colors = {
                primaryColor = primaryColor,
                hoveredColor = hoveredColor,
                pressedColor = pressedColor,
            },
            shadow = {
                x = 0,
                y = 4,
                color = { 0, 0, 0, 0 }
            },
            child = nurture.TextLabel:new(N, text, "title", {
                color = { 1, 1, 1, 0 }
            })
        })

        if isDisabled then
            button.disabled = true
            button.enabled = true
        end

        button._originalY = button.y
        button._originalShadowY = button.shadow.y

        return button
    end

    local resumeButton = createPauseMenuButton("Resume",
        { 0.3, 0.7, 0.4, 0 },
        { 0.4, 0.8, 0.5, 0 },
        { 0.2, 0.6, 0.3, 0 })

    resumeButton:setOnClick(function(btn)
        IS_PAUSED_OPEN = false
        IS_OVERLAY_OPEN = false
        SHOULD_DISABLE_BUTTONS = false
        flux.to(pauseAlphaState, 0.15, { value = 0 })
            :ease("quadout")
    end)

    local achievementsButton = createPauseMenuButton("Achievements",
        { 0.5, 0.5, 0.5, 0 },
        { 0.6, 0.6, 0.6, 0 },
        { 0.4, 0.4, 0.4, 0 },
        true) -- Disabled

    local quitButton = createPauseMenuButton("Quit",
        { 0.8, 0.3, 0.3, 0 },
        { 0.9, 0.4, 0.4, 0 },
        { 0.7, 0.2, 0.2, 0 })

    quitButton:setOnClick(function(btn)
        love.event.quit()
    end)

    local pauseMenuButtons = { resumeButton, achievementsButton, quitButton }

    local pauseButtonsVBox = nurture.VBox:new(N, {
        spacing = 10,
        padding = 0,
        halign = "center",
        valign = "center",
        zIndex = 102,
        children = pauseMenuButtons
    })

    local pauseMenuVBox = nurture.VBox:new(N, {
        spacing = 20,
        padding = 0,
        halign = "center",
        valign = "center",
        zIndex = 102,
        children = {
            pauseMenuLabel,
            pauseDottedLine,
            pauseButtonsVBox
        }
    })

    local pauseMenuBox = nurture.Box:new(N, {
        backgroundColor = { 0.1, 0.1, 0.1, 0 },
        rounding = 15,
        forcedWidth = 300,
        padding = 30,
        x = love.graphics.getWidth()/2 - 150,
        y = love.graphics.getHeight()/2 - 175,
        zIndex = 1001,
        shadow = {
            x = 0,
            y = 8,
            color = { 0, 0, 0, 0 }
        },
        children = {
            pauseMenuVBox
        }
    })

    pauseMenuBox._scaleX = 0.8
    pauseMenuBox._scaleY = 0.8
    pauseMenuBox._targetScale = 1.0

    pauseMenuBox:setUpdateCallback(function(self, dt)
        -- Animate fade in/out and scale
        if IS_PAUSED_OPEN and pauseAlphaState.value < 1.0 then
            pauseAlphaState.value = math.min(1.0, pauseAlphaState.value + dt * 5)
            self._targetScale = 1.0
        elseif not IS_PAUSED_OPEN and pauseAlphaState.value > 0 then
            pauseAlphaState.value = math.max(0, pauseAlphaState.value - dt * 5)
            self._targetScale = 0.8
        end

        -- Smooth scale animation
        self._scaleX = self._scaleX + (self._targetScale - self._scaleX) * dt * 10
        self._scaleY = self._scaleY + (self._targetScale - self._scaleY) * dt * 10

        local currentAlpha = pauseAlphaState.value
        self.backgroundColor[4] = currentAlpha
        self.shadow.color[4] = currentAlpha * 0.5
        self.scaleX = self._scaleX
        self.scaleY = self._scaleY

        if pauseMenuLabel then
            pauseMenuLabel.color[4] = currentAlpha
            pauseMenuLabel.scaleX = pauseMenuLabel._scaleX
            pauseMenuLabel.scaleY = pauseMenuLabel._scaleY
            pauseMenuLabel.rotation = pauseMenuLabel._rotation
        end

        for _, dot in ipairs(pauseDots) do
            dot.backgroundColor[4] = currentAlpha
            if dot._baseY == 0 then
                dot._baseY = dot.y
            end
            dot.y = dot._baseY + dot._yOffset
        end

        for _, button in ipairs(pauseMenuButtons) do
            button.colors.primaryColor[4] = currentAlpha
            button.colors.hoveredColor[4] = currentAlpha
            button.colors.pressedColor[4] = currentAlpha
            button.shadow.color[4] = currentAlpha * 0.5
            button:_updateCurrentColor()

            local textLabel = button.nurture:getFromUUID(button.childUUID)
            if textLabel then
                textLabel.color[4] = currentAlpha
            end
        end

        if IS_PAUSED_OPEN then
            self:show()
        else
            self:hide()
        end
    end)

    pauseMenuBox:hide()

    local function create3DButton(text, onClick)
        local button = nurture.Button:new(N, {
            forcedWidth = 270,
            padding = 20,
            horizAlign = "left",
            rounding = 12,
            halign = "left",
            valign = "center",
            shadow = {
                x = 0,
                y = 6,
                color = { 0.5, 0.6, 0.9, 1 }
            },
            colors = {
                primaryColor = { 0.2, 0.2, 0.2, 1.0 },
                hoveredColor = { 0.2, 0.2, 0.2, 1.0 },
                pressedColor = { 0.2, 0.2, 0.2, 1.0 }
            },
            onClick = function(self)
                if SHOULD_DISABLE_BUTTONS then
                    return
                end
                onClick(self)
                SHOULD_DISABLE_BUTTONS = IS_PAUSED_OPEN or IS_PROFILE_OPEN or IS_SHOP_OPEN or IS_OPTIONS_OPEN
            end,
            child = nurture.TextLabel:new(N, text, "bigtitle", {
                color = { 1, 1, 1, 1 },
                shadow = {
                    x = 2,
                    y = 2,
                    color = { 0, 0, 0, 1 }
                }
            })
        })

        button._rotation = 0
        button._scaleX = 1.0
        button._scaleY = 1.0
        button._baseY = button.y
        button._wasPressed = false

        local rotationRange = math.random(1, 3)
        local duration = math.random(15, 25) / 10
        local delay = math.random(0, 10) / 10

        local function createButtonSway()
            flux.to(button, duration, { _rotation = math.rad(rotationRange) })
                :ease("sineinout")
                :delay(delay)
                :after(button, duration, { _rotation = math.rad(-rotationRange) })
                :ease("sineinout")
                :oncomplete(createButtonSway)
        end

        createButtonSway()

        button:setOnMouseOver(function(self, x, y)
            if SHOULD_DISABLE_BUTTONS then
                return
            end
            flux.to(self, 0.1, { _scaleX = 1.08, _scaleY = 1.08 }):ease("quadout")
        end)

        button:setOnMouseLeave(function(self, x, y)
            if SHOULD_DISABLE_BUTTONS then
                return
            end
            flux.to(self, 0.1, { _scaleX = 1.0, _scaleY = 1.0 }):ease("quadout")
        end)

        button:setUpdateCallback(function(self, dt)
            if SHOULD_DISABLE_BUTTONS then
                return
            end
            if self._isPressed and not self._wasPressed then
                self._baseY = self.y
                self.y = self.y + 5
                self:setShadowOffset(1, 1)
                self:updateSize()
                self._wasPressed = true
            elseif not self._isPressed and self._wasPressed then
                self.y = self._baseY
                self:setShadowOffset(0, 6)
                self:updateSize()
                self._wasPressed = false
            end
        end)

        return button
    end

    local titleLabel = nurture.TextLabel:new(N, "Nurture", "reallybigtitle", {
        color = { 1, 1, 1, 1 },
        shadow = {
            x = 6,
            y = 6,
            color = { 0, 0, 0, 0.7 }
        }
    })

    titleLabel._scaleX = 1.0
    titleLabel._scaleY = 1.0
    titleLabel._rotation = 0

    local function createTitleBreathing()
        flux.to(titleLabel, 2.0, { _scaleX = 1.05, _scaleY = 1.05, _rotation = math.rad(2) })
            :ease("sineinout")
            :after(titleLabel, 2.0, { _scaleX = 1.0, _scaleY = 1.0, _rotation = math.rad(-2) })
            :ease("sineinout")
            :after(titleLabel, 2.0, { _scaleX = 1.05, _scaleY = 1.05, _rotation = 0 })
            :ease("sineinout")
            :oncomplete(createTitleBreathing)
    end

    createTitleBreathing()

    local menu = nurture.VBox:new(N, {
        spacing = 20,
        children = {
            titleLabel,
            nurture.VBox:new(N, {
                spacing = 20,
                children = {
                    create3DButton("Pause", function(btn)
                        IS_PAUSED_OPEN = true
                        IS_OVERLAY_OPEN = true
                        print("play button clicked!")
                    end),
                    create3DButton("Shop", function(btn)
                        IS_SHOP_OPEN = true
                        IS_OVERLAY_OPEN = true
                        print("Shop button clicked!")
                    end),
                    create3DButton("Options", function(btn)
                        IS_OPTIONS_OPEN = true
                        IS_OVERLAY_OPEN = true
                        print("Options button clicked!")
                    end),
                    create3DButton("Quit", function(btn)
                        print("Quit button clicked!")
                        love.event.quit()
                    end)
                }
            })
        }
    })

    menu.stackHorizAlign = "left"
    menu.stackVertAlign = "bottom"

    local allButtons = {}
    for _, child in ipairs(menu:getChildren()) do
        if child.type == "VBox" then
            for _, button in ipairs(child:getChildren()) do
                if button.type == "Button" then
                    table.insert(allButtons, button)
                end
            end
        end
    end

    menu:setUpdateCallback(function(widget, dt)
        flux.update(dt)

        titleLabel.scaleX = titleLabel._scaleX
        titleLabel.scaleY = titleLabel._scaleY
        titleLabel.rotation = titleLabel._rotation

        for _, button in ipairs(allButtons) do
            button.rotation = button._rotation
            button.scaleX = button._scaleX
            button.scaleY = button._scaleY
        end
    end)

    local mainmenubox = nurture.Box:new(N, {
        x = 0,
        y = 0,
        forcedHeight = love.graphics.getHeight(),
        forcedWidth = love.graphics.getWidth(),
        backgroundColor = { 0.1, 0.1, 0.1, 1 },
        backgroundShader = "assets/spinshader.glsl",
        padding = 40,
        children = {
            nurture.Stack:new(N, {
                classname = "stack",
                forcedHeight = love.graphics.getHeight() - 80,
                forcedWidth = love.graphics.getWidth() - 80,
                children = {
                    menu,
                    profile,
                }
            }),
        }
    })

    mainmenubox:setBackgroundShaderValue('SPIN_ROTATION', 1.0)
    mainmenubox:setBackgroundShaderValue('SPIN_SPEED', 0.001)
    mainmenubox:setBackgroundShaderValue('OFFSET', { 0.0, 0.0 })
    mainmenubox:setBackgroundShaderValue('COLOUR_1', { 0.2, 0.3, 0.5, 1.0 })
    mainmenubox:setBackgroundShaderValue('COLOUR_2', { 0.8, 0.4, 0.2, 1.0 })
    mainmenubox:setBackgroundShaderValue('COLOUR_3', { 0.1, 0.1, 0.1, 1.0 })
    mainmenubox:setBackgroundShaderValue('CONTRAST', 1.5)
    mainmenubox:setBackgroundShaderValue('LIGTHING', 0.5)
    mainmenubox:setBackgroundShaderValue('SPIN_AMOUNT', 0.5)
    mainmenubox:setBackgroundShaderValue('PIXEL_FILTER', 800.0)
    mainmenubox:setBackgroundShaderValue('SPIN_EASE', 1.0)
    mainmenubox:setBackgroundShaderValue('IS_ROTATE', 1.0)

    local time = 0
    mainmenubox:setUpdateCallback(function(widget, dt)
        time = time + dt
        if not IS_PAUSED_OPEN then
            widget:setBackgroundShaderValue("time", time)
        end
    end)
end

return {
    load = load
}

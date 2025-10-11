local flux = require("assets.flux")

----------------
-- Global State
----------------

IS_OVERLAY_OPEN = false
IS_PAUSED_OPEN = false
IS_PROFILE_OPEN = false
IS_SHOP_OPEN = false
IS_OPTIONS_OPEN = false

SHOULD_DISABLE_BUTTONS = IS_PAUSED_OPEN or IS_PROFILE_OPEN or IS_SHOP_OPEN or IS_OPTIONS_OPEN

PROFILE = "nam"

-------------
-- Main Load
-------------

local function load(nurture, N)
    local overlayAlphaState = { value = 0 }
    local profileBoxAlphaState = { value = 0 }
    local pauseAlphaState = { value = 0 }
    local shopBoxAlphaState = { value = 0 }
    local optionsBoxAlphaState = { value = 0 }

    local profileBox, pauseMenuBox, shopBox, optionsBox

    -----------------
    -- Close Button
    -----------------

    local closeButton = nurture.Button:new(N, {
        forcedWidth = 20,
        colors = {
            primaryColor = { 0.1, 0.1, 0.1, 0 },
            hoveredColor = { 0.1, 0.1, 0.1, 0 },
            pressedColor = { 0.1, 0.1, 0.1, 0 },
        },
        zIndex = 100000,
        forcedHeight = 20,
        onClick = function(self)
            if IS_PAUSED_OPEN then
                IS_PAUSED_OPEN = false
                flux.to(pauseAlphaState, 0.2, { value = 0 }):ease("quadout")
                flux.to(pauseMenuBox, 0.2, { _scaleX = 0.8, _scaleY = 0.8 }):ease("backin")
            end
            if IS_SHOP_OPEN then
                IS_SHOP_OPEN = false
                flux.to(shopBoxAlphaState, 0.2, { value = 0 }):ease("quadout")
                flux.to(shopBox, 0.2, { _scaleX = 0.8, _scaleY = 0.8 }):ease("backin")
            end
            if IS_PROFILE_OPEN then
                IS_PROFILE_OPEN = false
                flux.to(profileBoxAlphaState, 0.2, { value = 0 }):ease("quadout")
                flux.to(profileBox, 0.2, { _scaleX = 0.8, _scaleY = 0.8 }):ease("backin")
            end
            if IS_OPTIONS_OPEN then
                IS_OPTIONS_OPEN = false
                flux.to(optionsBoxAlphaState, 0.2, { value = 0 }):ease("quadout")
                flux.to(optionsBox, 0.2, { _scaleX = 0.8, _scaleY = 0.8 }):ease("backin")
            end

            IS_OVERLAY_OPEN = false
            flux.to(overlayAlphaState, 0.2, { value = 0 }):ease("quadout")

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

    ------------
    -- Overlay
    ------------

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
        self.backgroundColor[4] = overlayAlphaState.value

        if overlayAlphaState.value > 0.01 then
            self:show()
        else
            self:hide()
        end
    end)

    ----------------
    -- Profile Modal
    ----------------

    local profileInput = nurture.Input:new(N, {
        width = 360,
        height = 40,
        rounding = 0,
        text = PROFILE,
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
                    flux.to(overlayAlphaState, 0.3, { value = 0.7 }):ease("quadout")
                    flux.to(profileBoxAlphaState, 0.3, { value = 1.0 }):ease("quadout")
                    flux.to(profileBox, 0.3, { _scaleX = 1.0, _scaleY = 1.0 }):ease("backout")
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

    profileBox = nurture.Box:new(N, {
        backgroundColor = { 0.04, 0.04, 0.04, 0 },
        rounding = 10,
        shadow = {
            x = 7,
            y = 7,
            color = { 0, 0, 0, 0 }
        },
        padding = 20,
        x = love.graphics.getWidth() / 2 - 150,
        y = love.graphics.getHeight() / 2 - 150,
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
                                    if IS_PROFILE_OPEN then
                                        PROFILE = profileInput.text
                                        local label = N:get_all_by_classname("profile-label")[1]
                                        label:setText(PROFILE)
                                        IS_PROFILE_OPEN = false
                                        IS_OVERLAY_OPEN = false
                                        flux.to(profileBoxAlphaState, 0.2, { value = 0 }):ease("quadout")
                                        flux.to(profileBox, 0.2, { _scaleX = 0.8, _scaleY = 0.8 }):ease("backin")
                                        flux.to(overlayAlphaState, 0.2, { value = 0 }):ease("quadout")
                                    end
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
                                    if IS_PROFILE_OPEN then
                                        IS_PROFILE_OPEN = false
                                        IS_OVERLAY_OPEN = false
                                        flux.to(profileBoxAlphaState, 0.2, { value = 0 }):ease("quadout")
                                        flux.to(profileBox, 0.2, { _scaleX = 0.8, _scaleY = 0.8 }):ease("backin")
                                        flux.to(overlayAlphaState, 0.2, { value = 0 }):ease("quadout")
                                    end
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

    profileBox:setUpdateCallback(function(self, dt)
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

        if profileBoxAlphaState.value > 0.01 then
            self:show()
        else
            self:hide()
        end
    end)

    -------------
    -- Shop Modal
    -------------

    local shopTitle = nurture.TextLabel:new(N, "Shop", "bigtitle", {
        color = { 1, 1, 1, 0 },
        shadow = {
            x = 6,
            y = 6,
            color = { 0, 0, 0, 0 }
        }
    })

    shopBox = nurture.Box:new(N, {
        backgroundColor = { 0.04, 0.04, 0.04, 0 },
        rounding = 10,
        zIndex = 10000,
        shadow = {
            x = 7,
            y = 7,
            color = { 0, 0, 0, 0 }
        },
        padding = 20,
        x = love.graphics.getWidth() / 2 - 150,
        y = love.graphics.getHeight() / 2 - 150,
        children = {
            nurture.VBox:new(N, {
                spacing = 10,
                children = {
                    shopTitle
                }
            })
        }
    })

    shopBox._scaleX = 0.8
    shopBox._scaleY = 0.8

    shopBox:setUpdateCallback(function(self, dt)
        local currentAlpha = shopBoxAlphaState.value
        self.backgroundColor[4] = currentAlpha
        self.shadow.color[4] = currentAlpha
        self.scaleX = self._scaleX
        self.scaleY = self._scaleY

        if shopTitle then
            shopTitle.color[4] = currentAlpha
            if shopTitle.shadow and shopTitle.shadow.color then
                shopTitle.shadow.color[4] = currentAlpha * 0.7
            end
        end

        if currentAlpha > 0.01 then
            self:show()
        else
            self:hide()
        end
    end)

    ----------------
    -- Options Modal
    ----------------

    local optionsTitle = nurture.TextLabel:new(N, "Options", "bigtitle", {
        color = { 1, 1, 1, 0 },
        shadow = {
            x = 6,
            y = 6,
            color = { 0, 0, 0, 0 }
        }
    })

    -- General tab content
    local generalTab = nurture.Box:new(N, {
        padding = 20,
        backgroundColor = { 0.15, 0.15, 0.2, 0 },
        rounding = 8,
        forcedWidth = 260,
        forcedHeight = 200,
        child = nurture.VBox:new(N, {
            spacing = 15,
            children = {
                nurture.TextLabel:new(N, "General Settings", "title", {
                    color = { 1, 1, 1, 0 }
                }),
                nurture.TextLabel:new(N, "Language: English", "BodyFont", {
                    color = { 0.8, 0.8, 0.8, 0 }
                }),
                nurture.TextLabel:new(N, "Auto-save: Enabled", "BodyFont", {
                    color = { 0.8, 0.8, 0.8, 0 }
                })
            }
        })
    })

    -- Display tab content
    local displayTab = nurture.Box:new(N, {
        padding = 20,
        backgroundColor = { 0.15, 0.15, 0.2, 0 },
        rounding = 8,
        forcedWidth = 260,
        forcedHeight = 200,
        child = nurture.VBox:new(N, {
            spacing = 15,
            children = {
                nurture.TextLabel:new(N, "Display Settings", "title", {
                    color = { 1, 1, 1, 0 }
                }),
                nurture.TextLabel:new(N, "Theme: Dark", "BodyFont", {
                    color = { 0.8, 0.8, 0.8, 0 }
                }),
                nurture.TextLabel:new(N, "UI Scale: 100%", "BodyFont", {
                    color = { 0.8, 0.8, 0.8, 0 }
                })
            }
        })
    })

    -- Video tab content
    local videoTab = nurture.Box:new(N, {
        padding = 20,
        backgroundColor = { 0.12, 0.12, 0.12, 0 },
        rounding = 8,
        forcedWidth = 260,
        forcedHeight = 200,
        halign = "left",
        valign = "top",
        child = nurture.VBox:new(N, {
            spacing = 15,
            children = {
                nurture.TextLabel:new(N, "Video Settings", "title", {
                    color = { 1, 1, 1, 0 }
                }),
                nurture.TextLabel:new(N, "FPS Cap: 60", "BodyFont", {
                    color = { 0.8, 0.8, 0.8, 0 },
                    classname = "fps_cap_label"
                }),
                nurture.Slider:new(N, {
                    value = 60,
                    width = 240,
                    height = 20,
                    knob = nurture.Shape.Rectangle:new(N, {
                        width = 25,
                        height = 25,
                        color = { 1, 1, 1, 1.0 },
                    }),
                    minValue = 30,
                    maxValue = 120,
                    stepSize = 1,
                    onValueChange = function(slider, value)
                        local label = N:get_all_by_classname("fps_cap_label")[1]
                        if label then
                            label:setText("FPS Cap: " .. math.floor(value))
                        end
                    end
                })
            }
        })
    })

    local optionsTabbed = nurture.Tabbed:new(N, {
        tabs = {
            general = generalTab,
            display = displayTab,
            video = videoTab
        },
        tabOrder = { "general", "display", "video" },
        activeTab = "general"
    })

    local optionsTabButtons = {}
    local tabNames = { "General", "Display", "Video" }
    local tabKeys = { "general", "display", "video" }

    for i, tabKey in ipairs(tabKeys) do
        local isActive = (tabKey == optionsTabbed:getActiveTabName())

        local tabButton = nurture.Button:new(N, {
            padding = 10,
            rounding = 0,
            colors = {
                primaryColor = isActive and { 0.3, 0.5, 0.7, 0 } or { 0.12, 0.12, 0.15, 0 },
                hoveredColor = isActive and { 0.35, 0.55, 0.75, 0 } or { 0.25, 0.25, 0.3, 0 },
                pressedColor = isActive and { 0.25, 0.45, 0.65, 0 } or { 0.15, 0.15, 0.2, 0 }
            },
            onClick = function(btn)
                optionsTabbed:switch(tabKey)

                for j, tk in ipairs(tabKeys) do
                    local button = N:get_all_by_classname("options_tab_" .. tk)[1]
                    if tk == optionsTabbed:getActiveTabName() then
                        button:setColors({
                            primaryColor = { 0.3, 0.5, 0.7, optionsBoxAlphaState.value },
                            hoveredColor = { 0.35, 0.55, 0.75, optionsBoxAlphaState.value },
                            pressedColor = { 0.25, 0.45, 0.65, optionsBoxAlphaState.value }
                        })
                    else
                        button:setColors({
                            primaryColor = { 0.2, 0.2, 0.25, optionsBoxAlphaState.value },
                            hoveredColor = { 0.25, 0.25, 0.3, optionsBoxAlphaState.value },
                            pressedColor = { 0.15, 0.15, 0.2, optionsBoxAlphaState.value }
                        })
                    end
                end
            end,
            child = nurture.TextLabel:new(N, tabNames[i], "BodyFont", {
                color = { 1, 1, 1, 0 }
            }),
            classname = "options_tab_" .. tabKey
        })

        table.insert(optionsTabButtons, tabButton)
    end

    local optionsTabBar = nurture.HFracBox:new(N, {
        forcedHeight = 35,
        forcedWidth = 300,
        fractions = { 1 / 3, 1 / 3, 1 / 3 },
        children = optionsTabButtons
    })

    optionsBox = nurture.Box:new(N, {
        backgroundColor = { 0.04, 0.04, 0.04, 0 },
        rounding = 10,
        shadow = {
            x = 7,
            y = 7,
            color = { 0, 0, 0, 0 }
        },
        padding = 20,
        x = love.graphics.getWidth() / 2 - 170,
        y = love.graphics.getHeight() / 2 - 150,
        zIndex = 1001,
        children = {
            nurture.VBox:new(N, {
                spacing = 15,
                children = {
                    optionsTitle,
                    optionsTabBar,
                    optionsTabbed
                }
            })
        }
    })

    optionsBox._scaleX = 0.8
    optionsBox._scaleY = 0.8

    optionsBox:setUpdateCallback(function(self, dt)
        local currentAlpha = optionsBoxAlphaState.value
        self.backgroundColor[4] = currentAlpha
        self.shadow.color[4] = currentAlpha
        self.scaleX = self._scaleX
        self.scaleY = self._scaleY

        if optionsTitle then
            optionsTitle.color[4] = currentAlpha
            if optionsTitle.shadow and optionsTitle.shadow.color then
                optionsTitle.shadow.color[4] = currentAlpha * 0.7
            end
        end

        -- Update tab buttons
        for _, tabKey in ipairs(tabKeys) do
            local button = N:get_all_by_classname("options_tab_" .. tabKey)[1]
            if button then
                button.colors.primaryColor[4] = currentAlpha
                button.colors.hoveredColor[4] = currentAlpha
                button.colors.pressedColor[4] = currentAlpha
                button:_updateCurrentColor()
                local textLabel = button.nurture:getFromUUID(button.childUUID)
                if textLabel then
                    textLabel.color[4] = currentAlpha
                end
            end
        end

        -- Update tab content
        local tabs = { generalTab, displayTab, videoTab }
        for _, tab in ipairs(tabs) do
            if tab then
                tab.backgroundColor[4] = currentAlpha
                local vbox = tab.nurture:getFromUUID(tab.childUUID)
                if vbox then
                    local children = vbox:getChildren()
                    for _, child in ipairs(children) do
                        if child.type == "TextLabel" then
                            child.color[4] = currentAlpha
                        end
                    end
                end
            end
        end

        if currentAlpha > 0.01 then
            self:show()
        else
            self:hide()
        end
    end)

    --------------
    -- Pause Menu
    --------------

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
        if IS_PAUSED_OPEN then
            IS_PAUSED_OPEN = false
            IS_OVERLAY_OPEN = false
            SHOULD_DISABLE_BUTTONS = false
            flux.to(pauseAlphaState, 0.2, { value = 0 }):ease("quadout")
            flux.to(pauseMenuBox, 0.2, { _scaleX = 0.8, _scaleY = 0.8 }):ease("backin")
            flux.to(overlayAlphaState, 0.2, { value = 0 }):ease("quadout")
        end
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
        if IS_PAUSED_OPEN then
            love.event.quit()
        end
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

    pauseMenuBox = nurture.Box:new(N, {
        backgroundColor = { 0.1, 0.1, 0.1, 0 },
        rounding = 15,
        forcedWidth = 300,
        padding = 30,
        x = love.graphics.getWidth() / 2 - 150,
        y = love.graphics.getHeight() / 2 - 175,
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

    pauseMenuBox:setUpdateCallback(function(self, dt)
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

        if pauseAlphaState.value > 0.01 then
            self:show()
        else
            self:hide()
        end
    end)

    pauseMenuBox:hide()

    ---------------------
    -- Main Menu Buttons
    ---------------------

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

    -------------
    -- Main Menu
    -------------

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
                        flux.to(overlayAlphaState, 0.3, { value = 0.7 }):ease("quadout")
                        flux.to(pauseAlphaState, 0.3, { value = 1.0 }):ease("quadout")
                        flux.to(pauseMenuBox, 0.3, { _scaleX = 1.0, _scaleY = 1.0 }):ease("backout")
                        print("play button clicked!")
                    end),
                    create3DButton("Shop", function(btn)
                        IS_SHOP_OPEN = true
                        IS_OVERLAY_OPEN = true
                        flux.to(overlayAlphaState, 0.3, { value = 0.7 }):ease("quadout")
                        flux.to(shopBoxAlphaState, 0.3, { value = 1.0 }):ease("quadout")
                        flux.to(shopBox, 0.3, { _scaleX = 1.0, _scaleY = 1.0 }):ease("backout")
                    end),
                    create3DButton("Options", function(btn)
                        IS_OPTIONS_OPEN = true
                        IS_OVERLAY_OPEN = true
                        flux.to(overlayAlphaState, 0.3, { value = 0.7 }):ease("quadout")
                        flux.to(optionsBoxAlphaState, 0.3, { value = 1.0 }):ease("quadout")
                        flux.to(optionsBox, 0.3, { _scaleX = 1.0, _scaleY = 1.0 }):ease("backout")
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

    ----------------
    -- Main Container
    ----------------

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

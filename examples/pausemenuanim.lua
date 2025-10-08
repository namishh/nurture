local flux = require("assets.flux")

local pauseMenu = nil
local pauseMenuBox = nil
local pauseMenuLabel = nil
local dots = {}
local menuButtons = {}
local isPaused = false
local alphaState = { value = 0 }

local function load(nurture, N)
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    pauseMenuLabel = nurture.TextLabel:new(N, "ANIM PAUSED", "bigtitle", {
        color = { 1, 1, 1, 0 },
        justify = "center",
        horizAlign = "center"
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

    dots = {}
    for i = 1, 16 do
        local dot = nurture.Box:new(N, {
            forcedWidth = 5,
            forcedHeight = 5,
            backgroundColor = { 1, 1, 1, 0 },
            rounding = 4,
        })
        dot._yOffset = 0
        dot._baseY = 0
        table.insert(dots, dot)
    end

    for i, dot in ipairs(dots) do
        local delay = (i - 1) * 0.05

        local function createOscillation()
            flux.to(dot, 0.4, { _yOffset = 1 })
                :ease("sineinout")
                :delay(delay)
                :after(dot, 0.4, { _yOffset = -1 })
                :ease("sineinout")
                :oncomplete(createOscillation)
        end

        createOscillation()
    end

    local dottedLine = nurture.HBox:new(N, {
        spacing = 8,
        padding = 0,
        halign = "center",
        valign = "center",
        children = dots
    })

    local function createMenuButton(text, primaryColor, hoveredColor, pressedColor)
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
            onClick = function(btn)
                print(text .. " clicked!")
            end,
            child = nurture.TextLabel:new(N, text, "BodyFont", {
                color = { 1, 1, 1, 0 }
            })
        })

        button._originalY = button.y
        button._originalShadowY = button.shadow.y

        button.onMousePressed = function(self, x, y, btn)
            print("Mouse pressed")
            if self:isPointInside(x, y) then
                self._isPressed = true
                if not self._originalYSet then
                    self._originalY = self.y
                    self._originalShadowY = self.shadow.y
                    self._originalYSet = true
                end
                self.y = self._originalY + 3
                self:setShadowOffset(0, 1)
                self:updateSize()
                self:_updateCurrentColor()
            end
        end

        button.onMouseReleased = function(self, x, y, btn)
            if self._isPressed then
                self.y = self._originalY
                self:setShadowOffset(0, self._originalShadowY)
                self:updateSize()

                if self:isPointInside(x, y) then
                    self:onClick(x, y, btn)
                end
            end
            self._isPressed = false
        end

        return button
    end

    local resumeButton = createMenuButton("RESUME",
        { 0.3, 0.7, 0.4, 0 },
        { 0.4, 0.8, 0.5, 0 },
        { 0.2, 0.6, 0.3, 0 })

    resumeButton:setOnClick(function(btn)
        print("RESUME clicked!")
        if isPaused then
            isPaused = false
            flux.to(alphaState, 0.1, { value = 0 })
                :ease("quadout")
                :oncomplete(function()
                    if pauseMenu then
                        pauseMenu:hide()
                    end
                end)
        end
    end)

    local menuButton = createMenuButton("GO TO MENU",
        { 0.4, 0.5, 0.7, 0 },
        { 0.5, 0.6, 0.8, 0 },
        { 0.3, 0.4, 0.6, 0 })

    local optionsButton = createMenuButton("OPTIONS",
        { 0.6, 0.4, 0.7, 0 },
        { 0.7, 0.5, 0.8, 0 },
        { 0.5, 0.3, 0.6, 0 })

    local quitButton = createMenuButton("QUIT GAME",
        { 0.8, 0.3, 0.3, 0 },
        { 0.9, 0.4, 0.4, 0 },
        { 0.7, 0.2, 0.2, 0 })

    menuButtons = { resumeButton, menuButton, optionsButton, quitButton }

    local buttonsVBox = nurture.VBox:new(N, {
        spacing = 10,
        padding = 0,
        halign = "center",
        valign = "center",
        zIndex = 102,
        children = menuButtons
    })

    local pauseMenuVBox = nurture.VBox:new(N, {
        spacing = 20,
        padding = 0,
        halign = "center",
        valign = "center",
        zIndex = 102,
        children = {
            pauseMenuLabel,
            dottedLine,
            buttonsVBox
        }
    })

    pauseMenuBox = nurture.Box:new(N, {
        backgroundColor = { 0.2, 0.2, 0.25, 0 },
        rounding = 15,
        forcedWidth = 300,
        padding = 30,
        halign = "center",
        valign = "center",
        zIndex = 1,
        shadow = {
            x = 0,
            y = 8,
            color = { 0, 0, 0, 0 }
        },
        children = {
            pauseMenuVBox
        }
    })

    pauseMenu = nurture.Box:new(N, {
        x = 0,
        y = 0,
        forcedWidth = windowWidth,
        forcedHeight = windowHeight,
        backgroundColor = { 0, 0, 0, 0 },
        rounding = 0,
        padding = 50,
        halign = "center",
        valign = "center",
        zIndex = 100,
        children = {
            pauseMenuBox
        }
    })

    pauseMenu:setUpdateCallback(function(widget, dt)
        flux.update(dt)

        local currentAlpha = alphaState.value
        widget.backgroundColor[4] = currentAlpha

        if pauseMenuBox then
            pauseMenuBox.backgroundColor[4] = currentAlpha / 0.8
            pauseMenuBox.shadow.color[4] = (currentAlpha / 0.8) * 0.5
        end

        if pauseMenuLabel then
            pauseMenuLabel.color[4] = currentAlpha / 0.8
            -- Apply scale and rotation animation
            pauseMenuLabel.scaleX = pauseMenuLabel._scaleX
            pauseMenuLabel.scaleY = pauseMenuLabel._scaleY
            pauseMenuLabel.rotation = pauseMenuLabel._rotation
        end

        for _, dot in ipairs(dots) do
            dot.backgroundColor[4] = currentAlpha / 0.8
            if dot._baseY == 0 then
                dot._baseY = dot.y
            end
            dot.y = dot._baseY + dot._yOffset
        end

        for _, button in ipairs(menuButtons) do
            local normalizedAlpha = currentAlpha / 0.8
            button.colors.primaryColor[4] = normalizedAlpha
            button.colors.hoveredColor[4] = normalizedAlpha
            button.colors.pressedColor[4] = normalizedAlpha
            button.shadow.color[4] = normalizedAlpha * 0.5
            button:_updateCurrentColor()

            local textLabel = button.nurture:getFromUUID(button.childUUID)
            if textLabel then
                textLabel.color[4] = normalizedAlpha
            end
        end
    end)

    pauseMenu:hide()
    isPaused = false

    nurture.TextLabel:new(N, "Press 0 to toggle pause menu", "BodyFont", {
        color = { 1, 1, 1, 1 },
    })
end

local function togglePause()
    if not pauseMenu then return end

    isPaused = not isPaused
    if isPaused then
        pauseMenu:show()
        flux.to(alphaState, 0.1, { value = 0.8 })
            :ease("quadout")
        print("Game paused")
    else
        flux.to(alphaState, 0.1, { value = 0 })
            :ease("quadout")
            :oncomplete(function()
                if pauseMenu then
                    pauseMenu:hide()
                end
            end)
        print("Game resumed")
    end
end

local function keypressed(key)
    if key == "0" then
        togglePause()
    end
end

return {
    load = load,
    keypressed = keypressed
}

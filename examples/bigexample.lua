local flux = require("assets.flux")

IS_OVERLAY_OPEN = false 

local function load(nurture, N)

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
                if IS_OVERLAY_OPEN then
                    return
                end
                onClick(self)
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
            if IS_OVERLAY_OPEN then
                return
            end
            flux.to(self, 0.1, { _scaleX = 1.08, _scaleY = 1.08 }):ease("quadout")
        end)
        
        button:setOnMouseLeave(function(self, x, y)
            if IS_OVERLAY_OPEN then
                return
            end
            flux.to(self, 0.1, { _scaleX = 1.0, _scaleY = 1.0 }):ease("quadout")
        end)
        
        button:setUpdateCallback(function(self, dt)
            if IS_OVERLAY_OPEN then
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
                        print("play button clicked!")
                    end),
                    create3DButton("Shop", function(btn)
                        print("Shop button clicked!")
                    end),
                    create3DButton("Options", function(btn)
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
                forcedHeight = love.graphics.getHeight() - 80,
                forcedWidth = love.graphics.getWidth() - 80,
                children = {
                    menu
                }
            })
        }
    })
    
    mainmenubox:setBackgroundShaderValue('SPIN_ROTATION', 1.0)
    mainmenubox:setBackgroundShaderValue('SPIN_SPEED', 0.001)
    mainmenubox:setBackgroundShaderValue('OFFSET', {0.0, 0.0})
    mainmenubox:setBackgroundShaderValue('COLOUR_1', {0.2, 0.3, 0.5, 1.0})
    mainmenubox:setBackgroundShaderValue('COLOUR_2', {0.8, 0.4, 0.2, 1.0})
    mainmenubox:setBackgroundShaderValue('COLOUR_3', {0.1, 0.1, 0.1, 1.0})
    mainmenubox:setBackgroundShaderValue('CONTRAST', 1.5)
    mainmenubox:setBackgroundShaderValue('LIGTHING', 0.5)
    mainmenubox:setBackgroundShaderValue('SPIN_AMOUNT', 0.5)
    mainmenubox:setBackgroundShaderValue('PIXEL_FILTER', 800.0)
    mainmenubox:setBackgroundShaderValue('SPIN_EASE', 1.0)
    mainmenubox:setBackgroundShaderValue('IS_ROTATE', 1.0)
    
    local time = 0
    mainmenubox:setUpdateCallback(function(widget, dt)
        time = time + dt
        widget:setBackgroundShaderValue("time", time)
    end)

end

return {
    load = load
}

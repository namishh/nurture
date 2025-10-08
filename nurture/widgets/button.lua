local BaseWidget = require("nurture.basewidget")

local Button = setmetatable({}, { __index = BaseWidget })
Button.__index = Button

---@diagnostic disable-next-line: duplicate-set-field
function Button:new(N, options)
    local self = setmetatable(BaseWidget:new("Button"), Button)
    self.nurture = N
    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self.paddingLeft = 0
    self.paddingRight = 0
    self.paddingTop = 0
    self.paddingBottom = 0

    self.shadow = options.shadow or {}

    if options.padding then
        if type(options.padding) == "number" then
            self.paddingLeft = options.padding
            self.paddingRight = options.padding
            self.paddingTop = options.padding
            self.paddingBottom = options.padding
        elseif type(options.padding) == "table" then
            self.paddingLeft = options.padding.left or 0
            self.paddingRight = options.padding.right or 0
            self.paddingTop = options.padding.top or 0
            self.paddingBottom = options.padding.bottom or 0
        else
            error("Button:new(): Padding must be a number or a table")
        end
    end

    self.colors = options.colors or {}
    self.colors.primaryColor = self.colors.primaryColor or { 0.2, 0.5, 0.8, 1.0 }
    self.colors.hoveredColor = self.colors.hoveredColor or { 0.3, 0.6, 0.9, 1.0 }
    self.colors.pressedColor = self.colors.pressedColor or { 0.1, 0.4, 0.7, 1.0 }
    self.colors.disabledColor = self.colors.disabledColor or { 0.5, 0.5, 0.5, 0.5 }

    self.currentColor = self.colors.primaryColor

    self._widgetCannotHaveChildren = false
    self.childUUID = nil

    self.valign = options.valign or "center"
    self.halign = options.halign or "center"
    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.horizAlign = options.horizAlign
    self.vertAlign = options.vertAlign

    self.rx = nil
    self.ry = nil
    self.segments = nil

    if options.rounding then
        if type(options.rounding) == "number" then
            self.rx = options.rounding
            self.ry = options.rounding
        elseif type(options.rounding) == "table" then
            self.rx = options.rounding.rx or options.rounding[1]
            self.ry = options.rounding.ry or options.rounding[2] or self.rx
            self.segments = options.rounding.segments
        end
    end

    if options.rx then self.rx = options.rx end
    if options.ry then self.ry = options.ry end
    if options.segments then self.segments = options.segments end

    self.backgroundShader = nil
    if options.backgroundShader then
        self.backgroundShader = love.graphics.newShader(options.backgroundShader)
    end

    self.shader = nil
    if options.shader then
        self.shader = love.graphics.newShader(options.shader)
    end

    if options.zIndex then self.zIndex = options.zIndex end
    if options.classname then self.classname = options.classname end

    self._isPressed = false
    self.disabled = options.disabled or false

    self._userClickCallback = options.onClick or options.clickCallback
    self._userMouseOverCallback = options.onMouseOver or options.mouseOverCallback
    self._userMouseLeaveCallback = options.onMouseLeave or options.mouseLeaveCallback

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    local childToSet = nil
    if options.child then
        childToSet = options.child
    elseif options.children and #options.children > 0 then
        childToSet = options.children[1]
    end

    if childToSet then
        self:_addChildRelationship(childToSet)
        self.childUUID = childToSet.uuid
    end

    self:updateSize()


    return self
end

function Button:setColors(colors)
    if colors.primaryColor then self.colors.primaryColor = colors.primaryColor end
    if colors.hoveredColor then self.colors.hoveredColor = colors.hoveredColor end
    if colors.pressedColor then self.colors.pressedColor = colors.pressedColor end
    if colors.disabledColor then self.colors.disabledColor = colors.disabledColor end
    self:_updateCurrentColor()
end

function Button:setPrimaryColor(r, g, b, a)
    self.colors.primaryColor = { r, g, b, a or 1 }
    self:_updateCurrentColor()
end

function Button:setHoveredColor(r, g, b, a)
    self.colors.hoveredColor = { r, g, b, a or 1 }
    self:_updateCurrentColor()
end

function Button:setPressedColor(r, g, b, a)
    self.colors.pressedColor = { r, g, b, a or 1 }
    self:_updateCurrentColor()
end

function Button:setDisabledColor(r, g, b, a)
    self.colors.disabledColor = { r, g, b, a or 1 }
    self:_updateCurrentColor()
end

function Button:_updateCurrentColor()
    if self.disabled then
        self.currentColor = self.colors.disabledColor
    elseif self._isPressed then
        self.currentColor = self.colors.pressedColor
    elseif self._isMouseOver then
        self.currentColor = self.colors.hoveredColor
    else
        self.currentColor = self.colors.primaryColor
    end
end

function Button:setBackgroundShader(shaderPath)
    if shaderPath then
        self.backgroundShader = love.graphics.newShader(shaderPath)
    else
        self.backgroundShader = nil
    end
end

function Button:setBackgroundShaderValue(key, value)
    if self.backgroundShader then
        self.backgroundShader:send(key, value)
    end
end

function Button:setShader(shaderPath)
    if shaderPath then
        self.shader = love.graphics.newShader(shaderPath)
    else
        self.shader = nil
    end
end

function Button:setShaderValue(key, value)
    if self.shader then
        self.shader:send(key, value)
    end
end

function Button:setPadding(padding)
    if type(padding) == "number" then
        self.paddingLeft = padding
        self.paddingRight = padding
        self.paddingTop = padding
        self.paddingBottom = padding
    elseif type(padding) == "table" then
        self.paddingLeft = padding.left or 0
        self.paddingRight = padding.right or 0
        self.paddingTop = padding.top or 0
        self.paddingBottom = padding.bottom or 0
    else
        error("Button:setPadding(): Padding must be a number or a table")
    end
end

function Button:setShadowOffset(x, y)
    self.shadow.x = x
    self.shadow.y = y
end

function Button:setShadowColor(r, g, b, a)
    self.shadow.color = { r, g, b, a }
end

function Button:setChild(child)
    if self.childUUID then
        local oldChild = self.nurture:getFromUUID(self.childUUID)
        if oldChild then
            self:_removeChildRelationship(oldChild)
        end
    end
    self:_addChildRelationship(child)
    self.childUUID = child.uuid

    self:updateSize()
end

function Button:setOnClick(callback)
    self._userClickCallback = callback
end

function Button:setOnMouseOver(callback)
    self._userMouseOverCallback = callback
end

function Button:setOnMouseLeave(callback)
    self._userMouseLeaveCallback = callback
end

function Button:setDisabled(disabled)
    self.disabled = disabled
    self:_updateCurrentColor()
end

---@diagnostic disable-next-line: duplicate-set-field
function Button:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Button:update(dt)
    BaseWidget.update(self, dt)

    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.update then
        child:update(dt)
    end
end

function Button:updateSize()
    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child then
        if self.forcedWidth then
            self.width = self.forcedWidth
        end

        if self.forcedHeight then
            self.height = self.forcedHeight
        end

        if child.updateSize and child.type == "TextLabel" then
            child:updateSize()
        end

        local contentWidth = child.width
        local contentHeight = child.height

        local minButtonWidth = contentWidth + self.paddingLeft + self.paddingRight
        local minButtonHeight = contentHeight + self.paddingTop + self.paddingBottom

        if self.forcedWidth then
            self.width = math.max(self.forcedWidth, minButtonWidth)
        else
            self.width = minButtonWidth
        end

        if self.forcedHeight then
            self.height = math.max(self.forcedHeight, minButtonHeight)
        else
            self.height = minButtonHeight
        end

        local availableWidth = self.width - self.paddingLeft - self.paddingRight
        local availableHeight = self.height - self.paddingTop - self.paddingBottom

        local childX = self.x + self.paddingLeft
        if self.halign == "center" then
            childX = self.x + self.paddingLeft + (availableWidth - contentWidth) / 2
        elseif self.halign == "right" then
            childX = self.x + self.width - self.paddingRight - contentWidth
        end

        local childY = self.y + self.paddingTop
        if self.valign == "center" then
            childY = self.y + self.paddingTop + (availableHeight - contentHeight) / 2
        elseif self.valign == "bottom" then
            childY = self.y + self.height - self.paddingBottom - contentHeight
        end

        child.x = childX
        child.y = childY

        -- Update child after position is set (important for VBox/HBox)
        if child.updateSize then
            child:updateSize()
        end
    else
        if self.forcedWidth then
            self.width = self.forcedWidth
        else
            self.width = self.paddingLeft + self.paddingRight
        end

        if self.forcedHeight then
            self.height = self.forcedHeight
        else
            self.height = self.paddingTop + self.paddingBottom
        end
    end
end

function Button:setAlignment(halign, valign)
    if halign then
        if halign ~= "center" and halign ~= "left" and halign ~= "right" then
            error("Button:setAlignment(): Invalid halign: " .. halign)
        end
        self.halign = halign
    end
    if valign then
        if valign ~= "center" and valign ~= "top" and valign ~= "bottom" then
            error("Button:setAlignment(): Invalid valign: " .. valign)
        end
        self.valign = valign
    end
end

function Button:setHAlign(halign)
    if halign ~= "center" and halign ~= "left" and halign ~= "right" then
        error("Button:setHAlign(): Invalid halign: " .. halign)
    end
    self.halign = halign
end

function Button:setVAlign(valign)
    if valign ~= "center" and valign ~= "top" and valign ~= "bottom" then
        error("Button:setVAlign(): Invalid valign: " .. valign)
    end
    self.valign = valign
end

function Button:setRounding(rounding)
    if type(rounding) == "number" then
        self.rx = rounding
        self.ry = rounding
    elseif type(rounding) == "table" then
        self.rx = rounding.rx or rounding[1]
        self.ry = rounding.ry or rounding[2] or self.rx
        self.segments = rounding.segments
    elseif rounding == nil then
        self.rx = nil
        self.ry = nil
        self.segments = nil
    else
        error("Button:setRounding(): Rounding must be a number, table, or nil")
    end
end

function Button:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Button:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Button:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Button:onClick(x, y, button)
    if self.disabled then
        return
    end

    self._isPressed = false
    self:_updateCurrentColor()

    if self._userClickCallback then
        self._userClickCallback(self, x, y, button)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Button:onMouseOver(x, y)
    if self.disabled then
        return
    end

    self:_updateCurrentColor()

    if self._userMouseOverCallback then
        self._userMouseOverCallback(self, x, y)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Button:onMouseLeave(x, y)
    if self.disabled then
        return
    end

    self._isPressed = false
    self:_updateCurrentColor()

    if self._userMouseLeaveCallback then
        self._userMouseLeaveCallback(self, x, y)
    end
end

function Button:onMousePressed(x, y, button)
    if self.disabled then
        return
    end

    if self:isPointInside(x, y) then
        self._isPressed = true
        self:_updateCurrentColor()
    end
end

function Button:onMouseReleased(x, y, button)
    if self.disabled then
        return
    end

    if self._isPressed and self:isPointInside(x, y) then
        self:onClick(x, y, button)
    else
        self._isPressed = false
        self:_updateCurrentColor()
    end
end

---@diagnostic disable-next-line
function Button:draw()
    if not self.visible or not self.enabled then
        return
    end

    if self.shader then
        love.graphics.setShader(self.shader)
    end

    if self.shadow then
        if (self.shadow.x ~= 0 or self.shadow.y ~= 0) and self.shadow.color then
            if self.shadow.color[4] > 0 then
                love.graphics.setColor(self.shadow.color[1], self.shadow.color[2], self.shadow.color[3],
                    self.shadow.color[4])
                love.graphics.rectangle("fill", self.x + self.shadow.x, self.y + self.shadow.y, self.width, self.height,
                    self.rx, self.ry, self.segments)
            end
        end
    end

    if self.currentColor[4] > 0 then
        local oldColor = { love.graphics.getColor() }

        if self.backgroundShader then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setShader(self.backgroundShader)
        else
            love.graphics.setColor(
                self.currentColor[1],
                self.currentColor[2],
                self.currentColor[3],
                self.currentColor[4]
            )
        end

        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.rx, self.ry, self.segments)

        if self.backgroundShader then
            if self.shader then
                love.graphics.setShader(self.shader)
            else
                love.graphics.setShader()
            end
        end

        love.graphics.setColor(oldColor[1], oldColor[2], oldColor[3], oldColor[4])
    end

    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.visible and child.draw then
        child:draw()
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    if self.shader then
        love.graphics.setShader()
    end
end

return Button

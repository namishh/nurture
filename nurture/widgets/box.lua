local BaseWidget = require("nurture.basewidget")

local Box = setmetatable({}, { __index = BaseWidget })
Box.__index = Box

---@diagnostic disable-next-line: duplicate-set-field
function Box:new(N, options)
    local self = setmetatable(BaseWidget:new("Box"), Box)
    self.nurture = N
    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self.paddingLeft = 0
    self.shadow = options.shadow or {}
    self.paddingRight = 0
    self.paddingTop = 0
    self.paddingBottom = 0

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
            error("Box:new(): Padding must be a number or a table")
        end
    end

    self.backgroundColor = options.backgroundColor or { 0.1, 0.1, 0.1, 0.8 }
    self._widgetCannotHaveChildren = false
    self.childUUID = nil

    self.valign = options.valign or "center"
    self.halign = options.halign or "center"
    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.horizAlign = options.horizAlign
    self.vertAlign = options.vertAlign

    self.stackHorizAlign = options.stackHorizAlign
    self.stackVertAlign = options.stackVertAlign

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
        self.backgroundShader = N:loadShader(options.backgroundShader)
    end

    self.shader = nil
    if options.shader then
        self.shader = N:loadShader(options.shader)
    end

    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    self.rotation = options.rotation or 0
    self.scaleX = options.scaleX or 1
    self.scaleY = options.scaleY or 1

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

function Box:setBackgroundColor(r, g, b, a)
    self.backgroundColor = { r, g, b, a or 1 }
end

function Box:setBackgroundShader(shaderPath)
    if shaderPath then
        self.backgroundShader = self.nurture:loadShader(shaderPath)
    else
        self.backgroundShader = nil
    end
end

function Box:setBackgroundShaderValue(key, value)
    if self.backgroundShader then
        self.backgroundShader:send(key, value)
    end
end

function Box:setShader(shaderPath)
    if shaderPath then
        self.shader = self.nurture:loadShader(shaderPath)
    else
        self.shader = nil
    end
end

function Box:setShaderValue(key, value)
    if self.shader then
        self.shader:send(key, value)
    end
end

function Box:setPadding(padding)
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
        error("Box:setPadding(): Padding must be a number or a table")
    end
end

function Box:setShadowOffset(x, y)
    self.shadow.x = x
    self.shadow.y = y
end

function Box:setShadowColor(r, g, b, a)
    self.shadow.color = { r, g, b, a }
end

function Box:setChild(child)
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

---@diagnostic disable-next-line: duplicate-set-field
function Box:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:update(dt)
    BaseWidget.update(self, dt)

    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.update then
        child:update(dt)
    end
end

function Box:updateSize()
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

        local minboxWidth = contentWidth + self.paddingLeft + self.paddingRight
        local minboxHeight = contentHeight + self.paddingTop + self.paddingBottom

        if self.forcedWidth then
            self.width = math.max(self.forcedWidth, minboxWidth)
        else
            self.width = minboxWidth
        end

        if self.forcedHeight then
            self.height = math.max(self.forcedHeight, minboxHeight)
        else
            self.height = minboxHeight
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

function Box:setAlignment(halign, valign)
    if halign then
        if halign ~= "center" and halign ~= "left" and halign ~= "right" then
            error("Box:setAlignment(): Invalid halign: " .. halign)
        end
        self.halign = halign
    end
    if valign then
        if valign ~= "center" and valign ~= "top" and valign ~= "bottom" then
            error("Box:setAlignment(): Invalid valign: " .. valign)
        end
        self.valign = valign
    end
end

function Box:setHAlign(halign)
    if halign ~= "center" and halign ~= "left" and halign ~= "right" then
        error("Box:setHAlign(): Invalid halign: " .. halign)
    end
    self.halign = halign
end

function Box:setVAlign(valign)
    if valign ~= "center" and valign ~= "top" and valign ~= "bottom" then
        error("Box:setVAlign(): Invalid valign: " .. valign)
    end
    self.valign = valign
end

function Box:setRounding(rounding)
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
        error("Box:setRounding(): Rounding must be a number, table, or nil")
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:draw()
    if not self.visible or not self.enabled then
        return
    end

    love.graphics.push()
    local centerX = self.x + self.width / 2
    local centerY = self.y + self.height / 2
    love.graphics.translate(centerX, centerY)
    love.graphics.rotate(self.rotation)
    love.graphics.scale(self.scaleX, self.scaleY)
    love.graphics.translate(-centerX, -centerY)

    if self.shader then
        love.graphics.setShader(self.shader)
    end

    if self.shadow and self.shadow.x and self.shadow.y and self.shadow.color then
        if (self.shadow.x ~= 0 or self.shadow.y ~= 0) and self.shadow.color[4] and self.shadow.color[4] > 0 then
            love.graphics.setColor(self.shadow.color[1], self.shadow.color[2], self.shadow.color[3],
                self.shadow.color[4])
            love.graphics.rectangle("fill", self.x + self.shadow.x, self.y + self.shadow.y, self.width, self.height, self.rx, self.ry, self.segments)
        end
    end

    if self.backgroundColor[4] > 0 then
        local oldColor = { love.graphics.getColor() }
        love.graphics.setColor(
            self.backgroundColor[1],
            self.backgroundColor[2],
            self.backgroundColor[3],
            self.backgroundColor[4]
        )

        if self.backgroundShader then
            love.graphics.setShader(self.backgroundShader)
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

    -- Pop scale transformation
    love.graphics.pop()
end

function Box:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Box:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Box:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

function Box:onMousePressed(x, y, button)
    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.enabled and child.onMousePressed then
        child:onMousePressed(x, y, button)
    end
end

function Box:onMouseReleased(x, y, button)
    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.enabled and child.onMouseReleased then
        child:onMouseReleased(x, y, button)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:onDrag(x, y, dx, dy)
    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.enabled and child.onDrag then
        child:onDrag(x, y, dx, dy)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:onDragEnd(x, y, button)
    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.enabled and child.onDragEnd then
        child:onDragEnd(x, y, button)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)
    
    local child = self.childUUID and self.nurture:getFromUUID(self.childUUID)
    if child and child.enabled and child.updateMouseState then
        child:updateMouseState(mx, my)
    end
end

return Box

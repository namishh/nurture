local BaseWidget = require("nurture.basewidget")

local HBox = setmetatable({}, { __index = BaseWidget })
HBox.__index = HBox

---@diagnostic disable-next-line: duplicate-set-field
function HBox:new(N, options)
    local self = setmetatable(BaseWidget:new("HBox"), HBox)
    self.nurture = N
    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = false
    self.spacing = options.spacing or 0
    self.justify = options.justify or "left"

    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.addChildCallback = nil
    self.removeChildCallback = nil
    self.sizeChangeCallback = nil

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

    local children = options.children or {}
    for _, child in ipairs(children) do
        self:_addChildRelationship(child)
    end

    self:updateSize()

    return self
end

function HBox:setSpacing(spacing)
    self.spacing = spacing
    self:updateSize()
end

function HBox:setJustify(justify)
    local validJustify = {
        left = true,
        right = true,
        center = true,
        ["space-evenly"] = true,
        ["space-between"] = true
    }
    if not validJustify[justify] then
        error("HBox:setJustify(): Invalid justify: " ..
            justify .. ". Must be one of: left, right, center, space-evenly, space-between")
    end
    self.justify = justify
    self:updateSize()
end

function HBox:setAddChildCallback(callback)
    self.addChildCallback = callback
end

function HBox:setRemoveChildCallback(callback)
    self.removeChildCallback = callback
end

function HBox:setSizeChangeCallback(callback)
    self.sizeChangeCallback = callback
end

function HBox:addChild(child)
    self:_addChildRelationship(child)
    self:updateSize()

    if self.addChildCallback then
        self.addChildCallback(self, child)
    end
end

function HBox:removeChild(child, deleteChild)
    if deleteChild and child.delete then
        child:delete()
    else
        self:_removeChildRelationship(child)
    end
    
    self:updateSize()

    if self.removeChildCallback then
        self.removeChildCallback(self, child)
    end
end

function HBox:clear(deleteChildren)
    local children = self:getChildren()
    for _, child in ipairs(children) do
        if deleteChildren and child.delete then
            child:delete()
        else
            self:_removeChildRelationship(child)
        end
    end
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:update(dt)
    BaseWidget.update(self, dt)

    local children = self:getChildren()
    for _, child in ipairs(children) do
        if child and child.update then
            child:update(dt)
        end
    end
end

function HBox:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function HBox:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function HBox:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:draw()
    if not self.visible or not self.enabled then
        return
    end

    -- Apply scale transformation
    love.graphics.push()
    local centerX = self.x + self.width / 2
    local centerY = self.y + self.height / 2
    love.graphics.translate(centerX, centerY)
    love.graphics.rotate(self.rotation)
    love.graphics.scale(self.scaleX, self.scaleY)
    love.graphics.translate(-centerX, -centerY)

    local children = self:getChildren()
    for _, child in ipairs(children) do
        if child and child.visible and child.draw then
            child:draw()
        end
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    -- Pop scale transformation
    love.graphics.pop()
end

function HBox:updateSize()
    local oldWidth = self.width
    local oldHeight = self.height
    
    local children = self:getChildren()
    local numChildren = #children

    if numChildren == 0 then
        self.width = self.forcedWidth or 0
        self.height = self.forcedHeight or 0

        if self.sizeChangeCallback and (oldWidth ~= self.width or oldHeight ~= self.height) then
            self.sizeChangeCallback(self, oldWidth, oldHeight, self.width, self.height)
        end
        return
    end

    local sumChildrenWidth = 0
    local tallestChildHeight = 0

    for _, child in ipairs(children) do
        sumChildrenWidth = sumChildrenWidth + child.width
        if child.height > tallestChildHeight then
            tallestChildHeight = child.height
        end
    end

    local totalSpacing = self.spacing * (numChildren - 1)
    local contentWidth = sumChildrenWidth + totalSpacing

    self.width = math.max(self.forcedWidth or 0, contentWidth)
    self.height = math.max(self.forcedHeight or 0, tallestChildHeight)

    local availableWidth = self.width
    local availableHeight = self.height

    local targetHeight = self.forcedHeight or tallestChildHeight

    local childX = self.x
    local startX = childX
    local gap = self.spacing

    if self.justify == "right" then
        local extraSpace = availableWidth - contentWidth
        startX = self.x + extraSpace
    elseif self.justify == "center" then
        local extraSpace = availableWidth - contentWidth
        startX = self.x + extraSpace / 2
    elseif self.justify == "space-evenly" then
        gap = (availableWidth - sumChildrenWidth) / (numChildren + 1)
        startX = self.x + gap
    elseif self.justify == "space-between" then
        if numChildren > 1 then
            gap = (availableWidth - sumChildrenWidth) / (numChildren - 1)
        end
        startX = self.x
    end

    childX = startX

    for _, child in ipairs(children) do
        local vertAlign = child.vertAlign or "stretch"

        if not child._originalForcedHeight and vertAlign ~= "stretch" then
            child._originalForcedHeight = child.forcedHeight
        end

        local childY = self.y
        local childHeight = child.height

        if vertAlign == "stretch" then
            if child.setForcedHeight then
                child:setForcedHeight(targetHeight)
            end
            childHeight = targetHeight
            childY = self.y
        else
            if child._originalForcedHeight ~= nil and child.setForcedHeight then
                if child.forcedHeight ~= child._originalForcedHeight then
                    child:setForcedHeight(child._originalForcedHeight)
                end
            end
            
            if vertAlign == "top" then
                childY = self.y
            elseif vertAlign == "center" then
                childY = self.y + (availableHeight - childHeight) / 2
            elseif vertAlign == "bottom" then
                childY = self.y + self.height - childHeight
            end
        end

        child.x = childX
        child.y = childY

        if child.updateSize then
            child:updateSize()
        end

        childX = childX + child.width + gap
    end

    if self.sizeChangeCallback and (oldWidth ~= self.width or oldHeight ~= self.height) then
        self.sizeChangeCallback(self, oldWidth, oldHeight, self.width, self.height)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:onMousePressed(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMousePressed then
            child:onMousePressed(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:onMouseReleased(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMouseReleased then
            child:onMouseReleased(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)
    
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.updateMouseState then
            child:updateMouseState(mx, my)
        end
    end
end

return HBox

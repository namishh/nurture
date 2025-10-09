local BaseWidget = require("nurture.basewidget")

local VBox = setmetatable({}, { __index = BaseWidget })
VBox.__index = VBox

---@diagnostic disable-next-line: duplicate-set-field
function VBox:new(N, options)
    local self = setmetatable(BaseWidget:new("VBox"), VBox)
    self.nurture = N

    self.x = options.x or 0
    self.y = options.y or 0 

    self._widgetCannotHaveChildren = false
    self.spacing = options.spacing or 0
    self.justify = options.justify or "top"

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

function VBox:setSpacing(spacing)
    self.spacing = spacing
end

function VBox:setJustify(justify)
    local validJustify = {
        top = true,
        center = true,
        bottom = true,
        ['space-between'] = true,
        ['space-around'] = true,
    }

    if not validJustify[justify] then
        error("VBox:setJustify(): Invalid justify value: " .. justify)
    end

    self.justify = justify
    self:updateSize()
end

function VBox:setAddChildCallback(callback)
    self.addChildCallback = callback
end

function VBox:setRemoveChildCallback(callback)
    self.removeChildCallback = callback
end

function VBox:setSizeChangeCallback(callback)
    self.sizeChangeCallback = callback
end

function VBox:addChild(child)
    self:_addChildRelationship(child)
    self:updateSize()

    if self.addChildCallback then
        self.addChildCallback(self, child)
    end
end

function VBox:removeChild(child)
    self:_removeChildRelationship(child)
    self:updateSize()

    if self.removeChildCallback then
        self.removeChildCallback(self, child)
    end
end

function VBox:clear()
    local children = self:getChildren()
    for _, child in ipairs(children) do
        self:_removeChildRelationship(child)
    end
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function VBox:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function VBox:update(dt)
    BaseWidget.update(self, dt)

    local children = self:getChildren()
    for _, child in ipairs(children) do
        if child and child.update then
            child:update(dt)
        end
    end
end

function VBox:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function VBox:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function VBox:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function VBox:draw()
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

function VBox:updateSize()
    local oldWidth = self.width
    local oldHeight = self.height

    local totalHeight = 0
    local maxWidth = 0

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

    local sumChildrenHeight = 0
    local widestChildWidth = 0

    for _, child in ipairs(children) do
        sumChildrenHeight = sumChildrenHeight + child.height
        if child.width > widestChildWidth then
            widestChildWidth = child.width
        end
    end

    local totalSpacing = self.spacing * (numChildren - 1)
    local contentHeight = sumChildrenHeight + totalSpacing

    self.width = math.max(self.forcedWidth or 0, widestChildWidth)
    self.height = math.max(self.forcedHeight or 0, contentHeight)

    local availableWidth = self.width
    local availableHeight = self.height

    local targetWidth = self.forcedWidth or widestChildWidth


    local childY = self.y
    local startY = childY
    local gap = self.spacing

    if self.justify == "bottom" then
        local extraSpace = availableHeight - contentHeight
        startY = self.y + extraSpace
    elseif self.justify == "center" then
        local extraSpace = availableHeight - contentHeight
        startY = self.y + extraSpace / 2
    elseif self.justify == "space-evenly" then
        gap = (availableHeight - sumChildrenHeight) / (numChildren + 1)
        startY = self.y + gap
    elseif self.justify == "space-between" then
        if numChildren > 1 then
            gap = (availableHeight - sumChildrenHeight) / (numChildren - 1)
        end
        startY = self.y
    end

    childY = startY
    for _, child in ipairs(children) do
        local horizAlign = child.horizAlign or "stretch"

        if not child._originalForcedWidth and horizAlign ~= "stretch" then
            child._originalForcedWidth = child.forcedWidth
        end

        local childX = self.x
        local childWidth = child.width

        if horizAlign == "stretch" then
            if child.setForcedWidth then
                child:setForcedWidth(targetWidth)
            end
            childWidth = targetWidth
            childX = self.x
        else
            if child._originalForcedWidth ~= nil and child.setForcedWidth then
                if child.forcedWidth ~= child._originalForcedWidth then
                    child:setForcedWidth(child._originalForcedWidth)
                end
            end
            
            if horizAlign == "left" then
                childX = self.x
            elseif horizAlign == "center" then
                childX = self.x + (availableWidth - childWidth) / 2
            elseif horizAlign == "right" then
                childX = self.x + self.width - childWidth
            end
        end

        child.x = childX
        child.y = childY

        if child.updateSize then
            child:updateSize()
        end

        childY = childY + child.height + gap
    end
    if self.sizeChangeCallback and (oldWidth ~= self.width or oldHeight ~= self.height) then
        self.sizeChangeCallback(self, oldWidth, oldHeight, self.width, self.height)
    end
end

function VBox:onMousePressed(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMousePressed then
            child:onMousePressed(x, y, button)
        end
    end
end

function VBox:onMouseReleased(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMouseReleased then
            child:onMouseReleased(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function VBox:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)
    
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.updateMouseState then
            child:updateMouseState(mx, my)
        end
    end
end

return VBox
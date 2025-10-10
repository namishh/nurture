local BaseWidget = require("nurture.basewidget")

local VFracBox = setmetatable({}, { __index = BaseWidget })
VFracBox.__index = VFracBox

---@diagnostic disable-next-line: duplicate-set-field
function VFracBox:new(N, options)
    local self = setmetatable(BaseWidget:new("VFracBox"), VFracBox)
    self.nurture = N

    self.x = options.x or 0
    self.y = options.y or 0

    options = options or {}

    self._widgetCannotHaveChildren = false
    self.spacing = options.spacing or 0
    self.ratios = options.ratios or nil

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

function VFracBox:setSpacing(spacing)
    self.spacing = spacing
    self:updateSize()
end

function VFracBox:setRatios(ratios)
    self.ratios = ratios
    self:updateSize()
end

function VFracBox:setAddChildCallback(callback)
    self.addChildCallback = callback
end

function VFracBox:setRemoveChildCallback(callback)
    self.removeChildCallback = callback
end

function VFracBox:setSizeChangeCallback(callback)
    self.sizeChangeCallback = callback
end

function VFracBox:addChild(child)
    self:_addChildRelationship(child)
    self:updateSize()

    if self.addChildCallback then
        self.addChildCallback(self, child)
    end
end

function VFracBox:removeChild(child, deleteChild)
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

function VFracBox:clear(deleteChildren)
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
function VFracBox:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function VFracBox:update(dt)
    BaseWidget.update(self, dt)

    local children = self:getChildren()
    for _, child in ipairs(children) do
        if child and child.update then
            child:update(dt)
        end
    end
end

function VFracBox:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function VFracBox:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function VFracBox:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function VFracBox:onMousePressed(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMousePressed then
            child:onMousePressed(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function VFracBox:onMouseReleased(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMouseReleased then
            child:onMouseReleased(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function VFracBox:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)

    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.updateMouseState then
            child:updateMouseState(mx, my)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function VFracBox:draw()
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

    local children = self:getChildren()
    for _, child in ipairs(children) do
        if child and child.visible and child.draw then
            child:draw()
        end
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

function VFracBox:updateSize()
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

    if self.ratios then
        if #self.ratios ~= numChildren then
            if #self.ratios < numChildren then
                for i = #self.ratios + 1, numChildren do
                    self.ratios[i] = 1
                end
            elseif #self.ratios > numChildren then
                for i = numChildren + 1, #self.ratios do
                    self.ratios[i] = nil
                end
            end
        end
    end

    local widestChildWidth = 0
    for _, child in ipairs(children) do
        if child.width > widestChildWidth then
            widestChildWidth = child.width
        end
    end

    local sumChildrenHeight = 0
    for _, child in ipairs(children) do
        sumChildrenHeight = sumChildrenHeight + child.height
    end

    local totalSpacing = self.spacing * (numChildren - 1)
    local defaultHeight = sumChildrenHeight + totalSpacing

    self.width = math.max(self.forcedWidth or 0, widestChildWidth)
    self.height = self.forcedHeight or defaultHeight

    local targetWidth = self.forcedWidth or widestChildWidth

    local ratios = self.ratios or {}
    if not self.ratios then
        for i = 1, numChildren do
            ratios[i] = 1
        end
    end

    local totalRatio = 0
    for _, ratio in ipairs(ratios) do
        totalRatio = totalRatio + ratio
    end

    local availableHeight = self.height - totalSpacing

    local childY = self.y
    for i, child in ipairs(children) do
        local childHeight = (ratios[i] / totalRatio) * availableHeight

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
                childX = self.x + (self.width - childWidth) / 2
            elseif horizAlign == "right" then
                childX = self.x + self.width - childWidth
            end
        end
        if child.setForcedHeight then
            child:setForcedHeight(childHeight)
        end

        child.x = childX
        child.y = childY

        if child.updateSize then
            child:updateSize()
        end

        childY = childY + childHeight + self.spacing
    end

    if self.sizeChangeCallback and (oldWidth ~= self.width or oldHeight ~= self.height) then
        self.sizeChangeCallback(self, oldWidth, oldHeight, self.width, self.height)
    end
end

return VFracBox


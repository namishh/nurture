local BaseWidget = require("nurture.basewidget")

local HFracBox = setmetatable({}, { __index = BaseWidget })
HFracBox.__index = HFracBox

---@diagnostic disable-next-line: duplicate-set-field
function HFracBox:new(N, options)
    local self = setmetatable(BaseWidget:new("HFracBox"), HFracBox)
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

function HFracBox:setSpacing(spacing)
    self.spacing = spacing
    self:updateSize()
end

function HFracBox:setRatios(ratios)
    self.ratios = ratios
    self:updateSize()
end

function HFracBox:setAddChildCallback(callback)
    self.addChildCallback = callback
end

function HFracBox:setRemoveChildCallback(callback)
    self.removeChildCallback = callback
end

function HFracBox:setSizeChangeCallback(callback)
    self.sizeChangeCallback = callback
end

function HFracBox:addChild(child)
    self:_addChildRelationship(child)
    self:updateSize()

    if self.addChildCallback then
        self.addChildCallback(self, child)
    end
end

function HFracBox:removeChild(child, deleteChild)
    if deleteChild and child.delete then
        -- Delete handles removing from parent
        child:delete()
    else
        -- Only remove relationship if not deleting
        self:_removeChildRelationship(child)
    end
    
    self:updateSize()

    if self.removeChildCallback then
        self.removeChildCallback(self, child)
    end
end

function HFracBox:clear(deleteChildren)
    local children = self:getChildren()
    for _, child in ipairs(children) do
        if deleteChildren and child.delete then
            -- Delete handles removing from parent
            child:delete()
        else
            -- Only remove relationship if not deleting
            self:_removeChildRelationship(child)
        end
    end
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HFracBox:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HFracBox:update(dt)
    BaseWidget.update(self, dt)

    local children = self:getChildren()
    for _, child in ipairs(children) do
        if child and child.update then
            child:update(dt)
        end
    end
end

function HFracBox:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function HFracBox:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function HFracBox:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HFracBox:onMousePressed(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMousePressed then
            child:onMousePressed(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function HFracBox:onMouseReleased(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMouseReleased then
            child:onMouseReleased(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function HFracBox:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)

    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.updateMouseState then
            child:updateMouseState(mx, my)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function HFracBox:draw()
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

function HFracBox:updateSize()
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

    local tallestChildHeight = 0
    for _, child in ipairs(children) do
        if child.height > tallestChildHeight then
            tallestChildHeight = child.height
        end
    end

    local sumChildrenWidth = 0
    for _, child in ipairs(children) do
        sumChildrenWidth = sumChildrenWidth + child.width
    end

    local totalSpacing = self.spacing * (numChildren - 1)
    local defaultWidth = sumChildrenWidth + totalSpacing

    self.width = self.forcedWidth or defaultWidth
    self.height = math.max(self.forcedHeight or 0, tallestChildHeight)

    local targetHeight = self.forcedHeight or tallestChildHeight

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

    local availableWidth = self.width - totalSpacing

    local childX = self.x
    for i, child in ipairs(children) do
        local childWidth = (ratios[i] / totalRatio) * availableWidth

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
                childY = self.y + (self.height - childHeight) / 2
            elseif vertAlign == "bottom" then
                childY = self.y + self.height - childHeight
            end
        end
        if child.setForcedWidth then
            child:setForcedWidth(childWidth)
        end

        child.x = childX
        child.y = childY

        if child.updateSize then
            child:updateSize()
        end

        childX = childX + childWidth + self.spacing
    end

    if self.sizeChangeCallback and (oldWidth ~= self.width or oldHeight ~= self.height) then
        self.sizeChangeCallback(self, oldWidth, oldHeight, self.width, self.height)
    end
end

return HFracBox

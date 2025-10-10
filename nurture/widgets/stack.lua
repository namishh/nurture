local BaseWidget = require("nurture.basewidget")

local Stack = setmetatable({}, { __index = BaseWidget })
Stack.__index = Stack

---@diagnostic disable-next-line: duplicate-set-field
function Stack:new(N, options)
    local self = setmetatable(BaseWidget:new("Stack"), Stack)
    self.nurture = N

    options = options or {}
    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = false
    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.addChildCallback = options.addChildCallback or nil
    self.removeChildCallback = options.removeChildCallback or nil
    self.sizeChangeCallback = options.sizeChangeCallback or nil

    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    self.rotation = options.rotation or 0
    self.scaleX = options.scaleX or 1.0
    self.scaleY = options.scaleY or 1.0

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    local children = options.children or {}
    for _, child in ipairs(children) do
        self:_addChildRelationship(child)
    end

    self:updateSize()
    return self
end

function Stack:setAddChildCallback(callback)
    self.addChildCallback = callback
end

function Stack:setRemoveChildCallback(callback)
    self.removeChildCallback = callback
end

function Stack:setSizeChangeCallback(callback)
    self.sizeChangeCallback = callback
end

function Stack:addChild(child)
    self:_addChildRelationship(child)
    self:updateSize()

    if self.addChildCallback then
        self.addChildCallback(self, child)
    end
end

function Stack:removeChild(child, deleteChild)
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

function Stack:clear(deleteChildren)
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
function Stack:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Stack:update(dt)
    BaseWidget.update(self, dt)
    local children = self:getChildren()
    for _, child in ipairs(children) do
        if child and child.update then
            child:update(dt)
        end
    end
end

function Stack:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Stack:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Stack:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Stack:draw()
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
    for i = #children, 1, -1 do
        local child = children[i]
        if child and child.visible and child.draw then
            child:draw()
        end
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

function Stack:_computeContainerSize()
    local children = self:getChildren()
    local maxWidth = 0
    local maxHeight = 0

    for _, child in ipairs(children) do
        if child.width > maxWidth then
            maxWidth = child.width
        end
        if child.height > maxHeight then
            maxHeight = child.height
        end
    end

    local width = self.forcedWidth or maxWidth
    local height = self.forcedHeight or maxHeight
    return width, height
end

function Stack:updateSize()
    local woldWidth = self.width
    local woldHeight = self.height

    local width, height = self:_computeContainerSize()
    self.width = width
    self.height = height

    local children = self:getChildren()
    local targetWidth = self.width
    local targetHeight = self.height

    for _, child in ipairs(children) do
        local horiz = child.stackHorizAlign or "stretch"
        local vert = child.stackVertAlign or "stretch"

        if not child._originalForcedWidth and horiz ~= "stretch" then
            child._originalForcedWidth = child.forcedWidth
        end
        if not child._originalForcedHeight and vert ~= "stretch" then
            child._originalForcedHeight = child.forcedHeight
        end

        local childWidth = child.width
        local childHeight = child.height

        if horiz == "stretch" then
            if child.setForcedWidth then
                child:setForcedWidth(targetWidth)
            end
            childWidth = targetWidth
        else
            if child._originalForcedWidth ~= nil and child.setForcedWidth then
                if child.forcedWidth ~= child._originalForcedWidth then
                    child:setForcedWidth(child._originalForcedWidth)
                end
            end
        end

        if vert == "stretch" then
            if child.setForcedHeight then
                child:setForcedHeight(targetHeight)
            end
            childHeight = targetHeight
        else
            if child._originalForcedHeight ~= nil and child.setForcedHeight then
                if child.forcedHeight ~= child._originalForcedHeight then
                    child:setForcedHeight(child._originalForcedHeight)
                end
            end
        end

        local childX = self.x
        if horiz == "left" then
            childX = self.x
        elseif horiz == "center" then
            childX = self.x + (self.width - childWidth) / 2
        elseif horiz == "right" then
            childX = self.x + self.width - childWidth
        elseif horiz == "stretch" then
            childX = self.x
        else
            childX = self.x
        end

        local childY = self.y
        if vert == "top" then
            childY = self.y
        elseif vert == "center" then
            childY = self.y + (self.height - childHeight) / 2
        elseif vert == "bottom" then
            childY = self.y + self.height - childHeight
        elseif vert == "stretch" then
            childY = self.y
        else
            childY = self.y
        end

        child.x = childX
        child.y = childY

        if child.updateSize then
            child:updateSize()
        end
    end

    if self.sizeChangeCallback and (woldWidth ~= self.width or woldHeight ~= self.height) then
        self.sizeChangeCallback(self, woldWidth, woldHeight, self.width, self.height)
    end
end


---@diagnostic disable-next-line: duplicate-set-field
function Stack:onMousePressed(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMousePressed then
            child:onMousePressed(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Stack:onMouseReleased(x, y, button)
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.onMouseReleased then
            child:onMouseReleased(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Stack:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)

    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.enabled and child.updateMouseState then
            child:updateMouseState(mx, my)
        end
    end
end

local function _index_of(tbl, value)
    for i, v in ipairs(tbl) do
        if v == value then return i end
    end
    return nil
end

function Stack:bringToFront(widget)
    if not widget then return end
    local idx = _index_of(self.childrenUUIDs, widget.uuid)
    if not idx then return end
    table.remove(self.childrenUUIDs, idx)
    table.insert(self.childrenUUIDs, 1, widget.uuid)
end

function Stack:sendToBack(widget)
    if not widget then return end
    local idx = _index_of(self.childrenUUIDs, widget.uuid)
    if not idx then return end
    table.remove(self.childrenUUIDs, idx)
    table.insert(self.childrenUUIDs, widget.uuid)
end

function Stack:sendOneFront(widget)
    if not widget then return end
    local idx = _index_of(self.childrenUUIDs, widget.uuid)
    if not idx or idx == 1 then return end
    table.remove(self.childrenUUIDs, idx)
    table.insert(self.childrenUUIDs, idx - 1, widget.uuid)
end

function Stack:sendOneback(widget)
    if not widget then return end
    local idx = _index_of(self.childrenUUIDs, widget.uuid)
    if not idx or idx == #self.childrenUUIDs then return end
    table.remove(self.childrenUUIDs, idx)
    table.insert(self.childrenUUIDs, idx + 1, widget.uuid)
end

function Stack:bringToFrontByClassname(classname)
    if not classname then return end
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.classname == classname then
            self:bringToFront(child)
            return
        end
    end
end

function Stack:sendToBackByClassname(classname)
    if not classname then return end
    for _, childUUID in ipairs(self.childrenUUIDs) do
        local child = self.nurture:getFromUUID(childUUID)
        if child and child.classname == classname then
            self:sendToBack(child)
            return
        end
    end
end

return Stack

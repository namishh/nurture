local BaseWidget = {}

BaseWidget.__index = BaseWidget

local function generateUUID()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

function BaseWidget:new(type)
    local self = setmetatable({}, { __index = BaseWidget })
    self.uuid = generateUUID()
    self.x = 0
    self.type = type
    self.y = 0
    self.width = 0
    self.height = 0
    self.visible = true
    self.enabled = true
    self.opacity = 1
    self.zIndex = 1
    self.classname = nil
    self.parentUUID = nil
    self.childrenUUIDs = {}
    self._widgetCannotHaveChildren = false
    self.nurture = nil
    self.updateCallback = nil
    self.drawCallback = nil
    self.clickCallback = nil
    self.mouseOverCallback = nil
    self.mouseLeaveCallback = nil
    self._isMouseOver = false
    return self
end

function BaseWidget:setPosition(x, y)
    self.x = x
    self.y = y
end

function BaseWidget:isPointInside(px, py)
    return px >= self.x and px <= self.x + self.width and
        py >= self.y and py <= self.y + self.height
end

function BaseWidget:update(dt)
    if not self.enabled then
        return
    end
    
    if self.updateCallback then
        self.updateCallback(self, dt)
    end
end

function BaseWidget:draw()
    if not self.visible or not self.enabled then
        return
    end
    
    if self.drawCallback then
        self.drawCallback(self)
    end
end

function BaseWidget:add(child)
    if self._widgetCannotHaveChildren then
        error("BaseWidget:add() Type " .. type .. ": Widget cannot have children")
    end
    table.insert(self.children, child)
    child.parent = self
end

function BaseWidget:remove(child)
    if self._widgetCannotHaveChildren then
        error("BaseWidget:remove() Type " .. type .. ": Widget does have children")
    end
    for i, v in ipairs(self.children) do
        if v == child then
            table.remove(self.children, i)
            break
        end
    end
end

function BaseWidget:show()
    self.visible = true
end

function BaseWidget:hide()
    self.visible = false
end

function BaseWidget:enable()
    self.enabled = true
end

function BaseWidget:disable()
    self.enabled = false
end

function BaseWidget:setUpdateCallback(callback)
    self.updateCallback = callback
end

function BaseWidget:setZIndex(zIndex)
    self.zIndex = zIndex
end

function BaseWidget:getZIndex()
    return self.zIndex
end

function BaseWidget:setClassName(classname)
    if not self.nurture then
        error("BaseWidget:setClassName() Widget must have nurture reference")
    end

    if self.classname and self.nurture._widgetsByClassName[self.classname] then
        for i, widget in ipairs(self.nurture._widgetsByClassName[self.classname]) do
            if widget.uuid == self.uuid then
                table.remove(self.nurture._widgetsByClassName[self.classname], i)
                break
            end
        end
        if #self.nurture._widgetsByClassName[self.classname] == 0 then
            self.nurture._widgetsByClassName[self.classname] = nil
        end
    end

    self.classname = classname

    if classname then
        if not self.nurture._widgetsByClassName[classname] then
            self.nurture._widgetsByClassName[classname] = {}
        end
        table.insert(self.nurture._widgetsByClassName[classname], self)
    end
end

function BaseWidget:getClassName()
    return self.classname
end

function BaseWidget:setDrawCallback(callback)
    self.drawCallback = callback
end

function BaseWidget:setClickCallback(callback)
    self.clickCallback = callback
end

function BaseWidget:setMouseOverCallback(callback)
    self.mouseOverCallback = callback
end

function BaseWidget:setMouseLeaveCallback(callback)
    self.mouseLeaveCallback = callback
end

function BaseWidget:onClick(x, y, button)
    if not self.enabled then
        return
    end
    
    if self.clickCallback then
        self.clickCallback(self, x, y, button)
    end
end

function BaseWidget:onMouseOver(x, y)
    if not self.enabled then
        return
    end
    
    if self.mouseOverCallback then
        self.mouseOverCallback(self, x, y)
    end
end

function BaseWidget:onMouseLeave(x, y)
    if not self.enabled then
        return
    end
    
    if self.mouseLeaveCallback then
        self.mouseLeaveCallback(self, x, y)
    end
end

function BaseWidget:updateMouseState(mx, my)
    if not self.enabled then
        return
    end
    
    local wasOver = self._isMouseOver
    local isOver = self:isPointInside(mx, my)

    if isOver and not wasOver then
        self._isMouseOver = true
        self:onMouseOver(mx, my)
    elseif not isOver and wasOver then
        self._isMouseOver = false
        self:onMouseLeave(mx, my)
    end
end

function BaseWidget:getParent()
    if self.parentUUID and self.nurture then
        return self.nurture:getFromUUID(self.parentUUID)
    end
    return nil
end

function BaseWidget:getChildren()
    local children = {}
    if self.nurture then
        for _, childUUID in ipairs(self.childrenUUIDs) do
            local child = self.nurture:getFromUUID(childUUID)
            if child then
                table.insert(children, child)
            end
        end
    end
    return children
end

function BaseWidget:get_all_by_classname(classname)
    local result = {}
    local queue = {}

    if self.nurture then
        for _, childUUID in ipairs(self.childrenUUIDs) do
            local child = self.nurture:getFromUUID(childUUID)
            if child then
                table.insert(queue, child)
            end
        end
    end

    while #queue > 0 do
        local current = table.remove(queue, 1)

        if current.classname == classname then
            table.insert(result, current)
        end

        if current.nurture then
            for _, childUUID in ipairs(current.childrenUUIDs) do
                local child = current.nurture:getFromUUID(childUUID)
                if child then
                    table.insert(queue, child)
                end
            end
        end
    end

    return result
end

function BaseWidget:_addChildRelationship(child)
    if not self.nurture then
        error("BaseWidget:_addChildRelationship() Parent widget must have nurture reference")
    end

    child.nurture = self.nurture
    child.parentUUID = self.uuid
    table.insert(self.childrenUUIDs, child.uuid)

    if child.zIndex == 1 then
        child.zIndex = self.zIndex
    end

    for i, widget in ipairs(self.nurture._widgets) do
        if widget.uuid == child.uuid then
            table.remove(self.nurture._widgets, i)
            break
        end
    end

    self.nurture._widgetsByUUID[child.uuid] = child

    if child.classname then
        local alreadyRegistered = false
        if self.nurture._widgetsByClassName[child.classname] then
            for _, widget in ipairs(self.nurture._widgetsByClassName[child.classname]) do
                if widget.uuid == child.uuid then
                    alreadyRegistered = true
                    break
                end
            end
        end

        if not alreadyRegistered then
            if not self.nurture._widgetsByClassName[child.classname] then
                self.nurture._widgetsByClassName[child.classname] = {}
            end
            table.insert(self.nurture._widgetsByClassName[child.classname], child)
        end
    end
end

function BaseWidget:_removeChildRelationship(child)
    for i, uuid in ipairs(self.childrenUUIDs) do
        if uuid == child.uuid then
            table.remove(self.childrenUUIDs, i)
            child.parentUUID = nil
            break
        end
    end
end

return BaseWidget

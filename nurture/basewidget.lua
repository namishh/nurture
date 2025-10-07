local BaseWidget = {}

BaseWidget.__index = BaseWidget

function BaseWidget:new(type)
    local self = setmetatable({}, { __index = BaseWidget })
    self.x = 0
    self.type = type
    self.y = 0
    self.width = 0
    self.height = 0
    self.visible = true
    self.enabled = true
    self.opacity = 1
    self.zIndex = 1
    self.parent = nil
    self._widgetCannotHaveChildren = false
    self.children = {}
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
    if self.updateCallback then
        self.updateCallback(self, dt)
    end
end

function BaseWidget:draw()
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
    if self.clickCallback then
        self.clickCallback(self, x, y, button)
    end
end

function BaseWidget:onMouseOver(x, y)
    if self.mouseOverCallback then
        self.mouseOverCallback(self, x, y)
    end
end

function BaseWidget:onMouseLeave(x, y)
    if self.mouseLeaveCallback then
        self.mouseLeaveCallback(self, x, y)
    end
end

function BaseWidget:updateMouseState(mx, my)
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

return BaseWidget
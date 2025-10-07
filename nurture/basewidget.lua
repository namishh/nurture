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
    self.parent = nil
    self._widgetCannotHaveChildren = false
    self.children = {}
    self.updateCallback = nil
    self.drawCallback = nil
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

-- to be overridden
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

return BaseWidget
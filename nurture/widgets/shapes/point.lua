local BaseWidget = require("nurture.basewidget")

local Point = setmetatable({}, { __index = BaseWidget })
Point.__index = Point

---@diagnostic disable-next-line: duplicate-set-field
function Point:new(N, options)
    local self = setmetatable(BaseWidget:new("Point"), Point)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true

    self.size = options.size or 1
    self.color = options.color or { 1, 1, 1, 1 }
    self.shader = options.shader or nil

    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    self:updateSize()

    return self
end

function Point:setSize(size)
    self.size = size
    self:updateSize()
end

function Point:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

function Point:setShader(shader)
    self.shader = shader
end

---@diagnostic disable-next-line: duplicate-set-field
function Point:setPosition(x, y)
    self.x = x
    self.y = y
end

---@diagnostic disable-next-line: duplicate-set-field
function Point:draw()
    if not self.visible or not self.enabled then
        return
    end

    love.graphics.push()
    
    if self.shader then
        love.graphics.setShader(self.shader)
    end

    local oldColor = { love.graphics.getColor() }
    local oldPointSize = love.graphics.getPointSize()
    
    love.graphics.setColor(self.color)
    love.graphics.setPointSize(self.size)

    love.graphics.points(self.x, self.y)

    love.graphics.setColor(oldColor)
    love.graphics.setPointSize(oldPointSize)
    
    if self.shader then
        love.graphics.setShader()
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

function Point:updateSize()
    self.width = self.size
    self.height = self.size
end

return Point


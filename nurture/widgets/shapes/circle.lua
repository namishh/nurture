local BaseWidget = require("nurture.basewidget")

local Circle = setmetatable({}, { __index = BaseWidget })
Circle.__index = Circle

---@diagnostic disable-next-line: duplicate-set-field
function Circle:new(N, options)
    local self = setmetatable(BaseWidget:new("Circle"), Circle)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true

    self.radius = options.radius or 50
    self.segments = options.segments or nil
    self.mode = options.mode or "fill" -- "fill" or "line"
    self.lineWidth = options.lineWidth or 1
    
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

function Circle:setRadius(radius)
    self.radius = radius
    self:updateSize()
end

function Circle:setSegments(segments)
    self.segments = segments
end

function Circle:setMode(mode)
    self.mode = mode
end

function Circle:setLineWidth(lineWidth)
    self.lineWidth = lineWidth
end

function Circle:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

function Circle:setShader(shader)
    self.shader = shader
end

---@diagnostic disable-next-line: duplicate-set-field
function Circle:setPosition(x, y)
    self.x = x
    self.y = y
end

---@diagnostic disable-next-line: duplicate-set-field
function Circle:draw()
    if not self.visible or not self.enabled then
        return
    end

    love.graphics.push()
    
    if self.shader then
        love.graphics.setShader(self.shader)
    end

    local oldColor = { love.graphics.getColor() }
    local oldLineWidth = love.graphics.getLineWidth()
    
    love.graphics.setColor(self.color)
    
    if self.mode == "line" then
        love.graphics.setLineWidth(self.lineWidth)
    end

    if self.segments then
        love.graphics.circle(self.mode, self.x, self.y, self.radius, self.segments)
    else
        love.graphics.circle(self.mode, self.x, self.y, self.radius)
    end

    love.graphics.setColor(oldColor)
    love.graphics.setLineWidth(oldLineWidth)
    
    if self.shader then
        love.graphics.setShader()
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

function Circle:updateSize()
    self.width = self.radius * 2
    self.height = self.radius * 2
end

return Circle


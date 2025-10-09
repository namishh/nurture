local BaseWidget = require("nurture.basewidget")

local Line = setmetatable({}, { __index = BaseWidget })
Line.__index = Line

---@diagnostic disable-next-line: duplicate-set-field
function Line:new(N, options)
    local self = setmetatable(BaseWidget:new("Line"), Line)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true

    -- Points can be provided as a flat array: {x1, y1, x2, y2, ...}
    self.points = options.points or { 0, 0, 100, 100 }
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

function Line:setPoints(points)
    self.points = points
    self:updateSize()
end

function Line:setLineWidth(lineWidth)
    self.lineWidth = lineWidth
end

function Line:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

function Line:setShader(shader)
    self.shader = shader
end

---@diagnostic disable-next-line: duplicate-set-field
function Line:setPosition(x, y)
    local dx = x - self.x
    local dy = y - self.y
    
    -- Translate all points
    for i = 1, #self.points, 2 do
        self.points[i] = self.points[i] + dx
        self.points[i + 1] = self.points[i + 1] + dy
    end
    
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Line:draw()
    if not self.visible or not self.enabled then
        return
    end

    if #self.points < 4 then
        return -- Need at least 2 points (4 coordinates)
    end

    love.graphics.push()
    
    if self.shader then
        love.graphics.setShader(self.shader)
    end

    local oldColor = { love.graphics.getColor() }
    local oldLineWidth = love.graphics.getLineWidth()
    
    love.graphics.setColor(self.color)
    love.graphics.setLineWidth(self.lineWidth)

    love.graphics.line(self.points)

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

function Line:updateSize()
    if #self.points < 2 then
        self.width = 0
        self.height = 0
        self.x = 0
        self.y = 0
        return
    end

    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge

    for i = 1, #self.points, 2 do
        local px = self.points[i]
        local py = self.points[i + 1]
        minX = math.min(minX, px)
        minY = math.min(minY, py)
        maxX = math.max(maxX, px)
        maxY = math.max(maxY, py)
    end

    self.x = minX
    self.y = minY
    self.width = maxX - minX
    self.height = maxY - minY
end

return Line


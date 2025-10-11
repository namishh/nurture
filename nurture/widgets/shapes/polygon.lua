local BaseWidget = require("nurture.basewidget")

local Polygon = setmetatable({}, { __index = BaseWidget })
Polygon.__index = Polygon

---@diagnostic disable-next-line: duplicate-set-field
function Polygon:new(N, options)
    local self = setmetatable(BaseWidget:new("Polygon"), Polygon)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true


    self.horizAlign = options.horizAlign or nil -- "left", "center", "right"
    self.vertAlign = options.vertAlign or nil -- "top", "center", "bottom"
    self.stackHorizAlign = options.stackHorizAlign or nil -- "left", "center", "right"
    self.stackVertAlign = options.stackVertAlign or nil -- "top", "center", "bottom"

    self.vertices = options.vertices or { 0, 0, 100, 0, 50, 100 }
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

function Polygon:setVertices(vertices)
    self.vertices = vertices
    self:updateSize()
end

function Polygon:setMode(mode)
    self.mode = mode
end

function Polygon:setLineWidth(lineWidth)
    self.lineWidth = lineWidth
end

function Polygon:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

function Polygon:setShader(shader)
    self.shader = shader
end

---@diagnostic disable-next-line: duplicate-set-field
function Polygon:setPosition(x, y)
    local dx = x - self.x
    local dy = y - self.y
    
    for i = 1, #self.vertices, 2 do
        self.vertices[i] = self.vertices[i] + dx
        self.vertices[i + 1] = self.vertices[i + 1] + dy
    end
    
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Polygon:draw()
    if not self.visible or not self.enabled then
        return
    end

    if #self.vertices < 6 then
        return -- Need at least 3 vertices (6 coordinates) for a polygon
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

    love.graphics.polygon(self.mode, self.vertices)

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

function Polygon:updateSize()
    if #self.vertices < 2 then
        self.width = 0
        self.height = 0
        self.x = 0
        self.y = 0
        return
    end

    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge

    for i = 1, #self.vertices, 2 do
        local vx = self.vertices[i]
        local vy = self.vertices[i + 1]
        minX = math.min(minX, vx)
        minY = math.min(minY, vy)
        maxX = math.max(maxX, vx)
        maxY = math.max(maxY, vy)
    end

    self.x = minX
    self.y = minY
    self.width = maxX - minX
    self.height = maxY - minY
end

return Polygon


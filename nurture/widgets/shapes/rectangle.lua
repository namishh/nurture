local BaseWidget = require("nurture.basewidget")

local Rectangle = setmetatable({}, { __index = BaseWidget })
Rectangle.__index = Rectangle

---@diagnostic disable-next-line: duplicate-set-field
function Rectangle:new(N, options)
    local self = setmetatable(BaseWidget:new("Rectangle"), Rectangle)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true

    self.width = options.width or 100
    self.height = options.height or 100
    
    self.mode = options.mode or "fill" -- "fill" or "line"
    self.lineWidth = options.lineWidth or 1
    self.rx = options.rx or nil -- rounded corners x radius
    self.ry = options.ry or nil -- rounded corners y radius
    self.segments = options.segments or nil -- for rounded corners
    self.horizAlign = options.horizAlign or nil -- "left", "center", "right"
    self.vertAlign = options.vertAlign or nil -- "top", "center", "bottom"
    self.stackHorizAlign = options.stackHorizAlign or nil -- "left", "center", "right"
    self.stackVertAlign = options.stackVertAlign or nil -- "top", "center", "bottom"
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

    return self
end

function Rectangle:setSize(width, height)
    self.width = width
    self.height = height
end

function Rectangle:setMode(mode)
    self.mode = mode
end

function Rectangle:setLineWidth(lineWidth)
    self.lineWidth = lineWidth
end

function Rectangle:setRounding(rx, ry, segments)
    self.rx = rx
    self.ry = ry or rx
    self.segments = segments
end

function Rectangle:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

function Rectangle:setShader(shader)
    self.shader = shader
end

---@diagnostic disable-next-line: duplicate-set-field
function Rectangle:setPosition(x, y)
    self.x = x
    self.y = y
end

---@diagnostic disable-next-line: duplicate-set-field
function Rectangle:draw()
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

    if self.rx and self.ry then
        if self.segments then
            love.graphics.rectangle(self.mode, self.x, self.y, self.width, self.height, self.rx, self.ry, self.segments)
        else
            love.graphics.rectangle(self.mode, self.x, self.y, self.width, self.height, self.rx, self.ry)
        end
    else
        love.graphics.rectangle(self.mode, self.x, self.y, self.width, self.height)
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

return Rectangle


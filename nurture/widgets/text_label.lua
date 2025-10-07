local BaseWidget = require("nurture.basewidget")

local TextLabel = setmetatable({}, { __index = BaseWidget })
TextLabel.__index = TextLabel

---@diagnostic disable-next-line: duplicate-set-field
function TextLabel:new(N, text, fontName, color)
    local self = setmetatable(BaseWidget:new("TextLabel"), TextLabel)
    self.nurture = N
    self.text = text or ""
    self.fontName = fontName or N._defaultFont
    self.color = color or { 1, 1, 1, 1 }

    self:updateSize()

    N:addWidget(self)

    return self
end

function TextLabel:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

function TextLabel:updateSize()
    if self.fontName and self.nurture then
        local font = self.nurture:font(self.fontName)
        if font then
            self.width = font:getWidth(self.text)
            self.height = font:getHeight()
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function TextLabel:update(dt)
    -- Call parent update which will trigger the callback
    BaseWidget.update(self, dt)
end

---@diagnostic disable-next-line: duplicate-set-field
function TextLabel:draw()
    if not self.visible or not self.text or self.text == "" then
        return
    end

    if not self.fontName or not self.nurture then
        return
    end

    local hasCallback = self.drawCallback ~= nil
    if hasCallback then
        self.drawCallback(self)
    end

    local oldFont = love.graphics.getFont()
    local oldColor = { love.graphics.getColor() }

    local font = self.nurture:font(self.fontName)
    love.graphics.setFont(font)
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    love.graphics.print(self.text, self.x, self.y)

    love.graphics.setFont(oldFont)
    love.graphics.setColor(oldColor[1], oldColor[2], oldColor[3], oldColor[4])
    
    -- Pop graphics state if callback was called (assumes callback pushed)
    if hasCallback then
        love.graphics.pop()
    end
end

return TextLabel

local BaseWidget = require("nurture.basewidget")

local TextLabel = setmetatable({}, { __index = BaseWidget })
TextLabel.__index = TextLabel

---@diagnostic disable-next-line: duplicate-set-field
function TextLabel:new(N, text, fontName, options)
    local self = setmetatable(BaseWidget:new("TextLabel"), TextLabel)
    self.nurture = N
    self.text = text or ""
    self.fontName = fontName or N._defaultFont
    options = options or {}
    self.color = options.color or { 1, 1, 1, 1 }

    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    self.shadow = options.shadow or {}
    self.horizAlign = options.horizAlign
    self.vertAlign = options.vertAlign
    self.stackHorizAlign = options.stackHorizAlign
    self.stackVertAlign = options.stackVertAlign
    self.wrapping = options.wrapping or false
    self.wrapAlign = options.wrapAlign or "left" -- "left", "center", "right", "justify"
    self:updateSize()
    self._widgetCannotHaveChildren = true

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    return self
end

function TextLabel:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

function TextLabel:setShadowOffsets(x, y)
    self.shadow.x = x
    self.shadow.y = y
end

function TextLabel:setShadowColor(r, g, b, a)
    self.shadow.color = { r, g, b, a }
end

function TextLabel:updateSize()
    if self.fontName and self.nurture then
        local font = self.nurture:font(self.fontName)
        if font then
            if self.wrapping then
                local wrapWidth = self:getWrapWidth()
                if wrapWidth then
                    self.width = wrapWidth

                    local _, wrappedText = font:getWrap(self.text, wrapWidth)
                    self.height = font:getHeight() * #wrappedText
                else
                    self.width = font:getWidth(self.text)
                    self.height = font:getHeight()
                end
            else
                self.width = font:getWidth(self.text)
                self.height = font:getHeight()
            end
        end
    end
end

function TextLabel:getWrapWidth()
    -- Get parent width - wrapping only works with a parent
    local parent = self:getParent()
    if parent and parent.width and parent.width > 0 then
        -- Account for parent padding if it's a Box
        if parent.paddingLeft and parent.paddingRight then
            return parent.width - parent.paddingLeft - parent.paddingRight
        end
        return parent.width
    end

    -- No parent means no wrapping width available
    return nil
end

---@diagnostic disable-next-line: duplicate-set-field
function TextLabel:update(dt)
    -- Call parent update which will trigger the callback
    BaseWidget.update(self, dt)
end

---@diagnostic disable-next-line: duplicate-set-field
function TextLabel:draw()
    if not self.visible or not self.enabled or not self.text or self.text == "" then
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

    self.nurture:setFont(self.fontName)

    love.graphics.push()
    local centerX = self.x + self.width / 2
    local centerY = self.y + self.height / 2
    love.graphics.translate(centerX, centerY)
    love.graphics.rotate(self.rotation)
    love.graphics.scale(self.scaleX, self.scaleY)
    love.graphics.translate(-centerX, -centerY)

    if self.wrapping then
        local wrapWidth = self:getWrapWidth()
        if wrapWidth then
            if self.shadow then
                if (self.shadow.x ~= 0 or self.shadow.y ~= 0) and self.shadow.color then
                    love.graphics.setColor(self.shadow.color[1], self.shadow.color[2], self.shadow.color[3],
                        self.shadow.color[4])
                    love.graphics.printf(self.text, self.x + self.shadow.x, self.y + self.shadow.y, wrapWidth,
                        self.wrapAlign)
                end
            end

            love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
            love.graphics.printf(self.text, self.x, self.y, wrapWidth, self.wrapAlign)
        else
            if self.shadow then
                if (self.shadow.x ~= 0 or self.shadow.y ~= 0) and self.shadow.color then
                    love.graphics.setColor(self.shadow.color[1], self.shadow.color[2], self.shadow.color[3],
                        self.shadow.color[4])
                    love.graphics.print(self.text, self.x + self.shadow.x, self.y + self.shadow.y)
                end
            end

            love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
            love.graphics.print(self.text, self.x, self.y)
        end
    else
        if self.shadow then
            if (self.shadow.x ~= 0 or self.shadow.y ~= 0) and self.shadow.color then
                love.graphics.setColor(self.shadow.color[1], self.shadow.color[2], self.shadow.color[3],
                    self.shadow.color[4])
                love.graphics.print(self.text, self.x + self.shadow.x, self.y + self.shadow.y)
            end
        end

        love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
        love.graphics.print(self.text, self.x, self.y)
    end

    love.graphics.pop()

    love.graphics.setFont(oldFont)
    love.graphics.setColor(oldColor[1], oldColor[2], oldColor[3], oldColor[4])

    if hasCallback then
        love.graphics.pop()
    end
end

function TextLabel:setText(text)
    self.text = text
    self:updateSizeWithParents()
end

function TextLabel:setWrapping(enabled)
    self.wrapping = enabled
    self:updateSizeWithParents()
end

function TextLabel:setWrapAlign(align)
    self.wrapAlign = align
end

return TextLabel

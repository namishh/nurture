local BaseWidget = require("nurture.basewidget")
local utf8 = require("utf8")

local Input = setmetatable({}, { __index = BaseWidget })
Input.__index = Input


---@diagnostic disable-next-line: duplicate-set-field
function Input:new(N, options)
    local self = setmetatable(BaseWidget:new("Input"), Input)
    self.nurture = N
    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0
    self.width = options.width or 200
    self.height = options.height or 40

    self.paddingLeft = 0
    self.paddingRight = 0
    self.paddingTop = 0
    self.paddingBottom = 0

    if options.padding then
        if type(options.padding) == "number" then
            self.paddingLeft = options.padding
            self.paddingRight = options.padding
            self.paddingTop = options.padding
            self.paddingBottom = options.padding
        elseif type(options.padding) == "table" then
            self.paddingLeft = options.padding.left or 0
            self.paddingRight = options.padding.right or 0
            self.paddingTop = options.padding.top or 0
            self.paddingBottom = options.padding.bottom or 0
        end
    end

    self.text = options.text or ""
    self.cursorPosition = utf8.len(self.text) or 0
    self.textOffset = 0

    self.fontName = options.fontName or options.font or N._defaultFont

    self.textColor = options.textColor or { 1, 1, 1, 1 }
    self.backgroundColor = options.backgroundColor or { 0.2, 0.2, 0.2, 1 }
    self.borderColor = options.borderColor or { 0.5, 0.5, 0.5, 1 }
    self.focusedBorderColor = options.focusedBorderColor or { 0.3, 0.6, 0.9, 1 }
    self.cursorColor = options.cursorColor or { 1, 1, 1, 1 }

    self.borderWidth = options.borderWidth or 2

    self.rx = options.rx or options.rounding
    self.ry = options.ry or options.rounding
    self.segments = options.segments

    self.focused = false
    self._isPressed = false

    self.cursorBlinkTime = 0
    self.cursorBlinkInterval = 0.5
    self.cursorVisible = true

    self._userClickCallback = options.onClick or options.clickCallback
    self._userFocusCallback = options.onFocus or options.focusCallback
    self._userUnfocusCallback = options.onUnfocus or options.unfocusCallback or options.onDefocus or
        options.defocusCallback
    self._userKeypressCallback = options.onKeypress or options.keypressCallback
    self._userTextInputCallback = options.onTextInput or options.textInputCallback
    self._userTextChangedCallback = options.onTextChanged or options.textChangedCallback

    self.placeholder = options.placeholder or ""
    self.placeholderColor = options.placeholderColor or { 0.5, 0.5, 0.5, 1 }

    self.maxLength = options.maxLength

    self.horizAlign = options.horizAlign
    self.vertAlign = options.vertAlign
    self.stackHorizAlign = options.stackHorizAlign
    self.stackVertAlign = options.stackVertAlign

    if options.zIndex then self.zIndex = options.zIndex end
    if options.classname then self.classname = options.classname end

    self._widgetCannotHaveChildren = true

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self
    return self
end

function Input:setText(text)
    self.text = text or ""
    self.cursorPosition = utf8.len(self.text) or 0
    self:_updateTextOffset()

    if self._userTextChangedCallback then
        self._userTextChangedCallback(self, self.text)
    end
end

function Input:getText()
    return self.text
end

function Input:setFont(fontName)
    self.fontName = fontName
end

function Input:setPlaceholder(placeholder)
    self.placeholder = placeholder or ""
end

function Input:setMaxLength(maxLength)
    self.maxLength = maxLength
end

function Input:focus()
    if not self.focused then
        self.focused = true
        self.cursorBlinkTime = 0
        self.cursorVisible = true
        love.keyboard.setTextInput(true)
        love.keyboard.setKeyRepeat(true)

        if self._userFocusCallback then
            self._userFocusCallback(self)
        end
    end
end

function Input:unfocus()
    if self.focused then
        self.focused = false
        love.keyboard.setTextInput(false)
        love.keyboard.setKeyRepeat(false)

        if self._userUnfocusCallback then
            self._userUnfocusCallback(self)
        end
    end
end

function Input:isFocused()
    return self.focused
end

function Input:setTextColor(r, g, b, a)
    self.textColor = { r, g, b, a or 1 }
end

function Input:setBackgroundColor(r, g, b, a)
    self.backgroundColor = { r, g, b, a or 1 }
end

function Input:setBorderColor(r, g, b, a)
    self.borderColor = { r, g, b, a or 1 }
end

function Input:setFocusedBorderColor(r, g, b, a)
    self.focusedBorderColor = { r, g, b, a or 1 }
end

function Input:setCursorColor(r, g, b, a)
    self.cursorColor = { r, g, b, a or 1 }
end

function Input:setOnKeypress(callback)
    self._userKeypressCallback = callback
end

function Input:setOnTextInput(callback)
    self._userTextInputCallback = callback
end

function Input:setOnTextChanged(callback)
    self._userTextChangedCallback = callback
end

function Input:setOnFocus(callback)
    self._userFocusCallback = callback
end

function Input:setOnUnfocus(callback)
    self._userUnfocusCallback = callback
end

function Input:_getFont()
    if self.fontName and self.nurture then
        return self.nurture:font(self.fontName)
    end
    return love.graphics.getFont()
end

function Input:_updateTextOffset()
    local font = self:_getFont()
    local availableWidth = self.width - self.paddingLeft - self.paddingRight

    local textBeforeCursor = self:_getSubstring(1, self.cursorPosition)
    local cursorX = font:getWidth(textBeforeCursor)

    local fullTextWidth = font:getWidth(self.text)

    if cursorX - self.textOffset > availableWidth then
        self.textOffset = cursorX - availableWidth
    elseif cursorX - self.textOffset < 0 then
        self.textOffset = cursorX
    end

    if self.textOffset < 0 then
        self.textOffset = 0
    end

    if fullTextWidth - self.textOffset < availableWidth and fullTextWidth > availableWidth then
        self.textOffset = math.max(0, fullTextWidth - availableWidth)
    end
end

function Input:_getSubstring(startPos, endPos)
    if not self.text or self.text == "" then
        return ""
    end

    local byteStart = utf8.offset(self.text, startPos) or 1
    local byteEnd = utf8.offset(self.text, endPos + 1)

    if byteEnd then
        return string.sub(self.text, byteStart, byteEnd - 1)
    else
        return string.sub(self.text, byteStart)
    end
end

function Input:_insertText(text)
    if self.maxLength and utf8.len(self.text) >= self.maxLength then
        return
    end

    local before = self:_getSubstring(1, self.cursorPosition)
    local after = self:_getSubstring(self.cursorPosition + 1, utf8.len(self.text))

    self.text = before .. text .. after
    self.cursorPosition = self.cursorPosition + utf8.len(text)

    if self.maxLength and utf8.len(self.text) > self.maxLength then
        self.text = self:_getSubstring(1, self.maxLength)
        self.cursorPosition = math.min(self.cursorPosition, self.maxLength)
    end

    self:_updateTextOffset()

    if self._userTextChangedCallback then
        self._userTextChangedCallback(self, self.text)
    end
end

function Input:_deleteChar()
    if self.cursorPosition > 0 and utf8.len(self.text) > 0 then
        local before = self:_getSubstring(1, self.cursorPosition - 1)
        local after = self:_getSubstring(self.cursorPosition + 1, utf8.len(self.text))

        self.text = before .. after
        self.cursorPosition = self.cursorPosition - 1
        self:_updateTextOffset()

        if self._userTextChangedCallback then
            self._userTextChangedCallback(self, self.text)
        end
    end
end

function Input:_deleteCharForward()
    if self.cursorPosition < utf8.len(self.text) then
        local before = self:_getSubstring(1, self.cursorPosition)
        local after = self:_getSubstring(self.cursorPosition + 2, utf8.len(self.text))

        self.text = before .. after
        self:_updateTextOffset()

        if self._userTextChangedCallback then
            self._userTextChangedCallback(self, self.text)
        end
    end
end

function Input:_moveCursorLeft()
    if self.cursorPosition > 0 then
        self.cursorPosition = self.cursorPosition - 1
        self:_updateTextOffset()
        self.cursorBlinkTime = 0
        self.cursorVisible = true
    end
end

function Input:_moveCursorRight()
    if self.cursorPosition < utf8.len(self.text) then
        self.cursorPosition = self.cursorPosition + 1
        self:_updateTextOffset()
        self.cursorBlinkTime = 0
        self.cursorVisible = true
    end
end

function Input:_moveCursorToStart()
    self.cursorPosition = 0
    self:_updateTextOffset()
    self.cursorBlinkTime = 0
    self.cursorVisible = true
end

function Input:_moveCursorToEnd()
    self.cursorPosition = utf8.len(self.text)
    self:_updateTextOffset()
    self.cursorBlinkTime = 0
    self.cursorVisible = true
end

function Input:onTextInput(text)
    if not self.focused then
        return
    end
    
    if self._userTextInputCallback then
        self._userTextInputCallback(self, text)
    end
    
    self:_insertText(text)
end

function Input:onKeyPress(key, scancode, isrepeat)
    if not self.focused then
        return
    end
    
    if self._userKeypressCallback then
        self._userKeypressCallback(self, key, scancode, isrepeat)
    end
    
    if key == "escape" then
        self:unfocus()
    elseif key == "backspace" then
        self:_deleteChar()
    elseif key == "delete" then
        self:_deleteCharForward()
    elseif key == "left" then
        self:_moveCursorLeft()
    elseif key == "right" then
        self:_moveCursorRight()
    elseif key == "home" then
        self:_moveCursorToStart()
    elseif key == "end" then
        self:_moveCursorToEnd()
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Input:onClick(x, y, button)
    if not self.enabled then
        return
    end
    
    self:focus()
    
    local font = self:_getFont()
    local clickX = x - self.x - self.paddingLeft + self.textOffset

    local textLen = utf8.len(self.text)
    local closestPos = 0
    local closestDist = math.huge
    
    for i = 0, textLen do
        local substr = self:_getSubstring(1, i)
        local textWidth = font:getWidth(substr)
        local dist = math.abs(textWidth - clickX)
        
        if dist < closestDist then
            closestDist = dist
            closestPos = i
        end
    end
    
    self.cursorPosition = closestPos
    self:_updateTextOffset()
    self.cursorBlinkTime = 0
    self.cursorVisible = true
    
    if self._userClickCallback then
        self._userClickCallback(self, x, y, button)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Input:update(dt)
    BaseWidget.update(self, dt)
    
    if self.focused then
        self.cursorBlinkTime = self.cursorBlinkTime + dt
        if self.cursorBlinkTime >= self.cursorBlinkInterval then
            self.cursorBlinkTime = 0
            self.cursorVisible = not self.cursorVisible
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Input:onMousePressed(x, y, button)
    if not self.enabled then
        return
    end
    
    if not self:isPointInside(x, y) then
        self:unfocus()
    else
        self._isPressed = true
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Input:onMouseReleased(x, y, button)
    if not self.enabled then
        return
    end
    
    if self._isPressed and self:isPointInside(x, y) then
        self:onClick(x, y, button)
    end
    
    self._isPressed = false
end

---@diagnostic disable-next-line: duplicate-set-field
function Input:draw()
    if not self.visible or not self.enabled then
        return
    end
    local oldFont = love.graphics.getFont()
    local oldColor = { love.graphics.getColor() }
    
    love.graphics.setColor(self.backgroundColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.rx, self.ry, self.segments)
    
    local borderColor = self.focused and self.focusedBorderColor or self.borderColor
    love.graphics.setColor(borderColor)
    love.graphics.setLineWidth(self.borderWidth)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, self.rx, self.ry, self.segments)
    
    local font = self:_getFont()
    love.graphics.setFont(font)

    local textX = self.x + self.paddingLeft
    local textY = self.y + self.paddingTop
    local textWidth = self.width - self.paddingLeft - self.paddingRight
    local textHeight = self.height - self.paddingTop - self.paddingBottom
    
    love.graphics.setScissor(textX, textY, textWidth, textHeight)

    if self.text == "" and not self.focused then
        love.graphics.setColor(self.placeholderColor)
        local placeholderY = textY + (textHeight - font:getHeight()) / 2
        love.graphics.print(self.placeholder, textX, placeholderY)
    else
        love.graphics.setColor(self.textColor)
        local drawX = textX - self.textOffset
        local drawY = textY + (textHeight - font:getHeight()) / 2
        love.graphics.print(self.text, drawX, drawY)
        
        if self.focused and self.cursorVisible then
            local textBeforeCursor = self:_getSubstring(1, self.cursorPosition)
            local cursorX = drawX + font:getWidth(textBeforeCursor)
            
            love.graphics.setColor(self.cursorColor)
            love.graphics.setLineWidth(2)
            love.graphics.line(cursorX, drawY, cursorX, drawY + font:getHeight())
        end
    end

    love.graphics.setScissor()
    
    love.graphics.setFont(oldFont)
    love.graphics.setColor(oldColor)
    
    if self.drawCallback then
        self.drawCallback(self)
    end
end

return Input

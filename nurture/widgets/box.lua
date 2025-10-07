local BaseWidget = require("nurture.basewidget")

local Box = setmetatable({}, { __index = BaseWidget })
Box.__index = Box

---@diagnostic disable-next-line: duplicate-set-field
function Box:new(N, options)
    local self = setmetatable(BaseWidget:new("Box"), Box)
    self.nurture = N
    options = options or {}

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
        else
            error("Box:new(): Padding must be a number or a table")
        end
    end

    self.backgroundColor = options.backgroundColor or { 0.1, 0.1, 0.1, 0.8 }
    self._widgetCannotHaveChildren = false -- box can have 1 child
    self.child = options.child or nil

    self.valign = options.valign or "center"
    self.halign = options.halign or "center"
    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.vertAlign = options.vertAlign

    self:updateSize()
    N:addWidget(self)

    return self
end

function Box:setBackgroundColor(r, g, b, a)
    self.backgroundColor = { r, g, b, a or 1 }
end

function Box:setPadding(padding)
    if type(padding) == "number" then
        self.paddingLeft = padding
        self.paddingRight = padding
        self.paddingTop = padding
        self.paddingBottom = padding
    elseif type(padding) == "table" then
        self.paddingLeft = padding.left or 0
        self.paddingRight = padding.right or 0
        self.paddingTop = padding.top or 0
        self.paddingBottom = padding.bottom or 0
    else
        error("Box:setPadding(): Padding must be a number or a table")
    end
end

function Box:setChild(child)
    if self.child then
        for i, widget in ipairs(self.nurture._widgets) do
            if widget == self.child then
                table.remove(self.nurture._widgets, i)
                break
            end
        end
    end

    self.child = child
    child.parent = self

    for i, widget in ipairs(self.nurture._widgets) do
        if widget == child then
            table.remove(self.nurture._widgets, i)
            break
        end
    end

    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:update(dt)
    BaseWidget.update(self, dt)

    if self.child and self.child.update then
        self.child:update(dt)
    end
end

function Box:updateSize()
    if self.child then
        local contentWidth = self.child.width
        local contentHeight = self.child.height

        local minboxWidth = contentWidth + self.paddingLeft + self.paddingRight
        local minboxHeight = contentHeight + self.paddingTop + self.paddingBottom

        if self.forcedWidth then
            self.width = math.max(self.forcedWidth, minboxWidth)
        else
            self.width = minboxWidth
        end

        if self.forcedHeight then
            self.height = math.max(self.forcedHeight, minboxHeight)
        else
            self.height = minboxHeight
        end

        local availableWidth = self.width - self.paddingLeft - self.paddingRight
        local availableHeight = self.height - self.paddingTop - self.paddingBottom

        local childX = self.x + self.paddingLeft
        if self.halign == "center" then
            childX = self.x + self.paddingLeft + (availableWidth - contentWidth) / 2
        elseif self.halign == "right" then
            childX = self.x + self.width - self.paddingRight - contentWidth
        end

        local childY = self.y + self.paddingTop
        if self.valign == "center" then
            childY = self.y + self.paddingTop + (availableHeight - contentHeight) / 2
        elseif self.valign == "bottom" then
            childY = self.y + self.height - self.paddingBottom - contentHeight
        end

        self.child.x = childX
        self.child.y = childY
    else
        if self.forcedWidth then
            self.width = self.forcedWidth
        else
            self.width = self.paddingLeft + self.paddingRight
        end

        if self.forcedHeight then
            self.height = self.forcedHeight
        else
            self.height = self.paddingTop + self.paddingBottom
        end
    end
end

function Box:setAlignment(halign, valign)
    if halign then
        if halign ~= "center" and halign ~= "left" and halign ~= "right" then
            error("Box:setAlignment(): Invalid halign: " .. halign)
        end
        self.halign = halign
    end
    if valign then
        if valign ~= "center" and valign ~= "top" and valign ~= "bottom" then
            error("Box:setAlignment(): Invalid valign: " .. valign)
        end
        self.valign = valign
    end
end

function Box:setHAlign(halign)
    if halign ~= "center" and halign ~= "left" and halign ~= "right" then
        error("Box:setHAlign(): Invalid halign: " .. halign)
    end
    self.halign = halign
end

function Box:setVAlign(valign)
    if valign ~= "center" and valign ~= "top" and valign ~= "bottom" then
        error("Box:setVAlign(): Invalid valign: " .. valign)
    end
    self.valign = valign
end

---@diagnostic disable-next-line: duplicate-set-field
function Box:draw()
    if not self.visible then
        return
    end

    if self.backgroundColor[4] > 0 then
        local oldColor = { love.graphics.getColor() }
        love.graphics.setColor(
            self.backgroundColor[1],
            self.backgroundColor[2],
            self.backgroundColor[3],
            self.backgroundColor[4]
        )
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        love.graphics.setColor(oldColor[1], oldColor[2], oldColor[3], oldColor[4])
    end

    if self.child and self.child.visible and self.child.draw then
        self.child:draw()
    end

    if self.drawCallback then
        self.drawCallback(self)
    end
end

function Box:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Box:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Box:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

return Box

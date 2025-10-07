local BaseWidget = require("nurture.basewidget")

local HBox = setmetatable({}, { __index = BaseWidget })
HBox.__index = HBox

---@diagnostic disable-next-line: duplicate-set-field
function HBox:new(N, options)
    local self = setmetatable(BaseWidget:new("HBox"), HBox)
    self.nurture = N
    self.x = options.x or 0
    self.y = options.y or 0
    self.options = options or {}

    N:addWidget(self)

    self._widgetCannotHaveChildren = false
    self.children = options.children or {}
    self.spacing = options.spacing or 0
    self.justify = options.justify or "left"

    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight
    
    if options.zIndex then
        self.zIndex = options.zIndex
    end

    for _, child in ipairs(self.children) do
        child.parent = self
        for i, widget in ipairs(N._widgets) do
            if widget == child then
                table.remove(N._widgets, i)
                break
            end
        end
    end

    N:addWidget(self)
    self:updateSize()

    return self
end

function HBox:setSpacing(spacing)
    self.spacing = spacing
    self:updateSize()
end

function HBox:setJustify(justify)
    local validJustify = {
        left = true,
        right = true,
        center = true,
        ["space-evenly"] = true,
        ["space-between"] = true
    }
    if not validJustify[justify] then
        error("HBox:setJustify(): Invalid justify: " ..
        justify .. ". Must be one of: left, right, center, space-evenly, space-between")
    end
    self.justify = justify
    self:updateSize()
end

function HBox:addChild(child)
    table.insert(self.children, child)
    child.parent = self

    for i, widget in ipairs(self.nurture._widgets) do
        if widget == child then
            table.remove(self.nurture._widgets, i)
            break
        end
    end

    self:updateSize()
end

function HBox:removeChild(child)
    for i, v in ipairs(self.children) do
        if v == child then
            table.remove(self.children, i)
            break
        end
    end
    self:updateSize()
end

function HBox:clear()
    self.children = {}
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:update(dt)
    BaseWidget.update(self, dt)

    for _, child in ipairs(self.children) do
        if child and child.update then
            child:update(dt)
        end
    end
end

function HBox:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function HBox:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function HBox:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function HBox:draw()
    if not self.visible then
        return
    end

    for _, child in ipairs(self.children) do
        if child and child.visible and child.draw then
            child:draw()
        end
    end

    if self.drawCallback then
        self.drawCallback(self)
    end
end

function HBox:updateSize()
    if #self.children == 0 then
        self.width = self.forcedWidth or 0
        self.height = self.forcedHeight or 0
        return
    end

    local sumChildrenWidth = 0
    local tallestChildHeight = 0

    for _, child in ipairs(self.children) do
        sumChildrenWidth = sumChildrenWidth + child.width
        if child.height > tallestChildHeight then
            tallestChildHeight = child.height
        end
    end

    local totalSpacing = self.spacing * (#self.children - 1)
    local contentWidth = sumChildrenWidth + totalSpacing

    self.width = math.max(self.forcedWidth or 0, contentWidth)
    self.height = math.max(self.forcedHeight or 0, tallestChildHeight)

    local availableWidth = self.width
    local availableHeight = self.height

    local targetHeight = self.forcedHeight or tallestChildHeight

    local childX = self.x
    local startX = childX
    local gap = self.spacing

    if self.justify == "right" then
        local extraSpace = availableWidth - contentWidth
        startX = self.x + extraSpace
    elseif self.justify == "center" then
        local extraSpace = availableWidth - contentWidth
        startX = self.x + extraSpace / 2
    elseif self.justify == "space-evenly" then
        gap = (availableWidth - sumChildrenWidth) / (#self.children + 1)
        startX = self.x + gap
    elseif self.justify == "space-between" then
        if #self.children > 1 then
            gap = (availableWidth - sumChildrenWidth) / (#self.children - 1)
        end
        startX = self.x
    end

    childX = startX

    for _, child in ipairs(self.children) do
        local vertAlign = child.vertAlign or "stretch"

        local childY = self.y
        local childHeight = child.height

        if vertAlign == "stretch" then
            if child.setForcedHeight then
                child:setForcedHeight(targetHeight)
            end
            childHeight = targetHeight
            childY = self.y
        elseif vertAlign == "top" then
            childY = self.y
        elseif vertAlign == "center" then
            childY = self.y + (availableHeight - childHeight) / 2
        elseif vertAlign == "bottom" then
            childY = self.y + self.height - childHeight
        end

        child.x = childX
        child.y = childY

        childX = childX + child.width + gap
    end
end

return HBox

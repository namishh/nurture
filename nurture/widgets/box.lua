local BaseWidget = require("nurture.basewidget")

local Box = setmetatable({}, { __index = BaseWidget })
Box.__index = Box

---@diagnostic disable-next-line: duplicate-set-field
function Box:new(N, options)
    local self = setmetatable(BaseWidget:new("Box"), Box)
    self.nurture = N
    options = options or {}
    self.padding = 0
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
    N:addWidget(self)

    return self
end

function Box:setBackgroundColor(r,g,b,a)
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

        self.width = self.forcedWidth or (contentWidth + self.paddingLeft + self.paddingRight)
        self.height = self.forcedHeight or (contentHeight + self.paddingTop + self.paddingBottom)
        self.child.x = self.x + self.paddingLeft
        self.child.y = self.y + self.paddingTop
    else
        local width = self.forcedHeight or 0 
        self.width = width + self.paddingLeft + self.paddingRight

        local height = self.forcedHeight or 0
        self.height = height + self.paddingTop + self.paddingBottom
    end
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

return Box
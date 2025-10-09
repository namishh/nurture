local BaseWidget = require("nurture.basewidget")

local Grid = setmetatable({}, { __index = BaseWidget })
Grid.__index = Grid

---@diagnostic disable-next-line: duplicate-set-field
function Grid:new(N, options)
    local self = setmetatable(BaseWidget:new("Grid"), Grid)
    self.nurture = N
    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = false
    self.rows = options.rows or 1
    self.columns = options.columns or 1
    self.spacing = options.spacing or 0
    self.fillDirection = options.fillDirection or "row" -- "row" or "column"
    
    if self.fillDirection ~= "row" and self.fillDirection ~= "column" then
        error("Grid:new(): fillDirection must be 'row' or 'column'")
    end

    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight
    self.forcedCellWidth = options.forcedCellWidth
    self.forcedCellHeight = options.forcedCellHeight

    self.cells = {}
    for row = 1, self.rows do
        self.cells[row] = {}
        for col = 1, self.columns do
            self.cells[row][col] = nil
        end
    end

    self.addChildCallback = nil
    self.removeChildCallback = nil
    self.sizeChangeCallback = nil

    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    self.rotation = options.rotation or 0
    self.scaleX = options.scaleX or 1
    self.scaleY = options.scaleY or 1

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    local children = options.children or {}
    for _, child in ipairs(children) do
        self:_addChildInOrder(child)
    end

    self:updateSize()

    return self
end

function Grid:_addChildInOrder(child)
    if self.fillDirection == "row" then
        for row = 1, self.rows do
            for col = 1, self.columns do
                if not self.cells[row][col] then
                    self:setCell(row, col, child)
                    return true
                end
            end
        end
    else
        for col = 1, self.columns do
            for row = 1, self.rows do
                if not self.cells[row][col] then
                    self:setCell(row, col, child)
                    return true
                end
            end
        end
    end
    
    error("Grid:_addChildInOrder(): Grid is full, cannot add more children")
    return false
end

function Grid:setCell(row, column, child)
    if row < 1 or row > self.rows then
        error("Grid:setCell(): Row " .. row .. " is out of bounds (1-" .. self.rows .. ")")
    end
    if column < 1 or column > self.columns then
        error("Grid:setCell(): Column " .. column .. " is out of bounds (1-" .. self.columns .. ")")
    end

    local oldChild = self.cells[row][column]
    if oldChild then
        self:_removeChildRelationship(oldChild)
    end

    if child then
        self.cells[row][column] = child
        self:_addChildRelationship(child)
    else
        self.cells[row][column] = nil
    end

    self:updateSize()
end

function Grid:getCell(row, column)
    if row < 1 or row > self.rows then
        error("Grid:getCell(): Row " .. row .. " is out of bounds (1-" .. self.rows .. ")")
    end
    if column < 1 or column > self.columns then
        error("Grid:getCell(): Column " .. column .. " is out of bounds (1-" .. self.columns .. ")")
    end

    return self.cells[row][column]
end

function Grid:setSpacing(spacing)
    self.spacing = spacing
    self:updateSize()
end

function Grid:setFillDirection(fillDirection)
    if fillDirection ~= "row" and fillDirection ~= "column" then
        error("Grid:setFillDirection(): fillDirection must be 'row' or 'column'")
    end
    self.fillDirection = fillDirection
end

function Grid:setAddChildCallback(callback)
    self.addChildCallback = callback
end

function Grid:setRemoveChildCallback(callback)
    self.removeChildCallback = callback
end

function Grid:setSizeChangeCallback(callback)
    self.sizeChangeCallback = callback
end

function Grid:addChild(child)
    local success = self:_addChildInOrder(child)
    
    if success and self.addChildCallback then
        self.addChildCallback(self, child)
    end
end

function Grid:removeChild(child)
    for row = 1, self.rows do
        for col = 1, self.columns do
            if self.cells[row][col] == child then
                self.cells[row][col] = nil
                self:_removeChildRelationship(child)
                self:updateSize()
                
                if self.removeChildCallback then
                    self.removeChildCallback(self, child)
                end
                return
            end
        end
    end
end

function Grid:clear()
    for row = 1, self.rows do
        for col = 1, self.columns do
            local child = self.cells[row][col]
            if child then
                self:_removeChildRelationship(child)
                self.cells[row][col] = nil
            end
        end
    end
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Grid:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Grid:update(dt)
    BaseWidget.update(self, dt)

    for row = 1, self.rows do
        for col = 1, self.columns do
            local child = self.cells[row][col]
            if child and child.update then
                child:update(dt)
            end
        end
    end
end

function Grid:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Grid:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Grid:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

function Grid:setForcedCellWidth(width)
    self.forcedCellWidth = width
    self:updateSize()
end

function Grid:setForcedCellHeight(height)
    self.forcedCellHeight = height
    self:updateSize()
end

function Grid:setForcedCellSize(width, height)
    self.forcedCellWidth = width
    self.forcedCellHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Grid:draw()
    if not self.visible or not self.enabled then
        return
    end

    love.graphics.push()
    local centerX = self.x + self.width / 2
    local centerY = self.y + self.height / 2
    love.graphics.translate(centerX, centerY)
    love.graphics.rotate(self.rotation)
    love.graphics.scale(self.scaleX, self.scaleY)
    love.graphics.translate(-centerX, -centerY)

    for row = 1, self.rows do
        for col = 1, self.columns do
            local child = self.cells[row][col]
            if child and child.visible and child.draw then
                child:draw()
            end
        end
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

function Grid:updateSize()
    local oldWidth = self.width
    local oldHeight = self.height

    local columnWidths = {}
    local rowHeights = {}

    for col = 1, self.columns do
        columnWidths[col] = self.forcedCellWidth or 0
    end

    for row = 1, self.rows do
        rowHeights[row] = self.forcedCellHeight or 0
    end

    if not self.forcedCellWidth then
        for row = 1, self.rows do
            for col = 1, self.columns do
                local child = self.cells[row][col]
                if child then
                    if child.width > columnWidths[col] then
                        columnWidths[col] = child.width
                    end
                end
            end
        end
    end

    if not self.forcedCellHeight then
        for row = 1, self.rows do
            for col = 1, self.columns do
                local child = self.cells[row][col]
                if child then
                    if child.height > rowHeights[row] then
                        rowHeights[row] = child.height
                    end
                end
            end
        end
    end

    local totalWidth = 0
    for col = 1, self.columns do
        totalWidth = totalWidth + columnWidths[col]
    end
    totalWidth = totalWidth + (self.columns - 1) * self.spacing

    local totalHeight = 0
    for row = 1, self.rows do
        totalHeight = totalHeight + rowHeights[row]
    end
    totalHeight = totalHeight + (self.rows - 1) * self.spacing

    self.width = self.forcedWidth or totalWidth
    self.height = self.forcedHeight or totalHeight

    if self.forcedWidth then
        local availableWidth = self.forcedWidth - (self.columns - 1) * self.spacing
        local cellWidth = availableWidth / self.columns
        for col = 1, self.columns do
            columnWidths[col] = cellWidth
        end
    end

    if self.forcedHeight then
        local availableHeight = self.forcedHeight - (self.rows - 1) * self.spacing
        local cellHeight = availableHeight / self.rows
        for row = 1, self.rows do
            rowHeights[row] = cellHeight
        end
    end

    local currentY = self.y
    for row = 1, self.rows do
        local currentX = self.x
        for col = 1, self.columns do
            local child = self.cells[row][col]
            if child then
                local cellWidth = columnWidths[col]
                local cellHeight = rowHeights[row]

                local childX = currentX + (cellWidth - child.width) / 2
                local childY = currentY + (cellHeight - child.height) / 2

                child.x = childX
                child.y = childY

                if child.updateSize then
                    child:updateSize()
                end
            end
            currentX = currentX + columnWidths[col] + self.spacing
        end
        currentY = currentY + rowHeights[row] + self.spacing
    end

    if self.sizeChangeCallback and (oldWidth ~= self.width or oldHeight ~= self.height) then
        self.sizeChangeCallback(self, oldWidth, oldHeight, self.width, self.height)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Grid:onMousePressed(x, y, button)
    for row = 1, self.rows do
        for col = 1, self.columns do
            local child = self.cells[row][col]
            if child and child.enabled and child.onMousePressed then
                child:onMousePressed(x, y, button)
            end
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Grid:onMouseReleased(x, y, button)
    for row = 1, self.rows do
        for col = 1, self.columns do
            local child = self.cells[row][col]
            if child and child.enabled and child.onMouseReleased then
                child:onMouseReleased(x, y, button)
            end
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Grid:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)
    
    for row = 1, self.rows do
        for col = 1, self.columns do
            local child = self.cells[row][col]
            if child and child.enabled and child.updateMouseState then
                child:updateMouseState(mx, my)
            end
        end
    end
end

return Grid

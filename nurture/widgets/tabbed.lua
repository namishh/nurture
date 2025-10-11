local BaseWidget = require("nurture.basewidget")

local Tabbed = setmetatable({}, { __index = BaseWidget })
Tabbed.__index = Tabbed

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:new(N, options)
    local self = setmetatable(BaseWidget:new("Tabbed"), Tabbed)
    self.nurture = N
    self.options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = false
    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.tabs = options.tabs or {}
    self.tablist = options.tabOrder or {} -- list of tab names in order

    self.activeTab = nil

    self.switchCallback = options.switchCallback or nil

    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    self.rotation = options.rotation or 0
    self.scaleX = options.scaleX or 1.0
    self.scaleY = options.scaleY or 1.0

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    if #self.tablist == 0 then
        for name, tab in pairs(self.tabs) do
            table.insert(self.tablist, name)
        end
        table.sort(self.tablist)
    end

    for _, name in ipairs(self.tablist) do
        local tab = self.tabs[name]
        if not tab then
            error("Tabbed:new(): Tab '" .. name .. "' in tabOrder not found in tabs")
        end
        if tab.type ~= "Box" then
            error("Tabbed:new(): All children must be Box widgets")
        end
        self:_addChildRelationship(tab)
        tab.visible = false
    end

    if #self.tablist > 0 and not options.activeTab then
        self.activeTab = self.tablist[1]
        if self.tabs[self.activeTab] then
            self.tabs[self.activeTab].visible = true
        end
    elseif options.activeTab then
        self.activeTab = options.activeTab
        if self.tabs[self.activeTab] then
            self.tabs[self.activeTab].visible = true
        else
            error("Tabbed:new(): activeTab '" .. options.activeTab .. "' not found in boxes")
        end
    end

    self:updateSize()
    return self
end

function Tabbed:setSwitchCallback(callback)
    self.switchCallback = callback
end

function Tabbed:switch(name)
    if not self.tabs[name] then
        error("Tabbed:switch(): Tab '" .. name .. "' not found")
    end

    if self.activeTab and self.tabs[self.activeTab] then
        self.tabs[self.activeTab].visible = false
    end


    self.activeTab = name
    self.tabs[name].visible = true

    self:updateSize()
    if self.switchCallback then
        self.switchCallback(name)
    end
end

function Tabbed:getActiveTabName()
    return self.activeTab
end

function Tabbed:getActiveTab()
    if self.activeTab then
        return self.tabs[self.activeTab]
    end
    return nil
end

function Tabbed:addTab(name, box)

    if self.tabs[name] then
        error("Tabbed:addTab(): Tab '" .. name .. "' already exists")
    end

    if box.type ~= "Box" then
        error("Tabbed:addTab(): All children must be Box widgets")
    end

    self.tabs[name] = box
    self:_addChildRelationship(box)
    table.insert(self.tablist, name)

    box.visible = false

    if not self.activeTab then
        self.activeTab = name
        box.visible = true
    end

    self:updateSize()
end

function Tabbed:removeTab(name, deleteTab)
    if not self.tabs[name] then
        error("Tabbed:removeTab(): Tab '" .. name .. "' not found")
    end

    local box = self.tabs[name]

    for i, tab in ipairs(self.tablist) do
        if tab == name then
            table.remove(self.tablist, i)
            break
        end
    end
   
    if self.activeTab == name then
        if #self.tablist > 0 then
            self:switch(self.tablist[1])
        else
            self.activeTab = nil
        end
    end

    if deleteTab and box.delete then
        box:delete()
    else 
        self:_removeChildRelationship(box)
    end

    self.tabs[name] = nil
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:update(dt)
    BaseWidget.update(self, dt)
    
    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        if activeBox.update then
            activeBox:update(dt)
        end
    end
end

function Tabbed:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Tabbed:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Tabbed:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:draw()
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

    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        if activeBox.visible and activeBox.draw then
            activeBox:draw()
        end
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end


---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:onMousePressed(x, y, button)
    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        if activeBox.enabled and activeBox.onMousePressed then
            activeBox:onMousePressed(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:onMouseReleased(x, y, button)
    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        if activeBox.enabled and activeBox.onMouseReleased then
            activeBox:onMouseReleased(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:onDrag(x, y, dx, dy)
    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        if activeBox.enabled and activeBox.onDrag then
            activeBox:onDrag(x, y, dx, dy)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:onDragEnd(x, y, button)
    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        if activeBox.enabled and activeBox.onDragEnd then
            activeBox:onDragEnd(x, y, button)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Tabbed:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)
    
    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        if activeBox.enabled and activeBox.updateMouseState then
            activeBox:updateMouseState(mx, my)
        end
    end
end

function Tabbed:updateSize()
    if self.activeTab and self.tabs[self.activeTab] then
        local activeBox = self.tabs[self.activeTab]
        activeBox.x = self.x
        activeBox.y = self.y

        if self.forcedWidth and activeBox.setForcedWidth then
            activeBox:setForcedWidth(self.forcedWidth)
        end
        
        if self.forcedHeight and activeBox.setForcedHeight then
            activeBox:setForcedHeight(self.forcedHeight)
        end
        
        if activeBox.updateSize then
            activeBox:updateSize()
        end

        self.width = self.forcedWidth or activeBox.width
        self.height = self.forcedHeight or activeBox.height
    else
        self.width = self.forcedWidth or 0
        self.height = self.forcedHeight or 0
    end
end

return Tabbed
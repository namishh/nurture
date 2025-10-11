local nurture = {
    _VERSION = "0.0.1",
    _DESCRIPTION = "Tasty and Easy UI Library",

    _fonts = {},
    _defaultFont = nil,
    _widgets = {},
    _widgetsByUUID = {},
    _widgetsByClassName = {},
    _shaders = {},

    _draggedWidget = nil,
    _isDragging = false
}

function nurture:new()
    local self = setmetatable({}, { __index = nurture })
    self._fonts = {}
    self._defaultFont = nil
    self._widgets = {}
    self._widgetsByUUID = {}
    self._widgetsByClassName = {}
    self._shaders = {}
    self._draggedWidget = nil
    self._isDragging = false
    return self
end

function nurture:registerFont(path, name, size, default)
    local info = love.filesystem.getInfo(path)
    if not path or not info or info.type ~= "file" then
        error("nurture:registerFont(): Font file not found: " .. path)
    end

    if type(size) ~= "number" then
        error("nurture:registerFont(): Size must be a number")
    end

    if type(name) ~= "string" then
        error("nurture:registerFont(): Name must be a string")
    end

    if self._fonts[name] then
        print("nurture:registerFont(): Font " .. name .. " will be overwrriten")
    end

    local font = love.graphics.newFont(path, size)

    self._fonts[name] = {
        size = size,
        path = path,
        font = font
    }

    if default then
        if self._defaultFont ~= nil then
            error("nurture:registerFont(): Default font already set")
        end
        self._defaultFont = name
    end


    return font
end

function nurture:font(name)
    if not self._fonts[name] then
        error("nurture:font(): Font " .. name .. " not found")
    end

    return self._fonts[name].font
end

function nurture:setFont(name)
    local font = self:font(name)
    love.graphics.setFont(font)
    return font
end

function nurture:removeFont(name)
    if nurture._fonts[name] then
        nurture._fonts[name] = nil

        if nurture._default_font == name then
            nurture._default_font = next(nurture._fonts)
        end

        return true
    else
        error("nurture:removeFont(): Font " .. name .. " not found")
    end
end

function nurture:loadShader(shaderPath)
    if type(shaderPath) ~= "string" then
        error("nurture:loadShader(): shaderPath must be a string")
    end

    if self._shaders[shaderPath] then
        return self._shaders[shaderPath]
    end

    local success, shader = pcall(love.graphics.newShader, shaderPath)
    if not success then
        error("nurture:loadShader(): Failed to load shader: " .. shaderPath .. " - " .. tostring(shader))
    end

    self._shaders[shaderPath] = shader
    return shader
end

function nurture:clearShaderCache()
    self._shaders = {}
end

function nurture:addWidget(widget)
    if not widget then
        error("nurture:addWidget(): Widget cannot be nil")
    end

    table.insert(self._widgets, widget)
    self._widgetsByUUID[widget.uuid] = widget

    if widget.classname then
        if not self._widgetsByClassName[widget.classname] then
            self._widgetsByClassName[widget.classname] = {}
        end
        table.insert(self._widgetsByClassName[widget.classname], widget)
    end

    return widget
end

function nurture:removeWidget(widget)
    for i, w in ipairs(self._widgets) do
        if w == widget then
            table.remove(self._widgets, i)
            self._widgetsByUUID[widget.uuid] = nil

            if widget.classname and self._widgetsByClassName[widget.classname] then
                for j, classWidget in ipairs(self._widgetsByClassName[widget.classname]) do
                    if classWidget.uuid == widget.uuid then
                        table.remove(self._widgetsByClassName[widget.classname], j)
                        break
                    end
                end
                if #self._widgetsByClassName[widget.classname] == 0 then
                    self._widgetsByClassName[widget.classname] = nil
                end
            end

            return true
        end
    end
    return false
end

function nurture:clearWidgets()
    self._widgets = {}
    self._widgetsByUUID = {}
    self._widgetsByClassName = {}
end

function nurture:getWidgets()
    return self._widgets
end

function nurture:getFromUUID(uuid)
    return self._widgetsByUUID[uuid]
end

function nurture:get_all_by_classname(classname)
    if self._widgetsByClassName[classname] then
        local result = {}
        for _, widget in ipairs(self._widgetsByClassName[classname]) do
            table.insert(result, widget)
        end
        return result
    else
        return {}
    end
end

function nurture:update(dt)
    local mx, my = love.mouse.getPosition()
    for _, widget in ipairs(self._widgets) do
        if widget.enabled and widget.updateMouseState then
            widget:updateMouseState(mx, my)
        end
    end

    for _, widget in ipairs(self._widgets) do
        if widget.enabled and widget.update then
            widget:update(dt)
        end
    end
end

function nurture:draw()
    local sortedWidgets = {}
    for _, widget in ipairs(self._widgets) do
        table.insert(sortedWidgets, widget)
    end

    table.sort(sortedWidgets, function(a, b)
        return (a.zIndex or 1) < (b.zIndex or 1)
    end)

    for _, widget in ipairs(sortedWidgets) do
        if widget.visible and widget.enabled and widget.draw then
            widget:draw()
        end
    end
end

function nurture:mousepressed(x, y, button)
    local function findDraggableWidget(widget, x, y)
        if not widget.enabled or not widget.visible then
            return nil
        end

        if widget.type == "Tabbed" and widget.activeTab and widget.tabs then
            local activeTab = widget.tabs[widget.activeTab]
            if activeTab then
                local draggable = findDraggableWidget(activeTab, x, y)
                if draggable then
                    return draggable
                end
            end
        end

        if widget.childrenUUIDs then
            for _, childUUID in ipairs(widget.childrenUUIDs) do
                local child = self._widgetsByUUID[childUUID]
                if child then
                    local draggable = findDraggableWidget(child, x, y)
                    if draggable then
                        return draggable
                    end
                end
            end
        end

        if widget.childUUID then
            local child = self._widgetsByUUID[widget.childUUID]
            if child then
                local draggable = findDraggableWidget(child, x, y)
                if draggable then
                    return draggable
                end
            end
        end

        if widget._canBeDragged and widget:isPointInside(x, y) then
            return widget
        end

        return nil
    end

    for _, widget in ipairs(self._widgets) do
        if widget.enabled and widget:isPointInside(x, y) then
            if widget.onMousePressed then
                widget:onMousePressed(x, y, button)
            end

            local draggableWidget = findDraggableWidget(widget, x, y)
            if draggableWidget then
                self._draggedWidget = draggableWidget
                self._isDragging = true
            end
        end
    end
end

function nurture:mousereleased(x, y, button)
    if self._isDragging and self._draggedWidget then
        ---@diagnostic disable-next-line: undefined-field
        if self._draggedWidget.onDragEnd then
            ---@diagnostic disable-next-line: undefined-field
            self._draggedWidget:onDragEnd(x, y, button)
        end
        self._isDragging = false
        self._draggedWidget = nil
    end
    for _, widget in ipairs(self._widgets) do
        if widget.enabled then
            if widget.onMouseReleased then
                widget:onMouseReleased(x, y, button)
            end
        end
    end
end

function nurture:mousemoved(x, y, dx, dy)
    if self._isDragging and self._draggedWidget then
        ---@diagnostic disable-next-line: undefined-field
        if self._draggedWidget.onDrag then
            ---@diagnostic disable-next-line: undefined-field
            self._draggedWidget:onDrag(x, y, dx, dy)
        end
    end

    for _, widget in ipairs(self._widgets) do
        if widget.enabled and widget.onMouseMoved then
            widget:onMouseMoved(x, y, dx, dy)
        end
    end
end

function nurture:keypressed(key, scancode, isrepeat)
    local function dispatchToWidget(widget)
        if widget.enabled and widget.onKeyPress then
            widget:onKeyPress(key, scancode, isrepeat)
        end
        for _, childUUID in ipairs(widget.childrenUUIDs or {}) do
            local child = self._widgetsByUUID[childUUID]
            if child then
                dispatchToWidget(child)
            end
        end
    end
    for _, widget in ipairs(self._widgets) do
        dispatchToWidget(widget)
    end
end

function nurture:textinput(text)
    local function dispatchToWidget(widget)
        if widget.enabled and widget.onTextInput then
            widget:onTextInput(text)
        end
        for _, childUUID in ipairs(widget.childrenUUIDs or {}) do
            local child = self._widgetsByUUID[childUUID]
            if child then
                dispatchToWidget(child)
            end
        end
    end
    for _, widget in ipairs(self._widgets) do
        dispatchToWidget(widget)
    end
end

nurture.BaseWidget = require("nurture.basewidget")

nurture.Box = require("nurture.widgets.box")
nurture.HBox = require("nurture.widgets.hbox")
nurture.VBox = require("nurture.widgets.vbox")
nurture.HFracBox = require("nurture.widgets.hfracbox")
nurture.VFracBox = require("nurture.widgets.vfracbox")
nurture.Grid = require("nurture.widgets.grid")
nurture.Stack = require("nurture.widgets.stack")
nurture.Tabbed = require("nurture.widgets.tabbed")

nurture.Image = require("nurture.widgets.image")
nurture.Video = require("nurture.widgets.video")
nurture.TextLabel = require("nurture.widgets.text_label")
nurture.Button = require("nurture.widgets.button")
nurture.Progress = require("nurture.widgets.progress")
nurture.Slider = require("nurture.widgets.slider")
nurture.Input = require("nurture.widgets.input")

nurture.Shape = {
    Circle = require("nurture.widgets.shapes.circle"),
    Rectangle = require("nurture.widgets.shapes.rectangle"),
    Line = require("nurture.widgets.shapes.line"),
    Point = require("nurture.widgets.shapes.point"),
    Polygon = require("nurture.widgets.shapes.polygon")
}

return nurture

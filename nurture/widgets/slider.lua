local BaseWidget = require("nurture.basewidget")

local Slider = setmetatable({}, { __index = BaseWidget })
Slider.__index = Slider

---@diagnostic disable-next-line: duplicate-set-field
function Slider:new(N, options)
    local self = setmetatable(BaseWidget:new("Slider"), Slider)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true
    self.knobUUID = nil

    self.orientation = options.orientation or "horizontal"
    if self.orientation == "horizontal" then
        self.width = options.width or 200
        self.height = options.height or 20
    else
        self.width = options.width or 20
        self.height = options.height or 200
    end

    self.minValue = options.minValue or 0
    self.maxValue = options.maxValue or 1

    self.stepSize = options.stepSize or 0.01

    -- Initialize value to 0 temporarily, will be set properly below
    self.value = self.minValue

    self.trackColor = options.trackColor or { 0.3, 0.3, 0.3, 1.0 }
    self.trackRounding = options.trackRounding or nil

    self.fillColor = options.fillColor or { 0.2, 0.5, 0.8, 1.0 }
    self.fillType = options.fillType or
    "left"                                     -- "left", "right", "center", "none" for horizontal; "top", "bottom", "center", "none" for vertical

    self._canBeDragged = true
    self._isDraggingKnob = false

    self._userOnValueChange = options.onValueChange

    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    local knobToSet = nil
    if options.knob then
        knobToSet = options.knob
    elseif options.child then
        knobToSet = options.child
    elseif options.children and #options.children > 0 then
        knobToSet = options.children[1]
    end

    if knobToSet then
        self:_addChildRelationship(knobToSet)
        self.knobUUID = knobToSet.uuid
    end

    self:setValue(options.value or self.minValue)

    return self
end

function Slider:setValue(value)
    local oldValue = self.value
    self.value = math.max(self.minValue, math.min(self.maxValue, value))
    
    -- Snap to step size
    if self.stepSize and self.stepSize > 0 then
        local steps = math.floor((self.value - self.minValue) / self.stepSize + 0.5)
        self.value = self.minValue + (steps * self.stepSize)
        -- Ensure we don't exceed bounds after snapping
        self.value = math.max(self.minValue, math.min(self.maxValue, self.value))
    end
    
    self:updateKnobPosition()
    
    if oldValue ~= self.value and self._userOnValueChange then
        self._userOnValueChange(self, self.value)
    end
end

function Slider:getValue(value)
    return self.value
end

function Slider:setValueRange(minValue, maxValue)
    self.minValue = minValue
    self.maxValue = maxValue
    self:setValue(self.value)
end

function Slider:setOnValueChange(callback)
    self._userOnValueChange = callback
end

function Slider:setKnob(knob)
    if self.knobUUID then
        local oldKnob = self.nurture:getFromUUID(self.knobUUID)
        if oldKnob then
            self:_removeChildRelationship(oldKnob)
        end
    end
    self:_addChildRelationship(knob)
    self.knobUUID = knob.uuid
    self:updateKnobPosition()
end

function Slider:setTrackColor(r, g, b, a)
    self.trackColor = { r, g, b, a or 1 }
end

function Slider:setFillColor(r, g, b, a)
    self.fillColor = { r, g, b, a or 1 }
end

function Slider:setFillType(fillType)
    self.fillType = fillType
end

function Slider:setOrientation(orientation)
    self.orientation = orientation
    self:updateKnobPosition()
end

---@diagnostic disable-next-line: duplicate-set-field
function Slider:setPosition(x, y)
    self.x = x
    self.y = y
    self:updateKnobPosition()
end

function Slider:updateKnobPosition()
    local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
    if not knob then 
        return
    end

    local normalizedValue = (self.value - self.minValue) / (self.maxValue - self.minValue)
    
    -- Check if knob is a circle (has radius property and draws from center)
    local isCircle = knob.radius ~= nil
    
    if self.orientation == "horizontal" then
        local knobWidth = knob.width or 0
        local trackLength = self.width - knobWidth
        local knobX = self.x + (trackLength * normalizedValue)
        local knobY = self.y + self.height / 2
        
        -- For non-circle knobs (rectangles, etc.), offset by half height
        if not isCircle then
            knobX = knobX
            knobY = knobY - (knob.height or 0) / 2
        end

        knob.x = knobX + (isCircle and knobWidth / 2 or 0)
        knob.y = knobY 
    else
        local knobHeight = knob.height or 0
        local trackLength = self.height - knobHeight
        local knobY = self.y + (trackLength * normalizedValue)
        local knobX = self.x + self.width / 2
        
        -- For non-circle knobs (rectangles, etc.), offset by half width
        if not isCircle then
            knobY = knobY
            knobX = knobX - (knob.width or 0) / 2
        end

        knob.x = knobX
        knob.y = knobY + (isCircle and knobHeight / 2 or 0)
    end

    if knob.updateSize then
        knob:updateSize()
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Slider:updateSize()
    self:updateKnobPosition()
end

function Slider:onMousePressed(x, y, button)
    if not self:isPointInside(x, y) then
        return
    end
    
    local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)

    if knob and knob:isPointInside(x, y) then
        self._isDraggingKnob = true
        if knob.onMousePressed then
            knob:onMousePressed(x, y, button)
        end
    else
        self:updateValueFromPosition(x, y)
        self._isDraggingKnob = true
    end
end

function Slider:onMouseReleased(x, y, button)
    self._isDraggingKnob = false

    local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
    if knob and knob.onMouseReleased then
        knob:onMouseReleased(x, y, button)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Slider:onDrag(x, y, dx, dy)
    if self._isDraggingKnob then
        self:updateValueFromPosition(x, y)
    end
end


---@diagnostic disable-next-line: duplicate-set-field
function Slider:onDragEnd(x, y, button)
    self._isDraggingKnob = false
end

function Slider:updateValueFromPosition(x, y)
    local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
    local knobSize = 0

    if self.orientation == "horizontal" then
        if knob then
            knobSize = knob.width or 0
        end
        local trackLength = self.width - knobSize
        local relativeX = x - self.x - knobSize / 2
        local normalizedValue = relativeX / trackLength
        normalizedValue = math.max(0, math.min(1, normalizedValue))

        local newValue = self.minValue + normalizedValue * (self.maxValue - self.minValue)
        self:setValue(newValue)
    else
        if knob then
            knobSize = knob.height or 0
        end
        local trackLength = self.height - knobSize
        local relativeY = y - self.y - knobSize / 2
        local normalizedValue = relativeY / trackLength
        normalizedValue = math.max(0, math.min(1, normalizedValue))

        local newValue = self.minValue + normalizedValue * (self.maxValue - self.minValue)
        self:setValue(newValue)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Slider:update(dt)
    BaseWidget.update(self, dt)

    local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
    if knob and knob.update then
        knob:update(dt)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Slider:updateMouseState(mx, my)
    BaseWidget.updateMouseState(self, mx, my)

    local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
    if knob and knob.enabled and knob.updateMouseState then
        knob:updateMouseState(mx, my)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Slider:draw()
    if not self.visible or not self.enabled then
        return
    end

    love.graphics.push()

    if self.trackColor[4] > 0 then
        local oldColor = { love.graphics.getColor() }
        love.graphics.setColor(self.trackColor)

        if self.trackRounding then
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.trackRounding,
                self.trackRounding)
        else
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end

        love.graphics.setColor(oldColor)
    end

    if self.fillColor[4] > 0 and self.fillType ~= "none" then
        local oldColor = { love.graphics.getColor() }
        love.graphics.setColor(self.fillColor)

        local normalizedValue = (self.value - self.minValue) / (self.maxValue - self.minValue)

        if self.orientation == "horizontal" then
            local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
            local knobWidth = knob and knob.width or 0
            local fillWidth = 0
            local fillX = self.x

            if self.fillType == "left" then
                fillWidth = (self.width - knobWidth) * normalizedValue + knobWidth / 2
            elseif self.fillType == "right" then
                fillWidth = (self.width - knobWidth) * (1 - normalizedValue) + knobWidth / 2
                fillX = self.x + self.width - fillWidth
            elseif self.fillType == "center" then
                local centerX = self.x + self.width / 2
                if normalizedValue >= 0.5 then
                    fillX = centerX
                    fillWidth = (normalizedValue - 0.5) * (self.width - knobWidth) * 2
                else
                    fillWidth = (0.5 - normalizedValue) * (self.width - knobWidth) * 2
                    fillX = centerX - fillWidth
                end
            end

            if self.trackRounding then
                love.graphics.rectangle("fill", fillX, self.y, fillWidth, self.height, self.trackRounding,
                    self.trackRounding)
            else
                love.graphics.rectangle("fill", fillX, self.y, fillWidth, self.height)
            end
        else
            local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
            local knobHeight = knob and knob.height or 0
            local fillHeight = 0
            local fillY = self.y

            if self.fillType == "top" then
                fillHeight = (self.height - knobHeight) * normalizedValue + knobHeight / 2
            elseif self.fillType == "bottom" then
                fillHeight = (self.height - knobHeight) * (1 - normalizedValue) + knobHeight / 2
                fillY = self.y + self.height - fillHeight
            elseif self.fillType == "center" then
                local centerY = self.y + self.height / 2
                if normalizedValue >= 0.5 then
                    fillY = centerY
                    fillHeight = (normalizedValue - 0.5) * (self.height - knobHeight) * 2
                else
                    fillHeight = (0.5 - normalizedValue) * (self.height - knobHeight) * 2
                    fillY = centerY - fillHeight
                end
            end

            if self.trackRounding then
                love.graphics.rectangle("fill", self.x, fillY, self.width, fillHeight, self.trackRounding,
                    self.trackRounding)
            else
                love.graphics.rectangle("fill", self.x, fillY, self.width, fillHeight)
            end
        end

        love.graphics.setColor(oldColor)
    end
    local knob = self.knobUUID and self.nurture:getFromUUID(self.knobUUID)
    if knob and knob.visible and knob.draw then
        knob:draw()
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

return Slider

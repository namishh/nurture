local BaseWidget = require("nurture.basewidget")

local Progress = setmetatable({}, { __index = BaseWidget })
Progress.__index = Progress

---@diagnostic disable-next-line: duplicate-set-field
function Progress:new(N, options)
    local self = setmetatable(BaseWidget:new("Progress"), Progress)
    options = options or {}

    self.nurture = N

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true


    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.value = options.value or 0
    self.maxValue = options.maxValue or 100
    
    self.orientation = options.orientation or "horizontal"
    self.fill = options.fill or "start" 

    self.text = {}
    local textoptions = options.text or {}
    self.text.visible = textoptions.visible 
    self.text.label = textoptions.label or nil
    self.text.fontName = textoptions.fontName or N._defaultFont
    self.text.color = textoptions.color or { 1, 1, 1, 1 }
    self.text.size = textoptions.size or 14
    self.text.horizAlign = textoptions.horizAlign or "center"
    self.text.vertAlign = textoptions.vertAlign or "center"
    self.text.shadow = {}
    if textoptions and textoptions.shadow then
        self.text.shadow.x = textoptions.shadow.x or 0
        self.text.shadow.y = textoptions.shadow.y or 0
        self.text.shadow.color = textoptions.shadow.color or { 0, 0, 0, 1 }
    else
        self.text.shadow.x = 0
        self.text.shadow.y = 0
        self.text.shadow.color = { 0, 0, 0, 1 }
    end

    self.color = {}
    local color = options.color or {}
    self.color.backgroundColor = color.background or {}
    self.color.progressColor = color.color or {}
    self.color.shadowColor = color.shadow or {}

    self.scaleX = options.scaleX or 1
    self.scaleY = options.scaleY or 1
    self.rotation = options.rotation or 0


    if options.zIndex then
        self.zIndex = options.zIndex
    end

    if options.classname then
        self.classname = options.classname
    end

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    self:updateSize()

    return self
end


---@diagnostic disable-next-line: duplicate-set-field
function Progress:setScale(scaleX, scaleY)
    self.scaleX = scaleX
    self.scaleY = scaleY or scaleX
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Progress:setRotation(rotation)
    self.rotation = rotation
end


---@diagnostic disable-next-line: duplicate-set-field
function Progress:setPosition(x, y)
    self.x = x
    self.y = y
end

function Progress:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Progress:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Progress:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

function Progress:setValue(value)
    self.value = value
end

function Progress:setMaxValue(maxValue)
    self.maxValue = maxValue
end

function Progress:setColor(color)
    self.color = color
end

function Progress:setBackgroundColor(backgroundColor)
    self.color.backgroundColor = backgroundColor
end

function Progress:updateSize()
    if self.orientation == "vertical" then
        if not self.forcedWidth then
            self.width = 20
        else
            self.width = self.forcedWidth
        end
        
        if not self.forcedHeight then
            self.height = 200
        else
            self.height = self.forcedHeight
        end
    else
        if not self.forcedWidth then
            self.width = 200
        else
            self.width = self.forcedWidth
        end
        
        if not self.forcedHeight then
            self.height = 20
        else
            self.height = self.forcedHeight
        end
    end
end


---@diagnostic disable-next-line: duplicate-set-field
function Progress:draw()
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

    -- Draw shadow if present
    if self.color.shadowColor and #self.color.shadowColor >= 3 then
        local shadowAlpha = self.color.shadowColor[4] or 1
        if shadowAlpha > 0 then
            love.graphics.setColor(self.color.shadowColor[1], self.color.shadowColor[2], 
                                 self.color.shadowColor[3], shadowAlpha)
            love.graphics.rectangle("fill", self.x + 2, self.y + 2, self.width, self.height, 3)
        end
    end

    -- Draw background
    if self.color.backgroundColor and #self.color.backgroundColor >= 3 then
        local bgAlpha = self.color.backgroundColor[4] or 1
        love.graphics.setColor(self.color.backgroundColor[1], self.color.backgroundColor[2], 
                             self.color.backgroundColor[3], bgAlpha)
    else
        love.graphics.setColor(0.2, 0.2, 0.2, 0.8)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 3)

    local progress = math.max(0, math.min(self.value, self.maxValue)) / self.maxValue
    
    if progress > 0 then
        if self.color.progressColor and #self.color.progressColor >= 3 then
            local progAlpha = self.color.progressColor[4] or 1
            love.graphics.setColor(self.color.progressColor[1], self.color.progressColor[2], 
                                 self.color.progressColor[3], progAlpha)
        else
            love.graphics.setColor(0.2, 0.7, 0.3, 1.0)
        end
        
        local progressX, progressY, progressWidth, progressHeight
        
        if self.orientation == "vertical" then
            progressWidth = self.width
            progressHeight = self.height * progress
            progressX = self.x
            
            if self.fill == "start" then
                progressY = self.y
            else 
                progressY = self.y + self.height - progressHeight
            end
        else
            progressHeight = self.height
            progressWidth = self.width * progress
            progressY = self.y
            
            if self.fill == "start" then
                progressX = self.x
            else 
                progressX = self.x + self.width - progressWidth
            end
        end
        
        love.graphics.rectangle("fill", progressX, progressY, progressWidth, progressHeight, 3)
    end

    if self.text.visible then
        local oldFont = love.graphics.getFont()
        
        if self.text.fontName and self.nurture then
            self.nurture:setFont(self.text.fontName)
        end

        local progressText = self.text.label or math.floor(progress * 100)

        if self.text.shadow and (self.text.shadow.x ~= 0 or self.text.shadow.y ~= 0) then
            if self.text.shadow.color and #self.text.shadow.color >= 3 then
                local shadowAlpha = self.text.shadow.color[4] or 1
                love.graphics.setColor(self.text.shadow.color[1], self.text.shadow.color[2], 
                                     self.text.shadow.color[3], shadowAlpha)
                local textX = self.x + self.text.shadow.x
                local textY = self.y + self.text.shadow.y
                
                if self.text.horizAlign == "center" then
                    textX = textX + self.width / 2 - love.graphics.getFont():getWidth(progressText) / 2
                elseif self.text.horizAlign == "right" then
                    textX = textX + self.width - love.graphics.getFont():getWidth(progressText)
                end
                
                if self.text.vertAlign == "center" then
                    textY = textY + self.height / 2 - love.graphics.getFont():getHeight() / 2
                elseif self.text.vertAlign == "bottom" then
                    textY = textY + self.height - love.graphics.getFont():getHeight()
                end
                
                love.graphics.print(progressText, textX, textY)
            end
        end

        love.graphics.setColor(self.text.color[1], self.text.color[2], 
                             self.text.color[3], self.text.color[4] or 1)
        
        local textX = self.x
        local textY = self.y
        
        if self.text.horizAlign == "center" then
            textX = textX + self.width / 2 - love.graphics.getFont():getWidth(progressText) / 2
        elseif self.text.horizAlign == "right" then
            textX = textX + self.width - love.graphics.getFont():getWidth(progressText)
        end
        
        if self.text.vertAlign == "center" then
            textY = textY + self.height / 2 - love.graphics.getFont():getHeight() / 2
        elseif self.text.vertAlign == "bottom" then
            textY = textY + self.height - love.graphics.getFont():getHeight()
        end
        
        love.graphics.print(progressText, textX, textY)
        
        love.graphics.setFont(oldFont)
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

---@diagnostic disable-next-line: duplicate-set-field
function Progress:update(dt)
    BaseWidget.update(self, dt)
end

function Progress:setOrientation(orientation)
    if orientation ~= "horizontal" and orientation ~= "vertical" then
        error("Progress:setOrientation(): orientation must be 'horizontal' or 'vertical'")
    end
    self.orientation = orientation
    self:updateSize()
end

function Progress:setFill(fill)
    if fill ~= "start" and fill ~= "end" then
        error("Progress:setFill(): fill must be 'start' or 'end'")
    end
    self.fill = fill
end

return Progress
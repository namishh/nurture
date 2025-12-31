local BaseWidget = require("nurture.basewidget")

local Image = setmetatable({}, { __index = BaseWidget })
Image.__index = Image

---@diagnostic disable-next-line: duplicate-set-field
function Image:new(N, imagePath, options)
    local self = setmetatable(BaseWidget:new("Image"), Image)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true

    if type(imagePath) == "string" then
        local info = love.filesystem.getInfo(imagePath)
        if not info or info.type ~= "file" then
            error("Image:new(): Image file not found: " .. imagePath)
        end
        self.image = love.graphics.newImage(imagePath)
        self._ownsImage = true
    elseif type(imagePath) == "userdata" then
        -- Already a Love2D image object
        self.image = imagePath
        self._ownsImage = false
    else
        error("Image:new(): imagePath must be a string path or Love2D Image object")
    end

    self.forcedWidth = options.forcedWidth
    self.forcedHeight = options.forcedHeight

    self.scaleX = options.scaleX or 1
    self.scaleY = options.scaleY or 1
    self.rotation = options.rotation or 0

    self.shader = options.shader or nil
    self.color = options.color or { 1, 1, 1, 1 }

    self.originX = options.originX or 0
    self.originY = options.originY or 0

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

function Image:setImage(imagePath)
    if self.image and self._ownsImage then
        self.image:release()
    end
    
    if type(imagePath) == "string" then
        local info = love.filesystem.getInfo(imagePath)
        if not info or info.type ~= "file" then
            error("Image:setImage(): Image file not found: " .. imagePath)
        end
        self.image = love.graphics.newImage(imagePath)
        self._ownsImage = true
    elseif type(imagePath) == "userdata" then
        self.image = imagePath
        self._ownsImage = false
    else
        error("Image:setImage(): imagePath must be a string path or Love2D Image object")
    end
    self:updateSize()
end

function Image:setShader(shader)
    self.shader = shader
end

function Image:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

---@diagnostic disable-next-line: duplicate-set-field
function Image:setScale(scaleX, scaleY)
    self.scaleX = scaleX
    self.scaleY = scaleY or scaleX
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Image:setRotation(rotation)
    self.rotation = rotation
end

function Image:setOrigin(originX, originY)
    self.originX = originX
    self.originY = originY
end

---@diagnostic disable-next-line: duplicate-set-field
function Image:setPosition(x, y)
    self.x = x
    self.y = y
end

function Image:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Image:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Image:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Image:draw()
    if not self.visible or not self.enabled or not self.image then
        return
    end

    love.graphics.push()

    if self.shader then
        love.graphics.setShader(self.shader)
    end

    local oldColor = { love.graphics.getColor() }
    love.graphics.setColor(self.color)

    local imgWidth = self.image:getWidth()
    local imgHeight = self.image:getHeight()

    local drawScaleX = self.scaleX
    local drawScaleY = self.scaleY

    if self.forcedWidth then
        drawScaleX = self.forcedWidth / imgWidth
    end

    if self.forcedHeight then
        drawScaleY = self.forcedHeight / imgHeight
    end

    love.graphics.draw(
        self.image,
        self.x,
        self.y,
        self.rotation,
        drawScaleX,
        drawScaleY,
        self.originX,
        self.originY
    )

    love.graphics.setColor(oldColor)

    if self.shader then
        love.graphics.setShader()
    end

    if self.drawCallback then
        self.drawCallback(self)
    end

    love.graphics.pop()
end

function Image:updateSize()
    if not self.image then
        self.width = 0
        self.height = 0
        return
    end

    local imgWidth = self.image:getWidth()
    local imgHeight = self.image:getHeight()

    if self.forcedWidth and self.forcedHeight then
        self.width = self.forcedWidth
        self.height = self.forcedHeight
    elseif self.forcedWidth then
        self.width = self.forcedWidth
        self.height = imgHeight * (self.forcedWidth / imgWidth) * self.scaleY
    elseif self.forcedHeight then
        self.height = self.forcedHeight
        self.width = imgWidth * (self.forcedHeight / imgHeight) * self.scaleX
    else
        self.width = imgWidth * self.scaleX
        self.height = imgHeight * self.scaleY
    end
end

return Image

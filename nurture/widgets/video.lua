local BaseWidget = require("nurture.basewidget")

local Video = setmetatable({}, { __index = BaseWidget })
Video.__index = Video

---@diagnostic disable-next-line: duplicate-set-field
function Video:new(N, videoPath, options)
    local self = setmetatable(BaseWidget:new("Video"), Video)
    self.nurture = N

    options = options or {}

    self.x = options.x or 0
    self.y = options.y or 0

    self._widgetCannotHaveChildren = true

    if type(videoPath) == "string" then
        local info = love.filesystem.getInfo(videoPath)
        if not info or info.type ~= "file" then
            error("Video:new(): Video file not found: " .. videoPath)
        end
        self.video = love.graphics.newVideo(videoPath)
    elseif type(videoPath) == "userdata" then
        -- Already a Love2D video object
        self.video = videoPath
    else
        error("Video:new(): videoPath must be a string path or Love2D Video object")
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

    if options.autoplay then
        self.video:play()
    end

    N:addWidget(self)
    N._widgetsByUUID[self.uuid] = self

    self:updateSize()

    return self
end

function Video:play()
    if self.video then
        self.video:play()
    end
end

function Video:pause()
    if self.video then
        self.video:pause()
    end
end

function Video:rewind()
    if self.video then
        self.video:rewind()
    end
end

function Video:seek(offset)
    if self.video then
        self.video:seek(offset)
    end
end

function Video:isPlaying()
    return self.video and self.video:isPlaying()
end

function Video:setVideo(videoPath)
    if type(videoPath) == "string" then
        local info = love.filesystem.getInfo(videoPath)
        if not info or info.type ~= "file" then
            error("Video:setVideo(): Video file not found: " .. videoPath)
        end
        self.video = love.graphics.newVideo(videoPath)
    elseif type(videoPath) == "userdata" then
        self.video = videoPath
    else
        error("Video:setVideo(): videoPath must be a string path or Love2D Video object")
    end
    self:updateSize()
end

function Video:setShader(shader)
    self.shader = shader
end

function Video:setColor(r, g, b, a)
    self.color = { r, g, b, a or 1 }
end

---@diagnostic disable-next-line: duplicate-set-field
function Video:setScale(scaleX, scaleY)
    self.scaleX = scaleX
    self.scaleY = scaleY or scaleX
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Video:setRotation(rotation)
    self.rotation = rotation
end

function Video:setOrigin(originX, originY)
    self.originX = originX
    self.originY = originY
end

---@diagnostic disable-next-line: duplicate-set-field
function Video:setPosition(x, y)
    self.x = x
    self.y = y
end

function Video:setForcedWidth(width)
    self.forcedWidth = width
    self:updateSize()
end

function Video:setForcedHeight(height)
    self.forcedHeight = height
    self:updateSize()
end

function Video:setForcedSize(width, height)
    self.forcedWidth = width
    self.forcedHeight = height
    self:updateSize()
end

---@diagnostic disable-next-line: duplicate-set-field
function Video:draw()
    if not self.visible or not self.enabled or not self.video then
        return
    end

    love.graphics.push()

    if self.shader then
        love.graphics.setShader(self.shader)
    end

    local oldColor = { love.graphics.getColor() }
    love.graphics.setColor(self.color)

    local vidWidth = self.video:getWidth()
    local vidHeight = self.video:getHeight()

    local drawScaleX = self.scaleX
    local drawScaleY = self.scaleY

    if self.forcedWidth then
        drawScaleX = self.forcedWidth / vidWidth
    end

    if self.forcedHeight then
        drawScaleY = self.forcedHeight / vidHeight
    end

    love.graphics.draw(
        self.video,
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

function Video:updateSize()
    if not self.video then
        self.width = 0
        self.height = 0
        return
    end

    local vidWidth = self.video:getWidth()
    local vidHeight = self.video:getHeight()

    if self.forcedWidth and self.forcedHeight then
        self.width = self.forcedWidth
        self.height = self.forcedHeight
    elseif self.forcedWidth then
        self.width = self.forcedWidth
        self.height = vidHeight * (self.forcedWidth / vidWidth) * self.scaleY
    elseif self.forcedHeight then
        self.height = self.forcedHeight
        self.width = vidWidth * (self.forcedHeight / vidHeight) * self.scaleX
    else
        self.width = vidWidth * self.scaleX
        self.height = vidHeight * self.scaleY
    end
end

return Video

local nurture = {
    _VERSION = "0.0.1",
    _DESCRIPTION = "Tasty and Easy UI Library",

    _fonts = {},
    _defaultFont = nil
}

function nurture:new()
    local self = setmetatable({}, { __index = nurture })
    self._fonts = {}
    self._defaultFont = nil
    return self
end

function nurture:registerFont(path, name, size, default)

    if not path or not love.filesystem.isFile(path) then
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

return nurture
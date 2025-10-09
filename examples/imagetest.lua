local function load(nurture, N)
    local image1 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 20,
        y = 20,
        scaleX = 0.5,
        scaleY = 0.5,
        classname = "image-basic"
    })

    local image2 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 250,
        y = 20,
        scaleX = 0.5,
        scaleY = 0.5,
        classname = "image-scaled"
    })

    local image3 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 480,
        y = 20,
        forcedWidth = 100,
        forcedHeight = 100,
        classname = "image-forced-size"
    })

    -- Example 4: Rotated image
    local image4 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 650,
        y = 20,
        scaleX = 0.5,
        scaleY = 0.5,
        rotation = math.pi / 4,
        classname = "image-rotated"
    })

    -- Example 5: Colored/tinted image
    local image5 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 20,
        y = 250,
        scaleX = 0.5,
        scaleY = 0.5,
        color = { 1, 0.5, 0.5, 1 },
        classname = "image-tinted"
    })

    -- Example 6: Image with shader (if available)
    local shader = nil
    local shaderPath = "assets/grad.glsl"
    local info = love.filesystem.getInfo(shaderPath)
    if info and info.type == "file" then
        local success, result = pcall(love.graphics.newShader, shaderPath)
        if success then
            shader = result
        end
    end

    local image6 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 250,
        y = 250,
        scaleX = 0.5,
        scaleY = 0.5,
        shader = shader,
        classname = "image-shader"
    })

    local image7 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 480,
        y = 250,
        scaleX = 0.4,
        scaleY = 0.4,
        classname = "image-animated-rotation"
    })

    local rotation = 0
    image7:setUpdateCallback(function(widget, dt)
        rotation = rotation + dt
        widget:setRotation(rotation)
    end)

    local image8 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 650,
        y = 250,
        scaleX = 0.4,
        scaleY = 0.4,
        classname = "image-animated-scale"
    })

    local scaleTime = 0
    image8:setUpdateCallback(function(widget, dt)
        scaleTime = scaleTime + dt
        local scale = 0.4 + math.sin(scaleTime * 2) * 0.1
        widget:setScale(scale, scale)
    end)

    local image9 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 20,
        y = 480,
        scaleX = 0.5,
        scaleY = 0.5,
        classname = "image-pulsing-color"
    })

    local colorTime = 0
    image9:setUpdateCallback(function(widget, dt)
        colorTime = colorTime + dt
        local intensity = 0.5 + math.sin(colorTime * 3) * 0.5
        widget:setColor(1, intensity, intensity, 1)
    end)

    local image10 = nurture.Image:new(N, "assets/image.jpeg", {
        x = 250,
        y = 480,
        scaleX = 0.4,
        scaleY = 0.4,
        classname = "image-centered-origin"
    })
    
    local imgWidth = image10.image:getWidth()
    local imgHeight = image10.image:getHeight()
    image10:setOrigin(imgWidth / 2, imgHeight / 2)
    
    local rotTime = 0
    image10:setUpdateCallback(function(widget, dt)
        rotTime = rotTime + dt * 2
        widget:setRotation(rotTime)
    end)
end

return {
    load = load
}


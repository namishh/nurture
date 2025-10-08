local pauseMenu = nil
local pauseMenuBox = nil
local pauseMenuLabel = nil
local dots = {}
local menuButtons = {}
local isPaused = false

local function load(nurture, N)
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    pauseMenuLabel = nurture.TextLabel:new(N, "PAUSED", "bigtitle", {
        color = { 1, 1, 1, 1 },
        justify = "center",
        horizAlign = "center"
    })

    dots = {}
    for i = 1, 16 do
        local dot = nurture.Box:new(N, {
            forcedWidth = 5,
            forcedHeight = 5,
            backgroundColor = { 1, 1, 1, 1 },
            rounding = 4,
        })
        table.insert(dots, dot)
    end

    local dottedLine = nurture.HBox:new(N, {
        spacing = 8,
        padding = 0,
        halign = "center",
        valign = "center",
        children = dots
    })

    local function createMenuButton(text, primaryColor, hoveredColor, pressedColor)
        local button = nurture.Button:new(N, {
            padding = 12,
            rounding = 8,
            zIndex = 1000,
            colors = {
                primaryColor = primaryColor,
                hoveredColor = hoveredColor,
                pressedColor = pressedColor,
            },
            shadow = {
                x = 0,
                y = 4,
                color = { 0, 0, 0, 0.5 }
            },
            onClick = function(btn)
                print(text .. " clicked!")
            end,
            child = nurture.TextLabel:new(N, text, "BodyFont", {
                color = { 1, 1, 1, 1 }
            })
        })

        return button
    end

    local resumeButton = createMenuButton("RESUME",
        { 0.3, 0.7, 0.4, 1 },
        { 0.4, 0.8, 0.5, 1 },
        { 0.2, 0.6, 0.3, 1 })

    resumeButton:setOnClick(function(btn)
        print("RESUME clicked!")
        if isPaused then
            isPaused = false
            if pauseMenu then
                pauseMenu:hide()
            end
        end
    end)

    local menuButton = createMenuButton("GO TO MENU",
        { 0.4, 0.5, 0.7, 1 },
        { 0.5, 0.6, 0.8, 1 },
        { 0.3, 0.4, 0.6, 1 })

    local optionsButton = createMenuButton("OPTIONS",
        { 0.6, 0.4, 0.7, 1 },
        { 0.7, 0.5, 0.8, 1 },
        { 0.5, 0.3, 0.6, 1 })

    local quitButton = createMenuButton("QUIT GAME",
        { 0.8, 0.3, 0.3, 1 },
        { 0.9, 0.4, 0.4, 1 },
        { 0.7, 0.2, 0.2, 1 })

    menuButtons = { resumeButton, menuButton, optionsButton, quitButton }

    local buttonsVBox = nurture.VBox:new(N, {
        spacing = 10,
        padding = 0,
        halign = "center",
        valign = "center",
        zIndex = 102,
        children = menuButtons
    })

    local pauseMenuVBox = nurture.VBox:new(N, {
        spacing = 20,
        padding = 0,
        halign = "center",
        valign = "center",
        zIndex = 102,
        children = {
            pauseMenuLabel,
            dottedLine,
            buttonsVBox
        }
    })

    pauseMenuBox = nurture.Box:new(N, {
        backgroundColor = { 0.2, 0.2, 0.25, 1 },
        rounding = 15,
        forcedWidth = 300,
        padding = 30,
        halign = "center",
        valign = "center",
        zIndex = 1,
        shadow = {
            x = 0,
            y = 8,
            color = { 0, 0, 0, 0.5 }
        },
        children = {
            pauseMenuVBox
        }
    })

    pauseMenu = nurture.Box:new(N, {
        x = 0,
        y = 0,
        forcedWidth = windowWidth,
        forcedHeight = windowHeight,
        backgroundColor = { 0, 0, 0, 0.8 },
        rounding = 0,
        padding = 50,
        halign = "center",
        valign = "center",
        zIndex = 100,
        children = {
            pauseMenuBox
        }
    })

    pauseMenu:hide()
    isPaused = false

    nurture.TextLabel:new(N, "Press 0 to toggle pause menu", "BodyFont", {
        color = { 1, 1, 1, 1 },
    })
end

local function togglePause()
    if not pauseMenu then return end

    isPaused = not isPaused
    if isPaused then
        pauseMenu:show()
        print("Game paused")
    else
        pauseMenu:hide()
        print("Game resumed")
    end
end

local function keypressed(key)
    if key == "0" then
        togglePause()
    end
end

return {
    load = load,
    keypressed = keypressed
}


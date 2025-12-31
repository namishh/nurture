local function load(nurture, N)
    local tabWidth = 600
    local tabHeight = 350
    local tabX = 100
    local tabY = 100
    
    local hboxItem1 = nurture.Box:new(N, {
        padding = 20,
        backgroundColor = { 0.3, 0.5, 0.7, 1 },
        rounding = 8,
        child = nurture.TextLabel:new(N, "Item 1", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local hboxItem2 = nurture.Box:new(N, {
        padding = 20,
        backgroundColor = { 0.5, 0.3, 0.7, 1 },
        rounding = 8,
        child = nurture.TextLabel:new(N, "Item 2", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local hboxItem3 = nurture.Box:new(N, {
        padding = 20,
        backgroundColor = { 0.7, 0.5, 0.3, 1 },
        rounding = 8,
        child = nurture.TextLabel:new(N, "Item 3", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local hbox = nurture.HBox:new(N, {
        spacing = 15,
        children = { hboxItem1, hboxItem2, hboxItem3 }
    })
    
    local tab1Box = nurture.Box:new(N, {
        padding = 40,
        backgroundColor = { 0.15, 0.15, 0.2, 1 },
        rounding = 10,
        child = hbox,
        forcedWidth = tabWidth,
        forcedHeight = tabHeight
    })
    
    local button1 = nurture.Button:new(N, {
        padding = { left = 40, right = 40, top = 20, bottom = 20 },
        rounding = 8,
        colors = {
            primaryColor = { 0.4, 0.6, 0.3, 1 },
            hoveredColor = { 0.5, 0.7, 0.4, 1 },
            pressedColor = { 0.3, 0.5, 0.2, 1 }
        },
        onClick = function(btn)
            print("Button 1 clicked!")
        end,
        child = nurture.TextLabel:new(N, "Button 1", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local button2 = nurture.Button:new(N, {
        padding = { left = 40, right = 40, top = 20, bottom = 20 },
        rounding = 8,
        colors = {
            primaryColor = { 0.6, 0.3, 0.4, 1 },
            hoveredColor = { 0.7, 0.4, 0.5, 1 },
            pressedColor = { 0.5, 0.2, 0.3, 1 }
        },
        onClick = function(btn)
            print("Button 2 clicked!")
        end,
        child = nurture.TextLabel:new(N, "Button 2", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local buttonVBox = nurture.VBox:new(N, {
        spacing = 20,
        children = { button1, button2 }
    })
    
    local tab2Box = nurture.Box:new(N, {
        padding = 40,
        backgroundColor = { 0.15, 0.15, 0.2, 1 },
        rounding = 10,
        child = buttonVBox,
        forcedWidth = tabWidth,
        forcedHeight = tabHeight
    })
    
    local vboxItem1 = nurture.Box:new(N, {
        padding = 15,
        backgroundColor = { 0.8, 0.3, 0.3, 1 },
        rounding = 8,
        child = nurture.TextLabel:new(N, "VBox Item 1", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local vboxItem2 = nurture.Box:new(N, {
        padding = 15,
        backgroundColor = { 0.3, 0.8, 0.3, 1 },
        rounding = 8,
        child = nurture.TextLabel:new(N, "VBox Item 2", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local vboxItem3 = nurture.Box:new(N, {
        padding = 15,
        backgroundColor = { 0.3, 0.3, 0.8, 1 },
        rounding = 8,
        child = nurture.TextLabel:new(N, "VBox Item 3", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })
    
    local vbox = nurture.VBox:new(N, {
        spacing = 15,
        children = { vboxItem1, vboxItem2, vboxItem3 }
    })
    
    local tab3Box = nurture.Box:new(N, {
        padding = 40,
        backgroundColor = { 0.15, 0.15, 0.2, 1 },
        rounding = 10,
        child = vbox,
        forcedWidth = tabWidth,
        forcedHeight = tabHeight
    })
    
    local tabbed = nurture.Tabbed:new(N, {
        x = tabX,
        y = tabY,
        tabs = {
            home = tab1Box,
            buttons = tab2Box,
            list = tab3Box
        },
        tabOrder = { "home", "buttons", "list" },
        activeTab = "buttons"
    })
    
    local tabBarHeight = 50
    local tabButtons = {}
    
    for i, tabName in ipairs(tabbed.tablist) do
        local isActive = (tabName == tabbed:getActiveTabName())
        
        local tabLabel = nurture.TextLabel:new(N, tabName:upper(), "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
        
        local tabButton = nurture.Button:new(N, {
            padding = 15,
            rounding = 0,
            colors = {
                primaryColor = isActive and { 0.3, 0.5, 0.7, 1 } or { 0.2, 0.2, 0.25, 1 },
                hoveredColor = isActive and { 0.35, 0.55, 0.75, 1 } or { 0.25, 0.25, 0.3, 1 },
                pressedColor = isActive and { 0.25, 0.45, 0.65, 1 } or { 0.15, 0.15, 0.2, 1 }
            },
            onClick = function(btn)
                print("Clicked tab: " .. tabName)
                tabbed:switch(tabName)
                
                for _, tn in ipairs(tabbed.tablist) do
                    local button = N:getAllByClassname("tab_" .. tn)[1]
                    if tn == tabbed:getActiveTabName() then
                        button:setColors({
                            primaryColor = { 0.3, 0.5, 0.7, 1 },
                            hoveredColor = { 0.35, 0.55, 0.75, 1 },
                            pressedColor = { 0.25, 0.45, 0.65, 1 }
                        })
                    else
                        button:setColors({
                            primaryColor = { 0.2, 0.2, 0.25, 1 },
                            hoveredColor = { 0.25, 0.25, 0.3, 1 },
                            pressedColor = { 0.15, 0.15, 0.2, 1 }
                        })
                    end
                end
            end,
            child = tabLabel,
            classname = "tab_" .. tabName
        })
        
        table.insert(tabButtons, tabButton)
    end
    
    local fractions = {}
    for i = 1, #tabButtons do
        table.insert(fractions, 1 / #tabButtons)
    end
    
    local tabBar = nurture.HFracBox:new(N, {
        x = tabX,
        y = tabY - tabBarHeight,
        forcedHeight = tabBarHeight,
        forcedWidth = tabWidth,
        fractions = fractions,
        children = tabButtons
    })
    
    local titleLabel = nurture.TextLabel:new(N, "Tabbed Widget Test", "BodyFont", {
        color = { 1, 1, 1, 0.8 }
    })
    titleLabel:setPosition(tabX, 20)
    
    local instructionLabel = nurture.TextLabel:new(N, "Click tabs to switch content", "BodyFont", {
        color = { 0.7, 0.7, 0.7, 0.8 }
    })
    instructionLabel:setPosition(tabX, 480)
end

return {
    load = load
}

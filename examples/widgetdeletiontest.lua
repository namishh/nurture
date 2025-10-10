local function load(nurture, N)
    local title = nurture.TextLabel:new(N, "Widget Deletion Test", "BodyFont", {
        color = { 1, 1, 1, 1 }
    })
    title:setPosition(50, 20)

    local container = nurture.VBox:new(N, {
        x = 50,
        y = 60,
        spacing = 10
    })

    local function createWidgetWithDeleteButton(index)
        local hbox = nurture.HBox:new(N, {
            spacing = 10
        })

        local label = nurture.TextLabel:new(N, "Widget #" .. index, "BodyFont", {
            color = { 1, 1, 1, 1 }
        })

        local deleteBtn = nurture.Button:new(N, {
            padding = 8,
            rounding = 5,
            colors = {
                primaryColor = { 0.8, 0.3, 0.3, 1.0 },
                hoveredColor = { 0.9, 0.4, 0.4, 1.0 },
                pressedColor = { 0.7, 0.2, 0.2, 1.0 }
            },
            onClick = function(btn)
                container:removeChild(hbox, true) 
                print("Deleted widget #" .. index)
                print("Remaining widgets in container: " .. #container:getChildren())
            end,
            child = nurture.TextLabel:new(N, "Delete", "BodyFont", {
                color = { 1, 1, 1, 1 }
            })
        })

        hbox:addChild(label)
        hbox:addChild(deleteBtn)

        return hbox
    end

    for i = 1, 5 do
        local widget = createWidgetWithDeleteButton(i)
        container:addChild(widget)
    end

    local widgetCounter = 6
    local addBtn = nurture.Button:new(N, {
        x = 50,
        y = 350,
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.3, 0.8, 0.3, 1.0 },
            hoveredColor = { 0.4, 0.9, 0.4, 1.0 },
            pressedColor = { 0.2, 0.7, 0.2, 1.0 }
        },
        onClick = function(btn)
            local newWidget = createWidgetWithDeleteButton(widgetCounter)
            container:addChild(newWidget)
            print("Added widget #" .. widgetCounter)
            widgetCounter = widgetCounter + 1
        end,
        child = nurture.TextLabel:new(N, "Add Widget", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local removeWithoutDeleteBtn = nurture.Button:new(N, {
        x = 170,
        y = 350,
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.8, 0.7, 0.3, 1.0 },
            hoveredColor = { 0.9, 0.8, 0.4, 1.0 },
            pressedColor = { 0.7, 0.6, 0.2, 1.0 }
        },
        onClick = function(btn)
            local children = container:getChildren()
            if #children > 0 then
                local child = children[1]
                container:removeChild(child, false) 
                print("Removed (but not deleted) first widget. It still exists in memory.")
            end
        end,
        child = nurture.TextLabel:new(N, "Remove (No Delete)", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local clearWithDeleteBtn = nurture.Button:new(N, {
        x = 370,
        y = 350,
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.7, 0.3, 0.7, 1.0 },
            hoveredColor = { 0.8, 0.4, 0.8, 1.0 },
            pressedColor = { 0.6, 0.2, 0.6, 1.0 }
        },
        onClick = function(btn)
            container:clear(true)  -- true = delete all children
            print("Cleared all widgets (deleted from memory)")
            print("Remaining widgets: " .. #container:getChildren())
        end,
        child = nurture.TextLabel:new(N, "Clear All (Delete)", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local directDeleteBtn = nurture.Button:new(N, {
        x = 570,
        y = 350,
        padding = 10,
        rounding = 5,
        colors = {
            primaryColor = { 0.9, 0.4, 0.2, 1.0 },
            hoveredColor = { 1.0, 0.5, 0.3, 1.0 },
            pressedColor = { 0.8, 0.3, 0.1, 1.0 }
        },
        onClick = function(btn)
            local children = container:getChildren()
            if #children > 0 then
                local child = children[#children]
                child:delete()
                print("Directly deleted last widget using widget:delete()")
                print("Remaining widgets: " .. #container:getChildren())
            end
        end,
        child = nurture.TextLabel:new(N, "Direct Delete", "BodyFont", {
            color = { 1, 1, 1, 1 }
        })
    })

    local info1 = nurture.TextLabel:new(N,
        "Click 'Delete' buttons to remove and delete specific widgets", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    info1:setPosition(50, 400)

    local info2 = nurture.TextLabel:new(N,
        "Remove (No Delete) = widget removed from container but stays in memory", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    info2:setPosition(50, 420)

    local info3 = nurture.TextLabel:new(N,
        "Clear All (Delete) = all widgets removed AND deleted from memory", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    info3:setPosition(50, 440)

    local info4 = nurture.TextLabel:new(N,
        "Direct Delete = call widget:delete() to completely remove it", "BodyFont", {
        color = { 1, 1, 1, 0.7 }
    })
    info4:setPosition(50, 460)

    local info5 = nurture.TextLabel:new(N,
        "Check console for debug messages", "BodyFont", {
        color = { 0.8, 0.8, 1, 0.8 }
    })
    info5:setPosition(50, 490)
end

return {
    load = load
}


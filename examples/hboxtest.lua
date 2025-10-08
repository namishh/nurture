local function load(nurture, N)
    local hbox1 = nurture.HBox:new(N, {
        x = 20,
        y = 20,
        spacing = 10,
        forcedWidth = 400,
        forcedHeight = 80,
        justify = "left",
        classname = "hbox-left",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.3, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Left 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.4, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Left 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.5, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Left 3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    -- Example 2: HBox with "center" justification
    local hbox2 = nurture.HBox:new(N, {
        x = 20,
        y = 120,
        spacing = 10,
        forcedWidth = 400,
        forcedHeight = 80,
        justify = "center",
        classname = "hbox-center",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.3, 0.8, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Center 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.3, 0.8, 0.5, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Center 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    -- Example 3: HBox with "right" justification
    local hbox3 = nurture.HBox:new(N, {
        x = 20,
        y = 220,
        spacing = 10,
        forcedWidth = 400,
        forcedHeight = 80,
        justify = "right",
        classname = "hbox-right",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.3, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Right 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.4, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Right 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    -- Example 4: HBox with "space-between" justification
    local hbox4 = nurture.HBox:new(N, {
        x = 20,
        y = 320,
        spacing = 10,
        forcedWidth = 400,
        forcedHeight = 80,
        justify = "space-between",
        classname = "hbox-space-between",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Between 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.9, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Between 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.3, 0.9, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Between 3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    -- Example 5: HBox with "space-evenly" justification
    local hbox5 = nurture.HBox:new(N, {
        x = 450,
        y = 20,
        spacing = 10,
        forcedWidth = 350,
        forcedHeight = 80,
        justify = "space-evenly",
        classname = "hbox-space-evenly",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.8, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Evenly 1", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 50,
                backgroundColor = { 0.9, 0.9, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Evenly 2", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.9, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Evenly 3", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            })
        }
    })

    local hbox6 = nurture.HBox:new(N, {
        x = 450,
        y = 120,
        spacing = 15,
        forcedWidth = 350,
        forcedHeight = 120,
        justify = "left",
        classname = "hbox-alignment",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 40,
                vertAlign = "top",
                backgroundColor = { 0.3, 0.8, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Top", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 60,
                vertAlign = "center",
                backgroundColor = { 0.4, 0.8, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Center", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 40,
                vertAlign = "bottom",
                backgroundColor = { 0.5, 0.8, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Bottom", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                vertAlign = "stretch",
                backgroundColor = { 0.3, 0.9, 0.9, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Stretch", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local hbox7 = nurture.HBox:new(N, {
        x = 450,
        y = 260,
        spacing = 8,
        forcedWidth = 350,
        forcedHeight = 70,
        justify = "left",
        classname = "hbox-dynamic",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.6, 0.4, 0.7, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Dynamic 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    hbox7:setAddChildCallback(function(widget, child)
        print("Child added to HBox!")
    end)

    local timer = 0
    hbox7:setUpdateCallback(function(widget, dt)
        timer = timer + dt
        if timer > 2 and #widget:getChildren() == 1  then
            widget:addChild(nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.7, 0.5, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Dynamic 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }))
        end
    end)

    local innerHBox = nurture.HBox:new(N, {
        spacing = 5,
        forcedHeight = 40,
        justify = "center",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 50,
                forcedHeight = 30,
                backgroundColor = { 1, 0.9, 0.7, 0.9 },
                rounding = 3,
                children = {
                    nurture.TextLabel:new(N, "N1", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 50,
                forcedHeight = 30,
                backgroundColor = { 1, 0.8, 0.6, 0.9 },
                rounding = 3,
                children = {
                    nurture.TextLabel:new(N, "N2", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            })
        }
    })

    local hbox8 = nurture.HBox:new(N, {
        x = 450,
        y = 350,
        spacing = 10,
        forcedWidth = 350,
        forcedHeight = 80,
        justify = "center",
        classname = "hbox-nested",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 50,
                backgroundColor = { 0.9, 0.6, 0.4, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Outer L", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            innerHBox,
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 50,
                backgroundColor = { 0.9, 0.6, 0.4, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Outer R", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })
end

return {
    load = load
}


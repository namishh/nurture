local function load(nurture, N)
    local vbox1 = nurture.VBox:new(N, {
        x = 20,
        y = 20,
        spacing = 10,
        forcedWidth = 150,
        forcedHeight = 250,
        justify = "top",
        classname = "vbox-top",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
                backgroundColor = { 0.8, 0.3, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Top 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
                backgroundColor = { 0.8, 0.4, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Top 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
                backgroundColor = { 0.8, 0.5, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Top 3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    -- Example 2: VBox with "center" justification
    local vbox2 = nurture.VBox:new(N, {
        x = 200,
        y = 20,
        spacing = 10,
        forcedWidth = 150,
        forcedHeight = 250,
        justify = "center",
        classname = "vbox-center",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
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
                forcedWidth = 100,
                forcedHeight = 40,
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

    -- Example 3: VBox with "bottom" justification
    local vbox3 = nurture.VBox:new(N, {
        x = 380,
        y = 20,
        spacing = 10,
        forcedWidth = 150,
        forcedHeight = 250,
        justify = "bottom",
        classname = "vbox-bottom",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
                backgroundColor = { 0.3, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Bottom 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
                backgroundColor = { 0.4, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Bottom 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    -- Example 4: VBox with "space-between" justification
    local vbox4 = nurture.VBox:new(N, {
        x = 560,
        y = 20,
        spacing = 10,
        forcedWidth = 150,
        forcedHeight = 250,
        justify = "space-between",
        classname = "vbox-space-between",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
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
                forcedWidth = 100,
                forcedHeight = 40,
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
                forcedWidth = 100,
                forcedHeight = 40,
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

    -- Example 5: VBox with "space-evenly" justification
    local vbox5 = nurture.VBox:new(N, {
        x = 20,
        y = 300,
        spacing = 10,
        forcedWidth = 150,
        forcedHeight = 250,
        justify = "space-evenly",
        classname = "vbox-space-evenly",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 40,
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
                forcedWidth = 100,
                forcedHeight = 40,
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
                forcedWidth = 100,
                forcedHeight = 40,
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

    -- Example 6: VBox with different horizontal alignments
    local vbox6 = nurture.VBox:new(N, {
        x = 200,
        y = 300,
        spacing = 15,
        forcedWidth = 200,
        forcedHeight = 250,
        justify = "top",
        classname = "vbox-alignment",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 80,
                forcedHeight = 35,
                horizAlign = "left",
                backgroundColor = { 0.3, 0.8, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Left", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 100,
                forcedHeight = 35,
                horizAlign = "center",
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
                forcedWidth = 80,
                forcedHeight = 35,
                horizAlign = "right",
                backgroundColor = { 0.5, 0.8, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Right", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedHeight = 35,
                horizAlign = "stretch",
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

    -- Example 7: VBox with dynamic children (with callbacks)
    local vbox7 = nurture.VBox:new(N, {
        x = 430,
        y = 300,
        spacing = 8,
        forcedWidth = 140,
        forcedHeight = 250,
        justify = "top",
        classname = "vbox-dynamic",
        children = {
            nurture.Box:new(N, {
                forcedHeight = 30,
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

    vbox7:setAddChildCallback(function(widget, child)
        print("Child added to VBox!")
    end)

    -- Add a child after 2 seconds
    local timer = 0
    vbox7:setUpdateCallback(function(widget, dt)
        timer = timer + dt
        if timer > 2 and #widget:getChildren() == 1 then
            widget:addChild(nurture.Box:new(N, {
                forcedHeight = 30,
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

    -- Example 8: Nested VBox
    local innerVBox = nurture.VBox:new(N, {
        spacing = 5,
        forcedWidth = 100,
        justify = "center",
        children = {
            nurture.Box:new(N, {
                forcedHeight = 25,
                backgroundColor = { 1, 0.9, 0.7, 0.9 },
                rounding = 3,
                children = {
                    nurture.TextLabel:new(N, "Nested 1", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedHeight = 25,
                backgroundColor = { 1, 0.8, 0.6, 0.9 },
                rounding = 3,
                children = {
                    nurture.TextLabel:new(N, "Nested 2", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            })
        }
    })

    local vbox8 = nurture.VBox:new(N, {
        x = 600,
        y = 300,
        spacing = 10,
        forcedWidth = 150,
        forcedHeight = 250,
        justify = "center",
        classname = "vbox-nested",
        children = {
            nurture.Box:new(N, {
                forcedHeight = 30,
                backgroundColor = { 0.9, 0.6, 0.4, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Outer Top", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            innerVBox,
            nurture.Box:new(N, {
                forcedHeight = 30,
                backgroundColor = { 0.9, 0.6, 0.4, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Outer Bottom", "BodyFont", {
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


local function load(nurture, N)
    local vfracbox1 = nurture.VFracBox:new(N, {
        x = 20,
        y = 20,
        spacing = 10,
        forcedWidth = 100,
        forcedHeight = 400,
        classname = "vfracbox-equal",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.8, 0.3, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Equal 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.8, 0.4, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Equal 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.8, 0.5, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Equal 3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local vfracbox2 = nurture.VFracBox:new(N, {
        x = 140,
        y = 20,
        spacing = 10,
        forcedWidth = 100,
        forcedHeight = 400,
        ratios = { 2, 1, 1 },
        classname = "vfracbox-ratio-2-1-1",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.3, 0.8, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Ratio 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.3, 0.8, 0.5, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Ratio 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.3, 0.8, 0.7, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Ratio 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local vfracbox3 = nurture.VFracBox:new(N, {
        x = 260,
        y = 20,
        spacing = 10,
        forcedWidth = 100,
        forcedHeight = 400,
        ratios = { 3, 1, 2 },
        classname = "vfracbox-ratio-3-1-2",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.3, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Ratio 3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.4, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Ratio 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.5, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Ratio 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local vfracbox4 = nurture.VFracBox:new(N, {
        x = 380,
        y = 20,
        spacing = 20,
        forcedWidth = 100,
        forcedHeight = 400,
        ratios = { 1, 1, 1, 1 },
        classname = "vfracbox-spacing",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.8, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Space 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.9, 0.3, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Space 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.8, 0.3, 0.9, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Space 3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.9, 0.3, 0.9, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Space 4", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local vfracbox5 = nurture.VFracBox:new(N, {
        x = 500,
        y = 20,
        spacing = 15,
        forcedWidth = 150,
        forcedHeight = 400,
        ratios = { 1, 1, 1, 1 },
        classname = "vfracbox-alignment",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 50,
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
                forcedWidth = 70,
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
                forcedWidth = 50,
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

    local goldenRatio = 1.618
    local vfracbox6 = nurture.VFracBox:new(N, {
        x = 670,
        y = 20,
        spacing = 10,
        forcedWidth = 120,
        forcedHeight = 250,
        ratios = { goldenRatio, 1 },
        classname = "vfracbox-golden",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.8, 0.8, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Golden (1.618)", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.9, 0.9, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "1", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            })
        }
    })

    local innerVFracBox = nurture.VFracBox:new(N, {
        spacing = 5,
        forcedWidth = 100,
        ratios = { 1, 2 },
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 1, 0.9, 0.7, 0.9 },
                rounding = 3,
                children = {
                    nurture.TextLabel:new(N, "N1", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 1, 0.8, 0.6, 0.9 },
                rounding = 3,
                children = {
                    nurture.TextLabel:new(N, "N2 (2x)", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            })
        }
    })

    local vfracbox7 = nurture.VFracBox:new(N, {
        x = 670,
        y = 290,
        spacing = 10,
        forcedWidth = 120,
        forcedHeight = 250,
        ratios = { 1, 2, 1 },
        classname = "vfracbox-nested",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.9, 0.6, 0.4, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Outer Top", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            innerVFracBox,
            nurture.Box:new(N, {
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

    local vfracbox8 = nurture.VFracBox:new(N, {
        x = 20,
        y = 440,
        spacing = 5,
        forcedWidth = 100,
        forcedHeight = 150,
        ratios = { 1, 1 },
        classname = "vfracbox-fifty-fifty",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.4, 0.6, 0.9, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "50%", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.5, 0.7, 0.9, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "50%", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local vfracbox9 = nurture.VFracBox:new(N, {
        x = 140,
        y = 440,
        spacing = 8,
        forcedWidth = 100,
        forcedHeight = 150,
        classname = "vfracbox-dynamic-no-ratios",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.7, 0.3, 0.5, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Start", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local timer9 = 0
    local childCount9 = 1
    vfracbox9:setUpdateCallback(function(widget, dt)
        timer9 = timer9 + dt
        if timer9 > 1.5 and childCount9 < 4 then
            childCount9 = childCount9 + 1
            widget:addChild(nurture.Box:new(N, {
                backgroundColor = { 0.3 + childCount9 * 0.1, 0.3, 0.5 + childCount9 * 0.1, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Auto " .. childCount9, "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }))
            timer9 = 0
        end
    end)

    local vfracbox10 = nurture.VFracBox:new(N, {
        x = 260,
        y = 440,
        spacing = 8,
        forcedWidth = 100,
        forcedHeight = 150,
        ratios = { 2 },
        classname = "vfracbox-dynamic-with-ratios",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.5, 0.7, 0.3, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "2x Start", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local timer10 = 0
    local childCount10 = 1
    vfracbox10:setUpdateCallback(function(widget, dt)
        timer10 = timer10 + dt
        if timer10 > 2 and childCount10 < 4 then
            childCount10 = childCount10 + 1
            widget:addChild(nurture.Box:new(N, {
                backgroundColor = { 0.5, 0.7 - childCount10 * 0.1, 0.3 + childCount10 * 0.15, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "1x Child " .. childCount10, "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }))
            local newRatios = { 2 }
            for i = 2, childCount10 do
                newRatios[i] = 1
            end
            widget:setRatios(newRatios)
            timer10 = 0
        end
    end)

    local vfracbox11 = nurture.VFracBox:new(N, {
        x = 380,
        y = 440,
        spacing = 8,
        forcedWidth = 100,
        forcedHeight = 150,
        ratios = { 1, 1, 1 },
        classname = "vfracbox-changing-ratios",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.8, 0.4, 0.2, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "A", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.2, 0.8, 0.4, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "B", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                backgroundColor = { 0.4, 0.2, 0.8, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "C", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local timer11 = 0
    local ratioPhase = 1
    local ratioConfigs = {
        { 1, 1, 1 },
        { 3, 1, 1 },
        { 1, 3, 1 },
        { 1, 1, 3 },
        { 2, 1, 2 },
        { 1, 2, 1 }
    }

    vfracbox11:setUpdateCallback(function(widget, dt)
        timer11 = timer11 + dt
        if timer11 > 1.5 then
            ratioPhase = (ratioPhase % #ratioConfigs) + 1
            widget:setRatios(ratioConfigs[ratioPhase])
            timer11 = 0
        end
    end)
end

return {
    load = load
}


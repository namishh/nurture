local function load(nurture, N)
    local hfracbox1 = nurture.HFracBox:new(N, {
        x = 20,
        y = 20,
        spacing = 10,
        forcedWidth = 400,
        forcedHeight = 80,
        classname = "hfracbox-equal",
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

    local hfracbox2 = nurture.HFracBox:new(N, {
        x = 20,
        y = 120,
        spacing = 10,
        forcedWidth = 400,
        forcedHeight = 80,
        ratios = { 2, 1, 1 },
        classname = "hfracbox-ratio-2-1-1",
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

    local hfracbox3 = nurture.HFracBox:new(N, {
        x = 20,
        y = 220,
        spacing = 10,
        forcedWidth = 400,
        forcedHeight = 80,
        ratios = { 3, 1, 2 },
        classname = "hfracbox-ratio-3-1-2",
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

    local hfracbox4 = nurture.HFracBox:new(N, {
        x = 20,
        y = 320,
        spacing = 20,
        forcedWidth = 400,
        forcedHeight = 80,
        ratios = { 1, 1, 1, 1 },
        classname = "hfracbox-spacing",
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

    local hfracbox5 = nurture.HFracBox:new(N, {
        x = 450,
        y = 20,
        spacing = 15,
        forcedWidth = 350,
        forcedHeight = 120,
        ratios = { 1, 1, 1, 1 },
        classname = "hfracbox-alignment",
        children = {
            nurture.Box:new(N, {
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

    local goldenRatio = 1.618
    local hfracbox6 = nurture.HFracBox:new(N, {
        x = 450,
        y = 160,
        spacing = 10,
        forcedWidth = 350,
        forcedHeight = 80,
        ratios = { goldenRatio, 1 },
        classname = "hfracbox-golden",
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


    local innerHFracBox = nurture.HFracBox:new(N, {
        spacing = 5,
        forcedHeight = 40,
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

    local hfracbox8 = nurture.HFracBox:new(N, {
        x = 450,
        y = 350,
        spacing = 10,
        forcedWidth = 350,
        forcedHeight = 80,
        ratios = { 1, 2, 1 },
        classname = "hfracbox-nested",
        children = {
            nurture.Box:new(N, {
                backgroundColor = { 0.9, 0.6, 0.4, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Outer L", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            innerHFracBox,
            nurture.Box:new(N, {
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

    local hfracbox9 = nurture.HFracBox:new(N, {
        x = 20,
        y = 420,
        spacing = 5,
        forcedWidth = 400,
        forcedHeight = 100,
        ratios = { 1, 1 },
        classname = "hfracbox-fifty-fifty",
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

    local hfracbox10 = nurture.HFracBox:new(N, {
        x = 20,
        y = 540,
        spacing = 8,
        forcedWidth = 400,
        forcedHeight = 70,
        classname = "hfracbox-dynamic-no-ratios",
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

    local timer10 = 0
    local childCount10 = 1
    hfracbox10:setUpdateCallback(function(widget, dt)
        timer10 = timer10 + dt
        if timer10 > 1.5 and childCount10 < 4 then
            childCount10 = childCount10 + 1
            widget:addChild(nurture.Box:new(N, {
                backgroundColor = { 0.3 + childCount10 * 0.1, 0.3, 0.5 + childCount10 * 0.1, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Auto " .. childCount10, "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }))
            timer10 = 0
        end
    end)

    local hfracbox11 = nurture.HFracBox:new(N, {
        x = 450,
        y = 450,
        spacing = 8,
        forcedWidth = 350,
        forcedHeight = 70,
        ratios = { 2 },
        classname = "hfracbox-dynamic-with-ratios",
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

    local timer11 = 0
    local childCount11 = 1
    hfracbox11:setUpdateCallback(function(widget, dt)
        timer11 = timer11 + dt
        if timer11 > 2 and childCount11 < 4 then
            childCount11 = childCount11 + 1
            widget:addChild(nurture.Box:new(N, {
                backgroundColor = { 0.5, 0.7 - childCount11 * 0.1, 0.3 + childCount11 * 0.15, 0.8 },
                classname = "box-item",
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "1x Child " .. childCount11, "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }))
            local newRatios = { 2 }
            for i = 2, childCount11 do
                newRatios[i] = 1
            end
            widget:setRatios(newRatios)
            timer11 = 0
        end
    end)

    local hfracbox12 = nurture.HFracBox:new(N, {
        x = 450,
        y = 540,
        spacing = 8,
        forcedWidth = 350,
        forcedHeight = 70,
        ratios = { 1, 1, 1 },
        classname = "hfracbox-changing-ratios",
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

    local timer12 = 0
    local ratioPhase = 1
    local ratioConfigs = {
        { 1, 1, 1 },
        { 3, 1, 1 },
        { 1, 3, 1 },
        { 1, 1, 3 },
        { 2, 1, 2 },
        { 1, 2, 1 }
    }

    hfracbox12:setUpdateCallback(function(widget, dt)
        timer12 = timer12 + dt
        if timer12 > 1.5 then
            ratioPhase = (ratioPhase % #ratioConfigs) + 1
            widget:setRatios(ratioConfigs[ratioPhase])
            timer12 = 0
        end
    end)
end

return {
    load = load
}

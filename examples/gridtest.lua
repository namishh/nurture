local function load(nurture, N)
    local grid1 = nurture.Grid:new(N, {
        x = 20,
        y = 20,
        rows = 3,
        columns = 3,
        spacing = 10,
        fillDirection = "row",
        classname = "grid-row-fill",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.8, 0.3, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.8, 0.4, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.8, 0.5, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.3, 0.8, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "4", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.3, 0.8, 0.5, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "5", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.3, 0.8, 0.7, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "6", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.3, 0.3, 0.8, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "7", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.4, 0.3, 0.8, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "8", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.6, 0.3, 0.8, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "9", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local grid2 = nurture.Grid:new(N, {
        x = 280,
        y = 20,
        rows = 3,
        columns = 3,
        spacing = 10,
        fillDirection = "column",
        classname = "grid-column-fill",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.8, 0.3, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.8, 0.4, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.8, 0.5, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.3, 0.8, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "4", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.3, 0.8, 0.5, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "5", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.3, 0.8, 0.7, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "6", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
        }
    })

    local grid3 = nurture.Grid:new(N, {
        x = 540,
        y = 20,
        rows = 3,
        columns = 3,
        spacing = 10,
        classname = "grid-set-cell",
    })

    grid3:setCell(1, 1, nurture.Box:new(N, {
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 0.9, 0.2, 0.2, 0.8 },
        rounding = 5,
        children = {
            nurture.TextLabel:new(N, "A", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    }))

    grid3:setCell(1, 3, nurture.Box:new(N, {
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 0.2, 0.9, 0.2, 0.8 },
        rounding = 5,
        children = {
            nurture.TextLabel:new(N, "B", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    }))

    grid3:setCell(2, 2, nurture.Box:new(N, {
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 0.2, 0.2, 0.9, 0.8 },
        rounding = 5,
        children = {
            nurture.TextLabel:new(N, "C", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    }))

    grid3:setCell(3, 1, nurture.Box:new(N, {
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 0.9, 0.9, 0.2, 0.8 },
        rounding = 5,
        children = {
            nurture.TextLabel:new(N, "D", "BodyFont", {
                color = { 0, 0, 0, 1 },
            })
        }
    }))

    grid3:setCell(3, 3, nurture.Box:new(N, {
        forcedWidth = 60,
        forcedHeight = 60,
        backgroundColor = { 0.9, 0.2, 0.9, 0.8 },
        rounding = 5,
        children = {
            nurture.TextLabel:new(N, "E", "BodyFont", {
                color = { 1, 1, 1, 1 },
            })
        }
    }))

    local grid4 = nurture.Grid:new(N, {
        x = 20,
        y = 280,
        rows = 2,
        columns = 4,
        spacing = 8,
        classname = "grid-different-sizes",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 50,
                forcedHeight = 50,
                backgroundColor = { 0.7, 0.4, 0.5, 0.8 },
                rounding = 5,
            }),
            nurture.Box:new(N, {
                forcedWidth = 80,
                forcedHeight = 40,
                backgroundColor = { 0.7, 0.5, 0.4, 0.8 },
                rounding = 5,
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 70,
                backgroundColor = { 0.6, 0.5, 0.4, 0.8 },
                rounding = 5,
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.5, 0.5, 0.4, 0.8 },
                rounding = 5,
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.4, 0.6, 0.5, 0.8 },
                rounding = 5,
            }),
            nurture.Box:new(N, {
                forcedWidth = 50,
                forcedHeight = 50,
                backgroundColor = { 0.4, 0.7, 0.5, 0.8 },
                rounding = 5,
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 40,
                backgroundColor = { 0.4, 0.5, 0.6, 0.8 },
                rounding = 5,
            }),
            nurture.Box:new(N, {
                forcedWidth = 55,
                forcedHeight = 55,
                backgroundColor = { 0.4, 0.5, 0.7, 0.8 },
                rounding = 5,
            }),
        }
    })

    local grid5 = nurture.Grid:new(N, {
        x = 420,
        y = 280,
        rows = 2,
        columns = 3,
        spacing = 10,
        forcedCellWidth = 80,
        forcedCellHeight = 80,
        classname = "grid-forced-cell-size",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 50,
                forcedHeight = 50,
                backgroundColor = { 0.8, 0.6, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 60,
                forcedHeight = 60,
                backgroundColor = { 0.8, 0.7, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 40,
                forcedHeight = 40,
                backgroundColor = { 0.7, 0.7, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "3", "BodyFont", {
                        color = { 0, 0, 0, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 70,
                forcedHeight = 50,
                backgroundColor = { 0.3, 0.7, 0.6, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "4", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 55,
                forcedHeight = 55,
                backgroundColor = { 0.3, 0.6, 0.7, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "5", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
        }
    })
end

return {
    load = load
}


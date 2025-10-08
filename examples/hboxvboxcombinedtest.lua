local function load(nurture, N)
    local mainLayout = nurture.VBox:new(N, {
        x = 50,
        y = 50,
        spacing = 20,
        forcedWidth = 700,
        forcedHeight = 500,
        justify = "top",
        classname = "main-layout",
        children = {}
    })

    local header = nurture.HBox:new(N, {
        spacing = 10,
        forcedHeight = 60,
        justify = "space-between",
        classname = "header",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 150,
                backgroundColor = { 0.2, 0.4, 0.8, 0.9 },
                rounding = 8,
                children = {
                    nurture.TextLabel:new(N, "Logo", "title", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.HBox:new(N, {
                spacing = 8,
                justify = "right",
                children = {
                    nurture.Box:new(N, {
                        forcedWidth = 80,
                        backgroundColor = { 0.3, 0.3, 0.3, 0.8 },
                        rounding = 5,
                        children = {
                            nurture.TextLabel:new(N, "Home", "BodyFont", {
                                color = { 1, 1, 1, 1 },
                            })
                        }
                    }),
                    nurture.Box:new(N, {
                        forcedWidth = 80,
                        backgroundColor = { 0.3, 0.3, 0.3, 0.8 },
                        rounding = 5,
                        children = {
                            nurture.TextLabel:new(N, "About", "BodyFont", {
                                color = { 1, 1, 1, 1 },
                            })
                        }
                    }),
                    nurture.Box:new(N, {
                        forcedWidth = 80,
                        backgroundColor = { 0.3, 0.3, 0.3, 0.8 },
                        rounding = 5,
                        children = {
                            nurture.TextLabel:new(N, "Contact", "BodyFont", {
                                color = { 1, 1, 1, 1 },
                            })
                        }
                    })
                }
            })
        }
    })

    local contentArea = nurture.HBox:new(N, {
        spacing = 15,
        forcedHeight = 350,
        justify = "space-between",
        classname = "content-area",
        children = {}
    })

    local sidebar = nurture.VBox:new(N, {
        spacing = 10,
        forcedWidth = 180,
        justify = "top",
        classname = "sidebar",
        children = {
            nurture.Box:new(N, {
                forcedHeight = 50,
                backgroundColor = { 0.4, 0.3, 0.6, 0.9 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Menu Item 1", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedHeight = 50,
                backgroundColor = { 0.4, 0.3, 0.6, 0.9 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Menu Item 2", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedHeight = 50,
                backgroundColor = { 0.4, 0.3, 0.6, 0.9 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Menu Item 3", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedHeight = 50,
                backgroundColor = { 0.4, 0.3, 0.6, 0.9 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Menu Item 4", "BodyFont", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            })
        }
    })

    local mainContent = nurture.VBox:new(N, {
        spacing = 15,
        forcedWidth = 490,
        justify = "top",
        classname = "main-content",
        children = {
            nurture.Box:new(N, {
                forcedHeight = 80,
                backgroundColor = { 0.2, 0.6, 0.4, 0.9 },
                rounding = 8,
                children = {
                    nurture.TextLabel:new(N, "Main Content Area", "title", {
                        color = { 1, 1, 1, 1 },
                    })
                }
            }),
            nurture.VBox:new(N, {
                spacing = 10,
                justify = "top",
                children = {
                    nurture.HBox:new(N, {
                        spacing = 10,
                        forcedHeight = 70,
                        justify = "left",
                        children = {
                            nurture.Box:new(N, {
                                forcedWidth = 70,
                                backgroundColor = { 0.8, 0.5, 0.3, 0.9 },
                                rounding = 5,
                                children = {
                                    nurture.TextLabel:new(N, "IMG", "BodyFont", {
                                        color = { 1, 1, 1, 1 },
                                    })
                                }
                            }),
                            nurture.VBox:new(N, {
                                spacing = 5,
                                forcedWidth = 400,
                                justify = "center",
                                children = {
                                    nurture.Box:new(N, {
                                        forcedHeight = 25,
                                        backgroundColor = { 0.3, 0.3, 0.4, 0.9 },
                                        rounding = 3,
                                        children = {
                                            nurture.TextLabel:new(N, "Card Title 1", "subtitle", {
                                                color = { 1, 1, 1, 1 },
                                            })
                                        }
                                    }),
                                    nurture.Box:new(N, {
                                        forcedHeight = 30,
                                        backgroundColor = { 0.25, 0.25, 0.35, 0.9 },
                                        rounding = 3,
                                        children = {
                                            nurture.TextLabel:new(N, "Description text", "BodyFont", {
                                                color = { 0.8, 0.8, 0.8, 1 },
                                            })
                                        }
                                    })
                                }
                            })
                        }
                    }),
                    nurture.HBox:new(N, {
                        spacing = 10,
                        forcedHeight = 70,
                        justify = "left",
                        children = {
                            nurture.Box:new(N, {
                                forcedWidth = 70,
                                backgroundColor = { 0.3, 0.5, 0.8, 0.9 },
                                rounding = 5,
                                children = {
                                    nurture.TextLabel:new(N, "IMG", "BodyFont", {
                                        color = { 1, 1, 1, 1 },
                                    })
                                }
                            }),
                            nurture.VBox:new(N, {
                                spacing = 5,
                                forcedWidth = 400,
                                justify = "center",
                                children = {
                                    nurture.Box:new(N, {
                                        forcedHeight = 25,
                                        backgroundColor = { 0.3, 0.3, 0.4, 0.9 },
                                        rounding = 3,
                                        children = {
                                            nurture.TextLabel:new(N, "Card Title 2", "subtitle", {
                                                color = { 1, 1, 1, 1 },
                                            })
                                        }
                                    }),
                                    nurture.Box:new(N, {
                                        forcedHeight = 30,
                                        backgroundColor = { 0.25, 0.25, 0.35, 0.9 },
                                        rounding = 3,
                                        children = {
                                            nurture.TextLabel:new(N, "Description text", "BodyFont", {
                                                color = { 0.8, 0.8, 0.8, 1 },
                                            })
                                        }
                                    })
                                }
                            })
                        }
                    })
                }
            })
        }
    })

    contentArea:addChild(sidebar)
    contentArea:addChild(mainContent)

    local footer = nurture.HBox:new(N, {
        spacing = 10,
        forcedHeight = 50,
        justify = "center",
        classname = "footer",
        children = {
            nurture.Box:new(N, {
                forcedWidth = 100,
                backgroundColor = { 0.3, 0.3, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Privacy", "BodyFont", {
                        color = { 0.8, 0.8, 0.8, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 100,
                backgroundColor = { 0.3, 0.3, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Terms", "BodyFont", {
                        color = { 0.8, 0.8, 0.8, 1 },
                    })
                }
            }),
            nurture.Box:new(N, {
                forcedWidth = 100,
                backgroundColor = { 0.3, 0.3, 0.3, 0.8 },
                rounding = 5,
                children = {
                    nurture.TextLabel:new(N, "Help", "BodyFont", {
                        color = { 0.8, 0.8, 0.8, 1 },
                    })
                }
            })
        }
    })

    mainLayout:addChild(header)
    mainLayout:addChild(contentArea)
    mainLayout:addChild(footer)
end

return {
    load = load
}


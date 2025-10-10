### Nurture: A Löve2D Library for UI

> [!CAUTION]
> Although I have tried to made this library as general-purpose as possible, this is still a personal library primary intended to serve me in my projects.

<br>

![img](https://raw.githubusercontent.com/namishh/nurture/refs/heads/main/examples/screenshots/pausemenuanim.png)

<br>

![img](https://raw.githubusercontent.com/namishh/nurture/refs/heads/main/examples/screenshots/hboxvboxcombined.png)

Take a look at the [examples](https://github.com/namishh/nurture/tree/main/examples) directory for some working examples and screenshots.

### List of Implemented Widgets

1. Box
2. Horizontal/Vertical Box
3. Horizontal/Vertical Fraction Box
4. Grid
5. Stack Layout
6. Buttons
7. Progressbars
8. Sliders
9. Text Label
10. Tabs
11. Image/Video
12. Shapes
13. Input Boxes


### Running the Examples

To run a example from the examples directory, simply the example in `main.lua`

```lua
local CURRENT_EXAMPLE = "pausemenuanim"
```

and then run it using

```
love .
```

### Most Basic Setup

To use `nurture` in your project, copy the `nurture` directory to your love2d project. In your own `main.lua`.

```lua
-- main.lua


local nurture = require("nurture")

N = nurture:new()


function love.load()
    N:registerFont('assets/BoldPixels.ttf', 'TitleFont', 24, true)
    -- adds in a box
    nurture.Box:new(N, {
        x = 50,
        y = 50,
        forcedWidth = 200,
        forcedHeight = 100,
        backgroundColor = { 0.2, 0.5, 0.8, 0.9 },
        padding = 10,
        children = {
            nurture.TextLabel:new(N, "Hello World", "TitleFont", {
                color = { 1, 1, 1, 1 },
            })
        }
        })
end

function love.draw()
    -- nurture manages all of its widgets
    N:draw()
end

function love.update()
    -- no need to draw and update each one of them seperately
    N:update()
end

function love.mousepressed(x, y, button)
    N:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    N:mousereleased(x, y, button)
end

```

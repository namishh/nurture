### Nurture: A Löve2D Library for UI

> [!CAUTION]
> This library is in active development and not meant to be used for any serious projects for now.

<br>

![img](https://raw.githubusercontent.com/namishh/nurture/refs/heads/main/examples/screenshots/pausemenuanim.png)

<br>

![img](https://raw.githubusercontent.com/namishh/nurture/refs/heads/main/examples/screenshots/hboxvboxcombined.png)

Take a look at the [examples](https://github.com/namishh/nurture/tree/main/examples) directory for some working examples.

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
    -- no need to draw each one of them seperately
    N:update()
end

function love.mousepressed(x, y, button)
    N:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    N:mousereleased(x, y, button)
end

```

Further documention to be available later.
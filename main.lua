function love.load()

    require "mylib"
    require "farm"
    require "store"
    require "itens"
    require "sprites"

    love.window.setFullscreen(false);
    
    love.graphics.setDefaultFilter = "nearest", "nearest";

    loadItens();
    createFarm(2, 2, 20, 14);
    
    currentTime = 0;

    room = "farm";

end

function love.update(dt)

    if (room == "farm") then
        updateFarm();
    end

end

function love.draw()

    if (room == "farm") then
        drawFarm();
    end

    if (room == "store") then
        drawStore();
    end

end

--//--//--//--//--//--//--//--

function love.keypressed(key, scancode, isrepeat)
    if key == "tab" then
        if (room == "farm") then
            room = "store";
        else
            room = "farm";
        end
    end
 end

function loadItens()

    itensList = {}

    table.insert(itensList, createItem(1, "plant",      1, sprPlanta, false, 1))
    table.insert(itensList, createItem(2, "path",       0, sprCaminho, false, 0))
    table.insert(itensList, createItem(3, "fertilizer", 0, sprAdubo, true, 2))
end

function drawStore()
    local lar = love.graphics.getWidth();
    local alt = love.graphics.getHeight();

    love.graphics.print("Select an item", lar/2, 10);

    local opt = {"plant", "path", "fertilizer"};

    local mousex = love.mouse.getX();
    local mousey = love.mouse.getY();

    local menu = {}
    menu.x = lar/2
    menu.y = alt/2
    menu.w = 120
    menu.h = 40
    
    for i = 1, #opt do
        if inRectangle(mousex, mousey, menu.x - (menu.w / 2), menu.y - (menu.h / 2) + (menu.h * i), menu.w, menu.h) then
            love.graphics.setColor(0, 1, 0, 1);

            if love.mouse.isDown(1) then
                item_selec = itensList[i];
            end
        else
            love.graphics.setColor(1, 1, 1, 1);
        end

        --desenhar botão de opção
        love.graphics.rectangle("line", menu.x - (menu.w / 2), menu.y - (menu.h / 2) + (menu.h * i), menu.w, menu.h);

        --desenhar texto da opção
        love.graphics.setColor(1, 1, 1, 1);
        love.graphics.print(opt[i], lar/2, alt/2 + (i * menu.h));
    end
end

function createItem(_id, _name, _type, _sprite, _plantable, _boost)
    local item = {}
    item.id     = _id
    item.name   = _name
    item.type   = _type
    item.sprite = _sprite
    item.plantable = _plantable
    item.boost  = _boost

    return item;
end

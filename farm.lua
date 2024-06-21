function createFarm(x, y, nw, nh)

    tiles = {}

    local w = love.graphics.getWidth();
    local h = love.graphics.getHeight();

    size = 32;

    plantas = {}
    selecID = 0;

    local id = 0;
    for i = 0, nw - 1 do
        for j = 0, nh - 1 do
            table.insert(tiles, nTile(x * size, y * size, i, j, id));
            id = id + 1;
        end
    end

    silo = 0;

    item = {}
    item.planta = 1
    item.caminho = 2
    
    item_selec  = itensList[1];
    soil_selec  = nil;
    form_selec  = 1;
    cor_selec   = {1, 1, 1, 1};
    boost_selec = 1;
end

function nTile(x, y, i, j, _id)
    local tile = {}
    tile.id     = _id
    tile.x      = x + i * size
    tile.y      = y + j * size

    tile.stage  = 0
    tile.time   = 0

    tile.soil   = nil
    tile.boost  = 1

    tile.form   = 1

    tile.sprTile = sprGrama
    tile.sprItem = nil

    tile.plantable = true

    return tile;
end 

function updateFarm()

    selecX = math.floor(love.mouse.getX() % love.graphics.getWidth() / size);
    selecY = math.floor(love.mouse.getY() % love.graphics.getHeight() / size);  

    for i, v in ipairs(tiles) do

        currentTime = currentTime + 1;

        if (selecX == v.x / size) and (selecY == v.y / size) then   --checar seleção
            selecID = v.id;

            --adcionar item
            if (love.mouse.isDown(1)) and (v.type == nil) and (v.plantable == true) then
                if (item_selec.type == 0) then          --solo
                    v.sprTile = item_selec.sprite;
                    v.plantable = item_selec.plantable;
                    v.boost = item_selec.boost;
                elseif (item_selec.type == 1) and (v.plantable == true) then      --planta
                    v.sprItem = item_selec.sprite;
                    v.plantable = item_selec.plantable;
                end
                v.time = currentTime;
            end

            --remover item
            if (love.mouse.isDown(2)) and ((v.sprTile ~= nil) or (v.sprItem~= nil)) then
                v.sprItem = nil;
                v.sprTile = sprGrama;
                v.stage = 0;
                v.boost = 1;
                v.time = 0;
                v.plantable = true;
                silo = silo + round(v.stage);
            end
        end

        --crescimento das plantas
        if (v.sprItem ~= nil) then
            if (v.stage < 1) then
                v.stage = (v.stage + (currentTime - v.time) / (10000000 / v.boost));
            end
        end
    end
end

function drawFarm()
    --desenhar tiles
    for i, v in ipairs(tiles) do
        love.graphics.draw(v.sprTile, v.x, v.y);
        
        --desenhar itens
        if (v.sprItem ~= nil) then
            love.graphics.draw(v.sprItem, v.x + (size / 2), v.y + (size / 2), 1 - (v.stage), v.stage, v.stage, (size / 2), (size / 2));
        end

        --desenhar contorno no tile selecionado
        if (v.plantable == true) then
            love.graphics.setColor(0, 1, 0, 1);
        else
            love.graphics.setColor(1, 0, 0, 1);
        end
        if (selecX == v.x / size) and (selecY == v.y / size) then
            love.graphics.rectangle("line", v.x, v.y, size, size);
        end
        love.graphics.setColor(1, 1, 1, 1);
    end

    --desenhar objeto selecionado
    love.graphics.draw(item_selec.sprite, 10, 10);
    love.graphics.print(item_selec.name, 10, 10 + size);

end
function input(_key)

    if (love.keyboard.isDown(_key)) then
        return 1
    else
        return 0
    end

end

function sign(n)
    if (n < 0) then
        return -1
    else
        return 1
    end
end

function fract(n)
    return n % 1;
end

function round(n)
    local result = n;

    if (fract(n) < .5) then     --arredondar pra baixo
        result = math.floor(n);
    else                        --arredondar pra cima
        result = math.ceil(n);
    end

    return result;
end

function direction(x1, y1, x2, y2) 
    return math.atan2(y2 - y1, x2 - x1);
end

function inRectangle(px, py, x, y, w, h)    --colisão com retângulo
    if 
    (px >= x) and 
    (px <= x + w) and 
    (py >= y) and 
    (py <= y + h) then
            return true
        else
            return false
    end 
end
function _init_keyboard()
    poke(0x5f2d, 0x1)   -- enable mouse and keyboard
    poke(0x5f30, 0x1)   -- stops p from pausing game, needs to be re-enabled after every p keystroke
end

function _update_keyboard(text)
    if stat(30)==true then
        input=stat(31)
        if input>=" " and input<="z" then
            text=text..input
            if input=="p"then
                poke(0x5f30, 0x1)
            end
        elseif input=="\8" then
            text=sub(text,1,-2)
        end
    end
    return text
end

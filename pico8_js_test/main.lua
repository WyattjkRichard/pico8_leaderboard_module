function _init()

end

function _update()
    data = peek(0x5f80)
end

function _draw()
    cls()
    for i=0, 15 do
        for j=0, 7 do
            print(peek(0x5f80 + i*8 + j), j*16, i*8)
        end
    end
end

-- poke / peek bytes between 0x5f80 and 0x5fff
-- values between 0 and 255

-- to export to webplayer, run 'export mygame.html' in pico-8 console

-- to read/write values in js:
-- var pico8_gpio = new Array(128);
-- pico8_gpio[0] = 10;

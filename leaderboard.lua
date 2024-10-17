-- leaderboard module
-- author: bbread
-- date: 2024-10-17

-- leaderboard init function
-- input: string - seeds the cartdata
-- output: leaderboard - table with the leaderboard data
function _readcartdata(string)
    cartdata(string)

    current_letter = 0;

    leaderboard = {}
    for i = 0, 9 do
        leaderboard[i] = {}
        leaderboard[i].letters = {
            [0] = chr(dget(4*i)+ord('a')), 
            [1] = chr(dget(4*i+1)+ord('a')), 
            [2] = chr(dget(4*i+2)+ord('a'))
        }
        leaderboard[i].score = dget(4*i+3)
    end
    return leaderboard
end

-- updates the leaderboard
-- input: leaderboard - table with the leaderboard data
-- output: none
function _writecartdata(leaderboard)
    for i = 0, 9 do
        dset(4*i, ord(leaderboard[i].letters[0]) - ord('a'))
        dset(4*i + 1, ord(leaderboard[i].letters[1]) - ord('a'))
        dset(4*i + 2, ord(leaderboard[i].letters[2]) - ord('a'))
        dset(4*i + 3, leaderboard[i].score)
    end
end

-- draws the leaderboard
-- input: leaderboard - table with the leaderboard data
-- output: none
function _draw_leaderboard(leaderboard)
    print("leaderboard", 50, 10, 7)
    for i = 0, 9 do
        print(leaderboard[i].letters[0]..leaderboard[i].letters[1]..leaderboard[i].letters[2], 10, 20 + 10*i, 7)
        print(leaderboard[i].score, 50, 20 + 10*i, 7)
    end
end

-- adds the innitials to the leaderboard
-- input: position - the position in the leaderboard
-- output: leaderboard - table with the leaderboard data
function _add_innitials(position)
    if btnp(0) then     -- left
        current_letter = (current_letter - 1) % 3
    elseif btnp(1) then -- right
        current_letter = (current_letter + 1) % 3
    elseif btnp(2) then -- up
        local val = ord(leaderboard[position].letters[current_letter]) + 1
        val -= ord('a')
        val %= 26
        val += ord('a')
        leaderboard[position].letters[current_letter] = chr(val)
    elseif btnp(3) then -- down
        local val = ord(leaderboard[position].letters[current_letter]) - 1
        val -= ord('a')
        val %= 26
        val += ord('a')
        leaderboard[position].letters[current_letter] = chr(val)
    end
    return leaderboard
end

-- adds a new score and returns the position
-- input: score - the score to add
-- output: position - the position in the leaderboard
function _add_score(score)
    for i = 0, 9 do
        if score > leaderboard[i].score then
            for j = 9, i+1, -1 do
                leaderboard[j].letters = leaderboard[j-1].letters
                leaderboard[j].score = leaderboard[j-1].score
            end
            leaderboard[i].letters = {[0] = 'a', [1] = 'a', [2] = 'a'}
            leaderboard[i].score = score
            return i
        end
    end
end
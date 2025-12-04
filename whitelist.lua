local W = {}

--==============WHITELIST START
local whitelist = loadstring(game:HttpGet("https://raw.githubusercontent.com/bladstaz01/git_whitelist_string/refs/heads/main/whitelist_string"))()
--==============WHITELIST END


-- Helper to get current GMT+8 timestamp
local function current_gmt8()
    local utc = os.time(os.date("!*t"))
    return utc + 8 * 3600
end

-- Verify if user is whitelisted and still has credits
function W.verify(username)
    local expiry = whitelist[username]
    if not expiry then
        return false -- not whitelisted
    end

    return current_gmt8() <= expiry
end

function W.getExpiry(username)
    local expiry = whitelist[username]
    return expiry
end

return W

local W = {}
local whitelist = loadstring(game:HttpGet("https://raw.githubusercontent.com/bladstaz01/git_whitelist_string/refs/heads/main/whitelist_string"))()

local function current_gmt8()
	local utc = os.time(os.date("!*t"))
	return utc + 8 * 3600
end

local function format_gmt8(ts)
	if not ts then return nil end

	-- Interpret the epoch as local time without timezone shifting
	local t = os.date("*t", ts)

	-- Reconstruct exact local date/time (preserves your intended GMT+8 input)
	return string.format(
		"%02d/%02d/%04d %02d:%02d:%02d",
		t.month, t.day, t.year, t.hour, t.min, t.sec
	)
end


function W.verify(username)
	local expiry = whitelist[username]
	if not expiry then
		return false
	end
	return current_gmt8() <= expiry
end

function W.getExpiry(username)
	local expiry = whitelist[username]
	if not expiry then
		return nil
	end
	return format_gmt8(expiry)
end

return W

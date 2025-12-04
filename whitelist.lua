local W = {}

local whitelist = loadstring(game:HttpGet("https://raw.githubusercontent.com/bladstaz01/git_whitelist_string/refs/heads/main/whitelist_string"))()

local function current_gmt8()
	local utc = os.time(os.date("!*t"))
	return utc + 8 * 3600
end

local function formatTimestamp(ts)
	local t = os.date("*t", ts)
	return string.format("%04d-%02d-%02d %02:%02d:%02d", t.year, t.month, t.day, t.hour, t.min, t.sec)
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
	return formatTimestamp(expiry)
end

return W

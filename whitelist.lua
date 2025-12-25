local W={}
local whitelist=loadstring(game:HttpGet("https://raw.githubusercontent.com/bladstaz01/git_whitelist_string/refs/heads/main/whitelist_string"))()

local function current_gmt8()
	local utc=os.time(os.date("!*t"))
	return utc+8*3600
end

local function to_exact_string(ts)
	if not ts then return nil end

	-- decode timestamp without applying local timezone shift
	local t=os.date("!*t",ts)

	return string.format(
		"%02d/%02d/%04d %02d:%02d:%02d",
		t.month,t.day,t.year,t.hour,t.min,t.sec
	)
end

function W.verify(username)
	local loweredUsername = string.lower(username)
	local expiry=whitelist[loweredUsername]
	if not expiry then
		return false
	end
	return current_gmt8()<=expiry
end

function W.getExpiry(username)
	local loweredUsername = string.lower(username)
	local expiry=whitelist[loweredUsername]
	if not expiry then
		return nil
	end
	return to_exact_string(expiry)
end

return W

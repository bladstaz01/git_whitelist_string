local W={}
local HttpService=game:GetService("HttpService")
local API_URL="https://script.google.com/macros/s/AKfycbyQodxs8a-o1q40-hwsE8mTdQa0VIoW3ejKESls7Xam5y3Llm9wpC64HkIWZMBFyo1k/exec"
local function current_gmt8()
	local serverUtc=workspace:GetServerTimeNow()
	return serverUtc+8*3600
end
local function to_exact_string(ts)
	if not ts then return nil end
	local t=os.date("!*t",ts)
	return string.format("%02d/%02d/%04d %02d:%02d:%02d",t.month,t.day,t.year,t.hour,t.min,t.sec)
end
local function requestWhitelist(username)
	local req=syn and syn.request or http_request or request
	if not req then
		return nil
	end
	local success,response=pcall(function()
		return req({
			Url=API_URL.."?user="..HttpService:UrlEncode(username),
			Method="GET"
		})
	end)
	if not success or not response or response.StatusCode~=200 or not response.Body then
		return nil
	end
	local ok,decoded=pcall(function()
		return HttpService:JSONDecode(response.Body)
	end)
	if not ok then
		return nil
	end
	return decoded
end
function W.verify(username)
	local result=requestWhitelist(username)
	if not result or not result.success then
		return false
	end
	if not result.whitelisted then
		return false
	end
	if result.expiry then
		return current_gmt8()<=result.expiry
	end
	return true
end
function W.getExpiry(username)
	local result=requestWhitelist(username)
	if not result or not result.success then
		return nil
	end
	if result.expiry then
		return to_exact_string(result.expiry)
	end
	return nil
end
return W

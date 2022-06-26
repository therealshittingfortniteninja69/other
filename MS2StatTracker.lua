if game.PlaceId == 9551640993 then
	local username = game:GetService("Players").LocalPlayer.Name
	local userid = game:GetService("Players").LocalPlayer.UserId
	local icon = "https://www.roblox.com/headshot-thumbnail/image?userId="..userid.."&width=420&height=420&format=png"
	if _G.Player then
	    icon = "https://www.roblox.com/headshot-thumbnail/image?userId="..game.Players[_G.Player].UserId.."&width=420&height=420&format=png"
	end
	local FormatTime = require(game.ReplicatedStorage.ClientModules.Utility.Gui.FormatTime)
	local NewColor = (_G.Color == "" and "fffff") or _G.Color
	local number = 1
	local number2 = 1
	local number3 = 1
	
	if _G.SendNotifications == true then
    	game.StarterGui:SetCore(
               	"SendNotification",
                {
			Title = "MS2 Stats Tracker",
			Text = "Version 1.0.0, Updated and Maintained by PetSimulatorXPlayer#5011",
			Duration = 5
		}
	)
	elseif _G.SendNotifications == false then
        end
	
	function abb(Value)
		local Number
		local Formatted = Value
		while true do
        		Formatted, Number = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        		if (Number == 0) then
            			break
        		end
    		end
    		return Formatted
	end
	
    local plr = game.Players.LocalPlayer
    local OnlyCount = {_G.Player or plr.Name}
    
    local count = 0 
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        for n,b in pairs(OnlyCount) do
            if string.find(v.Name, b) then
                count = v.leaderstats["Eggs"].Value    
            end
        end
    end
    
    local count2 = 0
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        for n,b in pairs(OnlyCount) do
            if string.find(v.Name, b) then
                count2 = v.leaderstats["Rebirths"].Value    
            end
        end
    end
    
    local count3 = 0
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        for n,b in pairs(OnlyCount) do
            if string.find(v.Name, b) then
                count3 = v.leaderstats["Blocks"].Value    
            end
        end
    end
   
    print("MS2 Stats Tracker V1.0.0, Maintained and Updated by PetSimulatorXPlayer#5011")
    
    while wait(_G.Intervals) do
        
        -- Eggs
        count1 = 0
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            for n,b in pairs(OnlyCount) do
                if string.find(v.Name, b) then
                    count1 = v.leaderstats["Eggs"].Value    
                end
            end
        end
        local EggsHatchedPer1 = count1 - count
        count = count + EggsHatchedPer1

		
		-- Rebirths
		local count22 = 0
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            for n,b in pairs(OnlyCount) do
                if string.find(v.Name, b) then
                    count22 = v.leaderstats["Rebirths"].Value    
                end
            end
        end
		local RebirthsPer1 = count22 - count2
		count2 = count2 + RebirthsPer1
		
		-- Blocks
		local count33 = 0
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            for n,b in pairs(OnlyCount) do
                if string.find(v.Name, b) then
                    count33 = v.leaderstats["Blocks"].Value    
                end
            end
        end
		local BlocksPer1 = count33 - count3
		count3 = count3 + BlocksPer1
		
        local Webhooksss = _G.Webhookss
        local OSTime = os.time();
        local Time = os.date('!*t', OSTime);
        timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
        local formattedtime
        if _G.Intervals <= 60 then
            formattedtime = FormatTime.shortSeconds(_G.Intervals)
        else
            formattedtime = FormatTime.long(_G.Intervals)
        end
        local msg = {
            ["embeds"] = {
                {
                    ["title"] = _G.Player or username .. "'s MS2 Stat Data",
                    ["color"] = tonumber(tostring("0x" .. NewColor)),
                    ["description"] = "Some of these stats wont be exact. Some are just estimates",
                    ["thumbnail"] = {
                        ["url"] = icon
                    },
                    ["fields"] = {},
                    ["footer"] = {
                        ["text"] = "Updates every " .. formattedtime .. " | Mining Simulator 2"
                    },
                    ['timestamp'] = timestamp,
                }
            }
        }
        if _G.EggCount == true then
            local EggsCountEmbed = {
            	["name"] = "Egg Count Data",
            	["value"] = abb(count1) .. " Eggs have been hatched! | *+" .. abb(EggsHatchedPer1) .. " in "..formattedtime.."*",
            	["inline"] = false
        	    }
            	table.insert(msg["embeds"][1]["fields"], EggsCountEmbed)
        end
	    if _G.RebirthCount == true then
	        local RebirthsCountEmbed = {
	            ["name"] = "Rebirth Count Data",
				["value"] = abb(count22) .. " Rebirths have been counted! | *+" .. abb(RebirthsPer1) .. " in "..formattedtime.."*",
				["inline"] = false
	            }
	            table.insert(msg["embeds"][1]["fields"], RebirthsCountEmbed)
	    end
	    if _G.BlocksCount == true then
	        local BlocksCountEmbed = {
	            ["name"] = "Block Count Data",
				["value"] = abb(count33) .. " Blocks have been mined! | *+" .. abb(BlocksPer1) .. " in "..formattedtime.."*",
				["inline"] = false
	            }
	            table.insert(msg["embeds"][1]["fields"], BlocksCountEmbed)
	    end
        request = http_request or request or HttpPost or syn.request
        request({Url = Webhooksss, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game.HttpService:JSONEncode(msg)})
    end
end

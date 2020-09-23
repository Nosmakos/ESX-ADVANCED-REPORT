ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = identity['name'],	
			firstname = identity['firstname'],
			lastname = identity['lastname']
	
		}
	else
		return nil 
	end
end

RegisterServerEvent('esx_advanced_report:sendAvailableStaffReport') 
AddEventHandler('esx_advanced_report:sendAvailableStaffReport', function(online, reportText)

	if Config.StaffGroupList[getGroup(online)] ~= nil then

		local _source = source
		local name = getIdentity(_source)

		fal = name.firstname .. " " .. name.lastname
	
		text = table.concat(reportText,",")
	
		TriggerClientEvent('chat:addMessage', online, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255,69,0, 0.7); border-radius: 3px;">{0}: {1}</div>',
			args = { Config.ReportPrefix.." - [" .. name.name .. " ID: " .. _source .. "] - [" .. fal.. "] ", text:gsub(",", " ") }
		})

	end

end)

-- load and set users group
function getGroup(source)
	local _source = source
	local player = ESX.GetPlayerFromId(_source)

	if player ~= nil then
        local playerGroup = player.getGroup()

		if playerGroup ~= nil then 
			return playerGroup
		else
			return "user"
		end
	else
		return "user"
	end
end

local reportCooldown = false

RegisterCommand('report', function(source, args) 
  CancelEvent()
  if args and #args < 1 then
 
    TriggerEvent('chat:addMessage', {color = { Config.R, Config.G, Config.B},multiline = true,args = {Config.Prefix, " " .. Config.ReportArgsWarning}})
    return
  end

  if not reportCooldown then
    reportCooldown = true
    TriggerEvent('chat:addMessage', {color = { Config.R, Config.G, Config.B},multiline = true,args = {Config.ReportSent, " "}})

    for _,id in pairs(GetActivePlayers()) do

      local ped = GetPlayerPed(id)
      local ids = GetPlayerServerId(NetworkGetEntityOwner(ped))

      TriggerServerEvent('esx_advanced_report:sendAvailableStaffReport', ids, args)
    end

    Citizen.Wait(Config.ReportCooldown)
    reportCooldown = false
  else
    TriggerEvent('chat:addMessage', {color = { Config.R, Config.G, Config.B},multiline = true,args = {Config.Prefix, " " .. Config.ReportCooldownMessage}})
  end
  
end, false)
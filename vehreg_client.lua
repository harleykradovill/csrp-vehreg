json = require("json")

-- COMMANDS:

RegisterCommand('vehreg', function()
    TriggerServerEvent('fetchIncidentDetails')
end, false)

-- UNIVERSAL FUNCTION TO DRAW NOTIFICATION

function drawNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, true)
end

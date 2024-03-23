json = require("json")

RegisterCommand('vehreg', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    if not IsPedInAnyVehicle(PlayerPedId(), false) or vehicle == 0 then
        drawNotification("Error: Not in Vehicle")
        return
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    local make = GetLabelText(GetMakeNameFromVehicleModel(GetEntityModel(vehicle)))
    local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    local color = GetVehiclePrimaryColorText(vehicle)

    -- print("Sending vehicle registration request to server...")
    TriggerServerEvent('sendVehicleRegistration', plate, make, model, color)
end, false)

function GetVehiclePrimaryColorText(vehicle)
    local primaryColorID, _ = GetVehicleColours(vehicle)
    local colorJson = LoadResourceFile(GetCurrentResourceName(), "vehicle-colors.json")
    if colorJson then
        local colors = json.decode(colorJson)
        for _, color in ipairs(colors) do
            if color.ID == tostring(primaryColorID) then
                return color.Description
            end
        end
        return "Unknown"
    else
        print("Error: vehicle-colors.json not found or unable to read.")
        return "Unknown"
    end
end

RegisterNetEvent("showVehicleRegistrationNotification")
AddEventHandler("showVehicleRegistrationNotification", function(message)
    drawNotification(message)
end)


-- UNIVERSAL FUNCTION TO DRAW NOTIFICATION

function drawNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, true)
end

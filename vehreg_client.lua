json = require("json")

RegisterCommand('vehreg', function(source, args, rawCommand)

   if #args < 1 then
        print("Usage: /vehreg <SSN>")
        return
    end
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local ssn = args[1]
    local make = GetLabelText(GetMakeNameFromVehicleModel(GetEntityModel(vehicle)))
    local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    local color = GetVehiclePrimaryColorText(vehicle)

    print("Sending vehicle registration request to server...")
    TriggerServerEvent('sendVehicleRegistration', plate, ssn, make, model, color)
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
        return "Unknown Color"
    else
        print("Error: vehicle-colors.json not found or unable to read.")
        return "Unknown Color"
    end
end

local cadURL = '[redacted]'

RegisterServerEvent('sendVehicleRegistration')
AddEventHandler('sendVehicleRegistration', function(plate, make, model, color)
    local playerSource = source
    local playerIdentifiers = GetPlayerIdentifiers(playerSource)
    local discordId = nil

    for _, identifier in pairs(playerIdentifiers) do
        if string.match(identifier, "discord:") then
            discordId = string.sub(identifier, 9)
            break
        end
    end

    if discordId then
        local vehicleProps = {
            plate = plate,
            discordid = discordId,
	    make = make,
	    model = model,
	    color = color
        }

        print(json.encode(vehicleProps))

        -- print("Sending vehicle registration request to website API...")
        PerformHttpRequest(cadURL, function(err, text, headers)
            if err == 200 then
                -- print("Vehicle registration request sent successfully.")
		TriggerClientEvent('showVehicleRegistrationNotification', playerSource, text)
            else
                -- print("Error: HTTP request failed. Status code: " .. tostring(err))
		TriggerClientEvent('showVehicleRegistrationNotification', playerSource, "Error: Vehicle registration failed due to API.")
            end
        end, 'POST', json.encode(vehicleProps), { ["Content-Type"] = 'application/json' })
    else
        -- print("Error: Discord ID not found for the player.")
    end
end)

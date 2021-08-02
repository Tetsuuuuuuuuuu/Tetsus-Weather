
local weatherOrder = {
    {name = "CLEAR",        rainLevel=0.0, minutes=15},
    {name = "EXTRASUNNY",   rainLevel=0.0, minutes=30},
    {name = "CLOUDS",       rainLevel=0.0, minutes=10},
    {name = "RAIN",         rainLevel=0.3, minutes=3},
    {name = "RAIN",         rainLevel=0.5, minutes=3},
    {name = "RAIN",         rainLevel=0.7, minutes=3},
    {name = "RAIN",         rainLevel=0.7, minutes=5},
    {name = "THUNDER",      rainLevel=1.0, minutes=10},
    {name = "RAIN",         rainLevel=0.2, minutes=2},
    {name = "CLEARING",     rainLevel=0.1, minutes=5},
    {name = "CLEARING",     rainLevel=0.0, minutes=5},
    {name = "FOGGY",        rainLevel=0.0, minutes=2},
    {name = "CLOUDS",       rainLevel=0.0, minutes=30},
    {name = "CLEAR",        rainLevel=0.0, minutes=30},
    {name = "EXTRASUNNY",   rainLevel=0.0, minutes=60},
}

local curWeather
local rainyLevel

Citizen.CreateThread(function()
    while true do
        for i,v in ipairs(weatherOrder) do
           curWeather = v.name
           rainyLevel = v.rainLevel
           TriggerClientEvent('tetsusweather:recieveWeather', -1, curWeather, rainyLevel)
           Citizen.Wait(v.minutes * 60000)
           print("Weather Type Changing to ^3" .. weatherOrder[i+1].name .. "^0")
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent('tetsusweather:requestWeather')
AddEventHandler('tetsusweather:requestWeather', function()
    TriggerClientEvent('tetsusweather:recieveWeather', source, curWeather, rainyLevel)
end)

function getOSTime()
    local temporaryTimeTable = os.date("*t")
    local temp_hour = temporaryTimeTable.hour
    local temp_minute = temporaryTimeTable.min
    return temp_hour, temp_minute
end

RegisterNetEvent('tetsusweather:requestTime')
AddEventHandler('tetsusweather:requestTime', function()
    local h, m = getOSTime()
    TriggerClientEvent('tetsusweather:recieveTime', source, h, m)
end)

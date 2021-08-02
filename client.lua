
TriggerServerEvent("tetsusweather:requestWeather")
TriggerServerEvent("tetsusweather:requestTime")
SetMillisecondsPerGameMinute(60000)

RegisterNetEvent('tetsusweather:recieveWeather')
AddEventHandler('tetsusweather:recieveWeather', function(weather, rainlevel)
    Citizen.CreateThread(function()
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypeOverTime(weather, 10.0)
        Citizen.Wait(10000)
        SetWeatherTypePersist(weather)
        SetWeatherTypeNow(weather)
        SetWeatherTypeNowPersist(weather)
        SetRainLevel(rainlevel)
    end)
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("tetsusweather:requestTime")
        Citizen.Wait(30000)
    end
end)

RegisterNetEvent('tetsusweather:recieveTime')
AddEventHandler('tetsusweather:recieveTime', function(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
end)


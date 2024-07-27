local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local API_KEY = "d468ec1394224f1698e05515242407"
local CACHE_DURATION = 10 * 60 -- cache duration
local CACHE = {
    lastUpdated = 0,
    data = nil
}
local CITY = "Tokyo" -- default city (being my own)

local function getCurrentLocalHour()
    return tonumber(os.date("%H"))
end

local function getPlayerInfo()
    local player = Players.LocalPlayer
    return player and player.Name or "Player", player and player.DisplayName or "Player"
end

local function fetchWeatherData()
    local url = "http://api.weatherapi.com/v1/current.json?key=" .. API_KEY .. "&q=" .. CITY .. "&aqi=no"
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)

    if success then
        local success, data = pcall(function()
            return HttpService:JSONDecode(response)
        end)

        if success and data and data.current then
            return data.current
        else
            warn("Failed to decode weather data or missing current data.")
            return nil
        end
    else
        warn("Failed to retrieve weather data.")
        return nil
    end
end

local function getWeather()
    local currentTime = tick()

    if CACHE.data and (currentTime - CACHE.lastUpdated) < CACHE_DURATION then
        return CACHE.data
    end

    local weatherData = fetchWeatherData()
    if weatherData then
        CACHE.data = weatherData
        CACHE.lastUpdated = currentTime
        return weatherData
    else
        return {
            condition = { text = "Weather data unavailable" },
            temp_c = "N/A"
        }
    end
end

local function getWeatherAdvice(condition)
    local weatherAdvice = {
        ["Sunny"] = "It's sunny and bright outside. Don't forget your sunglasses!",
        ["Clear"] = "It's clear outside. Perfect for a day out!",
        ["Partly cloudy"] = "It's partly cloudy today, enjoy the mix of sun and shade.",
        ["Cloudy"] = "Expect overcast skies today, perfect for staying indoors.",
        ["Overcast"] = "It's completely overcast. No sun today.",
        ["Mist"] = "There's a light mist. It might feel a bit damp.",
        ["Patchy rain possible"] = "There might be some patchy rain. Keep an umbrella handy just in case.",
        ["Patchy snow possible"] = "There might be some patchy snow. Dress warmly!",
        ["Patchy sleet possible"] = "There might be some patchy sleet. Drive carefully!",
        ["Patchy freezing drizzle possible"] = "Patchy freezing drizzle might occur. Be cautious of slippery surfaces.",
        ["Thundery outbreaks possible"] = "There might be thundery outbreaks. Stay indoors if you hear thunder.",
        ["Blowing snow"] = "Blowing snow might reduce visibility. Drive carefully.",
        ["Blizzard"] = "A blizzard is occurring. Stay indoors and stay warm!",
        ["Fog"] = "It's foggy outside. Drive slowly and keep your lights on.",
        ["Freezing fog"] = "Freezing fog is present. Be cautious of slippery surfaces.",
        ["Patchy light drizzle"] = "There's patchy light drizzle. A raincoat might be useful.",
        ["Light drizzle"] = "There's light drizzle. A raincoat might be useful.",
        ["Freezing drizzle"] = "Freezing drizzle is falling. Roads will be icy.",
        ["Heavy freezing drizzle"] = "Heavy freezing drizzle is falling. Avoid travel if possible.",
        ["Patchy light rain"] = "Patchy light rain today. Keep an umbrella handy.",
        ["Light rain"] = "There's light rain. A gentle shower.",
        ["Moderate rain at times"] = "Moderate rain at times. An umbrella will be useful.",
        ["Moderate rain"] = "It's raining moderately. Don't forget your umbrella!",
        ["Heavy rain at times"] = "Heavy rain at times. Be prepared for potential flooding.",
        ["Heavy rain"] = "Heavy rain is falling. Be prepared for potential flooding.",
        ["Light freezing rain"] = "Light freezing rain is falling. Roads will be icy.",
        ["Moderate or heavy freezing rain"] = "Freezing rain is falling. Roads will be icy.",
        ["Light sleet"] = "Light sleet is falling. Drive carefully!",
        ["Moderate or heavy sleet"] = "Moderate or heavy sleet is falling. Be cautious of slippery surfaces.",
        ["Patchy light snow"] = "Patchy light snow. Time to build a snowman!",
        ["Light snow"] = "It's snowing lightly. Enjoy the winter wonderland!",
        ["Patchy moderate snow"] = "Patchy moderate snow is falling. Dress warmly!",
        ["Moderate snow"] = "It's snowing moderately. Enjoy the winter scenery!",
        ["Patchy heavy snow"] = "Patchy heavy snow is falling. Be prepared for deeper snow.",
        ["Heavy snow"] = "Heavy snow is falling. Stay indoors and stay warm!",
        ["Ice pellets"] = "Ice pellets are falling. Be cautious of slippery surfaces.",
        ["Light rain shower"] = "There's a light rain shower. Keep an umbrella handy.",
        ["Moderate or heavy rain shower"] = "Moderate or heavy rain showers are expected. Don't forget your umbrella!",
        ["Torrential rain shower"] = "Torrential rain showers are occurring. Be prepared for potential flooding.",
        ["Light sleet showers"] = "Light sleet showers are falling. Drive carefully!",
        ["Moderate or heavy sleet showers"] = "Moderate or heavy sleet showers are expected. Be cautious of slippery surfaces.",
        ["Light snow showers"] = "Light snow showers are falling. Enjoy the winter wonderland!",
        ["Moderate or heavy snow showers"] = "Moderate or heavy snow showers are expected. Dress warmly!",
        ["Light showers of ice pellets"] = "Light showers of ice pellets are falling. Be cautious of slippery surfaces.",
        ["Moderate or heavy showers of ice pellets"] = "Moderate or heavy showers of ice pellets are expected. Avoid travel if possible.",
        ["Patchy light rain with thunder"] = "Patchy light rain with thunder is possible. Stay indoors if you hear thunder.",
        ["Moderate or heavy rain with thunder"] = "Moderate or heavy rain with thunder is expected. Take precautions.",
        ["Patchy light snow with thunder"] = "Patchy light snow with thunder is possible. Stay indoors if you hear thunder.",
        ["Moderate or heavy snow with thunder"] = "Moderate or heavy snow with thunder is expected. Take precautions."
    }

    return weatherAdvice[condition] or "Weather condition unknown. Stay prepared for anything!"
end

local function getRandomElement(list)
    return list[math.random(1, #list)]
end

local function getRandomCategory()
    local categories = {"quote", "compliment", "fun_fact"}
    return getRandomElement(categories)
end

local function getMessage(category)
    local funFacts = {
        "Does anyone even read these?",
        "Imagine skidding in a little kids game, pathetic.",
        "This script will have over 10k lines, when will the suffering end?",
        "I'm a hobbyist, not a sociopath. I just don't have time for socializing.",
        "Go make some friends, and I don't mean the DC bots!",
        "Go outside? HELL NO!",
        "I didn't come this far only to come this far.",
        "Your estimated wait time is 1.5(9)",
        "Look how far you've come.",
        "My accuracy is top-notch, amirite?",
        "Males... females... if there's a hole, there's a way.",
        "My builder loader still doesn't work. Yes, I am venting, deal with it.",
        "Live for today and let tomorrow come later.",
        "Why do you even play this game? KAH died 8 years ago...",
        "Did you know there's a 1 in 8 billion chance you're reading this?",
        "Boom Headshot!",
    }

    local quotes = {
        "Time unfolds as a melody, with each note echoing the beauty of the moment and the transient dance of life.",
        "Criticism, like rain, may dampen the spirit; yet, from such showers, the soul's garden blooms even brighter.",
        "I want my impact to be legendary.",
        "When you go out, go out with a bang, anything you do.",
        "goog",
        "Every moment is a fresh beginning.",
        "The only way to do great work is to love what you do.",
        "Success is not the key to happiness. Happiness is the key to success.",
        "Believe you can and you're halfway there.",
        "Your only limit is your mind.",
        "The future belongs to those who believe in the beauty of their dreams.",
        "Do not wait to strike till the iron is hot, but make it hot by striking.",
        "Every day may not be good, but there's something good in every day.",
        "Success is not final, failure is not fatal: It is the courage to continue that counts.",
        "The harder you work for something, the greater you'll feel when you achieve it.",
        "Dream it. Believe it. Build it.",
        "Success is not how high you have climbed, but how you make a positive difference to the world.",
        "Opportunities don't happen. You create them.",
        "The best way to predict the future is to invent it.",
        "Strive not to be a success, but rather to be of value.",
    }

    local compliments = {
        "You should be proud of yourself, you've come a long way.",
        "You have a remarkable ability to brighten any room.",
        "Your creativity knows no bounds.",
        "You approach challenges with admirable resilience.",
        "Your kindness leaves a lasting impression.",
        "You have a knack for making people feel valued.",
        "Your dedication to your craft is truly inspiring.",
        "You have a unique way of solving problems.",
        "Your positive energy is contagious.",
        "Your attention to detail is unparalleled.",
        "You have a unique way of solving problems.",
        "Your enthusiasm is infectious.",
        "You have a gift for making people feel special.",
        "Your ability to stay calm under pressure is impressive.",
        "You are a source of inspiration to those around you.",
    }

    if category == "quote" then
        return "QOTD <-> " .. getRandomElement(quotes)
    elseif category == "compliment" then
        return "COTD <-> " .. getRandomElement(compliments)
    elseif category == "fun_fact" then
        return "FOTD <-> " .. getRandomElement(funFacts)
    end
end

local function getGreeting()
    local currentHour = getCurrentLocalHour()
    local username, displayName = getPlayerInfo()

    local greeting
    if currentHour >= 5 and currentHour < 12 then
        greeting = "Morning"
    elseif currentHour >= 12 and currentHour < 17 then
        greeting = "Afternoon"
    else
        greeting = "Night"
    end

    local weather = getWeather()
    local weatherCondition = weather.condition.text
    local weatherTemp = weather.temp_c
    local weatherAdvice = getWeatherAdvice(weatherCondition)

    local messageCategory = getRandomCategory()
    local dailyMessage = getMessage(messageCategory)

    return string.format(
        "%s, %s {AKA: %s}\n%s\nCurrent Weather: %s, %s°C. %s\n%s",
        greeting,
        username,
        displayName,
        dailyMessage,
        weatherCondition,
        weatherTemp,
        weatherAdvice,
        "game.Players:Chat('h \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[Femware]\nFemware Has Been Loaded By '..game.Players.LocalPlayer.DisplayName)"
    )
end

local function say(real)
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(real, "All")
end

local function greet()
    local greetingMessage = getGreeting()
    say(greetingMessage)
end

greet()

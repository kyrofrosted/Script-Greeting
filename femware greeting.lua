local HttpService = game:GetService("HttpService") -- uwu, getting the http service
local Players = game:GetService("Players") -- nyah, getting the players service
local ReplicatedStorage = game:GetService("ReplicatedStorage") -- ooh, getting the replicated storage

local API_KEY = "d468ec1394224f1698e05515242407" -- rawr, this is the api key
local CACHE_DURATION = 10 * 60 -- this is how long we'll keep the cache, nya
local CACHE = { -- the cache data, uwu
    lastUpdated = 0, -- when was the cache last updated
    data = nil -- the cached weather data
}
local CITY = "Tokyo" -- the city we wanna get weather for, uwu

local function getCurrentLocalHour() -- get the current local hour
    return tonumber(os.date("%H")) -- convert it to a number, rawr
end

local function getPlayerInfo() -- get info about the local player, nya
    local player = Players.LocalPlayer -- find the local player
    return player and player.Name or "Player", player and player.DisplayName or "Player" -- return their name and display name, uwu
end

local function fetchWeatherData() -- fetch the weather data from the api
       local url = game:HttpGet("http://api.weatherapi.com/v1/current.json?key=" .. API_KEY .. "&q=" .. CITY .. "&aqi=no")
            return HttpService:JSONDecode(url) -- decode the json, uwu
end

local function getWeather() -- get the weather data, uwu
    local currentTime = tick() -- get the current time, rawr

    if CACHE.data and (currentTime - CACHE.lastUpdated) < CACHE_DURATION then -- if the cache is still valid
        return CACHE.data -- return the cached data, nya
    end

    local weatherData = fetchWeatherData() -- fetch new weather data, uwu
    if weatherData then -- if we got new data
        CACHE.data = weatherData -- update the cache, rawr
        CACHE.lastUpdated = currentTime -- update the last updated time, nya
        return weatherData -- return the new data, uwu
    else
        return { -- if we didn't get data, return this
            condition = { text = "Weather data unavailable" }, -- no weather data, rawr
            temp_c = "N/A" -- no temperature, nya
        }
    end
end

local function getWeatherAdvice(condition) -- get advice based on the weather condition, uwu
    local weatherAdvice = { -- all the different weather advice, nya
        ["Sunny"] = "it's sunny and bright outside. don't forget your sunglasses!",
        ["Clear"] = "it's clear outside. perfect for a day out!",
        ["Partly cloudy"] = "it's partly cloudy today, enjoy the mix of sun and shade.",
        ["Cloudy"] = "expect overcast skies today, perfect for staying indoors.",
        ["Overcast"] = "it's completely overcast. no sun today.",
        ["Mist"] = "there's a light mist. it might feel a bit damp.",
        ["Patchy rain possible"] = "there might be some patchy rain. keep an umbrella handy just in case.",
        ["Patchy snow possible"] = "there might be some patchy snow. dress warmly!",
        ["Patchy sleet possible"] = "there might be some patchy sleet. drive carefully!",
        ["Patchy freezing drizzle possible"] = "patchy freezing drizzle might occur. be cautious of slippery surfaces.",
        ["Thundery outbreaks possible"] = "there might be thundery outbreaks. stay indoors if you hear thunder.",
        ["Blowing snow"] = "blowing snow might reduce visibility. drive carefully.",
        ["Blizzard"] = "a blizzard is occurring. stay indoors and stay warm!",
        ["Fog"] = "it's foggy outside. drive slowly and keep your lights on.",
        ["Freezing fog"] = "freezing fog is present. be cautious of slippery surfaces.",
        ["Patchy light drizzle"] = "there's patchy light drizzle. a raincoat might be useful.",
        ["Light drizzle"] = "there's light drizzle. a raincoat might be useful.",
        ["Freezing drizzle"] = "freezing drizzle is falling. roads will be icy.",
        ["Heavy freezing drizzle"] = "heavy freezing drizzle is falling. avoid travel if possible.",
        ["Patchy light rain"] = "patchy light rain today. keep an umbrella handy.",
        ["Light rain"] = "there's light rain. a gentle shower.",
        ["Moderate rain at times"] = "moderate rain at times. an umbrella will be useful.",
        ["Moderate rain"] = "it's raining moderately. don't forget your umbrella!",
        ["Heavy rain at times"] = "heavy rain at times. be prepared for potential flooding.",
        ["Heavy rain"] = "heavy rain is falling. be prepared for potential flooding.",
        ["Light freezing rain"] = "light freezing rain is falling. roads will be icy.",
        ["Moderate or heavy freezing rain"] = "freezing rain is falling. roads will be icy.",
        ["Light sleet"] = "light sleet is falling. drive carefully!",
        ["Moderate or heavy sleet"] = "moderate or heavy sleet is falling. be cautious of slippery surfaces.",
        ["Patchy light snow"] = "patchy light snow. time to build a snowman!",
        ["Light snow"] = "it's snowing lightly. enjoy the winter wonderland!",
        ["Patchy moderate snow"] = "patchy moderate snow is falling. dress warmly!",
        ["Moderate snow"] = "it's snowing moderately. enjoy the winter scenery!",
        ["Patchy heavy snow"] = "patchy heavy snow is falling. be prepared for deeper snow.",
        ["Heavy snow"] = "heavy snow is falling. stay indoors and stay warm!",
        ["Ice pellets"] = "ice pellets are falling. be cautious of slippery surfaces.",
        ["Light rain shower"] = "there's a light rain shower. keep an umbrella handy.",
        ["Moderate or heavy rain shower"] = "moderate or heavy rain showers are expected. don't forget your umbrella!",
        ["Torrential rain shower"] = "torrential rain showers are occurring. be prepared for potential flooding.",
        ["Light sleet showers"] = "light sleet showers are falling. drive carefully!",
        ["Moderate or heavy sleet showers"] = "moderate or heavy sleet showers are expected. be cautious of slippery surfaces.",
        ["Light snow showers"] = "light snow showers are falling. enjoy the winter wonderland!",
        ["Moderate or heavy snow showers"] = "moderate or heavy snow showers are expected. dress warmly!",
        ["Light showers of ice pellets"] = "light showers of ice pellets are falling. be cautious of slippery surfaces.",
        ["Moderate or heavy showers of ice pellets"] = "moderate or heavy showers of ice pellets are expected. avoid travel if possible.",
        ["Patchy light rain with thunder"] = "patchy light rain with thunder is possible. stay indoors if you hear thunder.",
        ["Moderate or heavy rain with thunder"] = "moderate or heavy rain with thunder is expected. take precautions.",
        ["Patchy light snow with thunder"] = "patchy light snow with thunder is possible. stay indoors if you hear thunder.",
        ["Moderate or heavy snow with thunder"] = "moderate or heavy snow with thunder is expected. take precautions."
    }

    return weatherAdvice[condition] or "weather condition unknown. stay prepared for anything!" -- if no advice, give a default one, nya
end

local function getRandomElement(list) -- get a random element from a list, rawr
    return list[math.random(1, #list)] -- pick a random element, nya
end

local function getMessage(category) -- get a fun message based on the category, uwu
    local funFacts = { -- all the fun facts, nya
        "[Fun Fact]: does anyone even read these?",
        "[Fun Fact]: imagine skidding in a little kids game, pathetic.",
        "[Fun Fact]: this script will have over 10k lines, when will the suffering end?",
        "[Fun Fact]: i'm a hobbyist, not a sociopath. i just don't have time for socializing.",
        "[Fun Fact]: go make some friends, and i don't mean the dc bots!",
        "[Fun Fact]: go outside? hell no!",
        "[Fun Fact]: i didn't come this far only to come this far.",
        "[Fun Fact]: your estimated wait time is 1.5(9)",
        "[Fun Fact]: look how far you've come.",
        "[Fun Fact]: my accuracy is top-notch, amirite?",
        "[Fun Fact]: males... females... if there's a hole, there's a way.",
        "[Fun Fact]: my friends wouldn't like me telling you this, but... i'm not the best at math.",
        "[Fun Fact]: who needs a life when you have code?",
        "[Fun Fact]: some people think this is impressive. is it though?",
        "[Fun Fact]: why spend time with humans when you can code with robots?",
        "[Fun Fact]: i hope you find the weather helpful, otherwise, why are you here?",
        "[Fun Fact]: #SKIDNATION on top...",
        "[Fun Fact]: did you know cxo likes men?",
        "[Fun Fact]: did you know pav is a groomer?"
    }
    local advice = { -- all the advice messages, nya
        "[Advice]: check the code thoroughly before running.",
        "[Advice]: always backup your work.",
        "[Advice]: keep your code clean and well-organized.",
        "[Advice]: test your code in small increments.",
        "[Advice]: make use of comments to explain your logic.",
        "[Advice]: stay hydrated and take breaks.",
        "[Advice]: don't forget to handle exceptions.",
        "[Advice]: keep learning and improving.",
        "[Advice]: collaborate with others to gain new insights.",
        "[Advice]: review your code periodically to catch any issues."
    }

    if category == "funfact" then
        return getRandomElement(funFacts) -- return a fun fact, rawr
    elseif category == "advice" then
        return getRandomElement(advice) -- return a piece of advice, nya
    else
        return "unknown category. try 'funfact' or 'advice'." -- unknown category, uwu
    end
end

local function getGreeting() -- get a time-based greeting for the player, uwu
    local currentHour = getCurrentLocalHour() -- get the current hour, rawr
    local username, displayName = getPlayerInfo() -- get the player's info, nya

    local greeting -- the greeting message, uwu
    if currentHour >= 5 and currentHour < 12 then
        greeting = "[Femware] Morning" -- good morning, nya
    elseif currentHour >= 12 and currentHour < 17 then
        greeting = "[Femware] Afternoon" -- good afternoon, rawr
    else
        greeting = "[Femware] Night" -- good night, uwu
    end

    return greeting .. ", " .. username .. " (AKA: " .. displayName .. ")" -- return the greeting message, nya
end

local function say(real) -- send a message to the chat, uwu
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(real, "All") -- send the message, rawr
end

local function displayWeatherInfo() -- display the weather information to the player, nya
    local weather = getWeather() -- get the weather data, rawr
    local condition = weather.current.condition.text -- get the condition, uwu
    local tempC = weather.current.temp_c -- get the temperature in celsius, nya

    local advice = getWeatherAdvice(condition) -- get advice based on the weather condition, uwu
    local message = "[Femware] Weather in " .. CITY .. ": " .. condition .. ", " .. tempC .. "°C. " -- create a simple message, rawr

    say(message) -- send the message to the chat, nya
end

local function main() -- the main function, uwu
    local greeting = getGreeting() -- get the greeting, rawr
    
    -- Randomly choose between displaying weather info, a fun fact, or advice
    local randomChoice = math.random(1, 3)
    
    if randomChoice == 1 then
        local weatherInfo = displayWeatherInfo() -- get the weather information, nya
        say(weatherInfo) -- send the weather information to the chat, rawr
    elseif randomChoice == 2 then
        local funfact = getMessage("funfact") -- get a fun fact, uwu
        say(funfact) -- send a fun fact to the chat, nya
    elseif randomChoice == 3 then
        local advice = getMessage("advice") -- get advice, uwu
        say(advice) -- send a piece of advice to the chat, rawr
    end
    
    say(greeting) -- send the greeting to the chat, rawr
end

main()

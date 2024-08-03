# Greeting Script with Weather and Daily Messages

## Overview

This project is a Lua script for Roblox games that provides a personalized greeting message to the player (ONLY works in Kohls Admin House [https://www.roblox.com/games/112420803/Kohls-Admin-House-NBC-Updated]). The greeting includes the current weather in a specified city, a daily message (quote, compliment, or fun fact), and advice based on the weather condition. The script utilizes the Weather API to fetch real-time weather data and delivers a unique and engaging experience for players.

## Features

- **Personalized Greetings**: The script greets the player based on the time of day (Morning, Afternoon, Night).
- **Weather Integration**: Fetches current weather data for a specified city using the Weather API.
- **Daily Messages**: Provides a random daily message, which can be a quote, compliment, or fun fact.
- **Weather Advice**: Offers advice based on the current weather condition.
- **Caching Mechanism**: Utilizes a caching mechanism to avoid frequent API calls and improve performance.

## Script Details

### Main Functions

- `getCurrentLocalHour()`: Returns the current hour in the local time.
- `getPlayerInfo()`: Retrieves the player's username and display name.
- `fetchWeatherData()`: Fetches current weather data from the Weather API.
- `getWeather()`: Manages the weather data cache and returns the current weather data.
- `getWeatherAdvice(condition)`: Provides advice based on the weather condition.
- `getRandomElement(list)`: Returns a random element from a given list.
- `getRandomCategory()`: Returns a random category (quote, compliment, fun fact).
- `getMessage(category)`: Returns a message based on the specified category.
- `getGreeting()`: Generates the greeting message including time-based greeting, weather information, daily message, and weather advice.
- `say(real)`: Sends a message to the game's chat system.
- `greet()`: Combines all functions to create and send the greeting message.

### Configuration

- `API_KEY`: Your Weather API key.
- `CACHE_DURATION`: Duration for caching the weather data (in seconds).
- `CITY`: The default city for fetching weather data.

## Usage

1. **Set up the script**: Copy the provided Lua script into your Roblox game.
2. **Configure the API Key and City**: Replace `API_KEY` with your Weather API key and `CITY` with your desired city.
3. **Run the Script**: Execute the script in your game. The greeting message will be displayed to the player, including personalized greetings, weather information, daily message, and advice based on the weather condition.

## Example Output

Morning, Player (AKA: DisplayName) / QOTD <-> Every moment is a fresh beginning. / Current Weather: Sunny, 25°C. It's sunny and bright outside. Don't forget your sunglasses!


## Dependencies

- **Weather API**: The script uses Weather API to fetch current weather data. You need to sign up and get an API key from [weatherapi.com](https://www.weatherapi.com/). [ONLY IF MY CURRENT API KEY DOES NOT WORK.]

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contact

For any questions or issues, feel free to reach out to me on Discord: @donna_nfgptyq5_96203 / @kyrofrost / @bratbf

---

Enjoy your personalized greetings with real-time weather updates and daily messages in your Roblox game!

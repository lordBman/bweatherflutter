const Map<int, String> __dayImages = {
  // Adding more codes for a more complete map
  0: 'meteocons--clear-day-fill.svg',             // clear
  1: 'meteocons--clear-day-fill.svg',             // Mainly clear
  2: 'meteocons--partly-cloudy-day-fill.svg',     // Partly cloudy
  3: 'meteocons--overcast-fill.svg',              // Overcast
  45: 'meteocons--fog-day-fill.svg',                  // Fog
  48: 'meteocons--fog-day-fill.svg', //'Rime fog or depositing rime fog',
  51: 'meteocons--partly-cloudy-day-drizzle-fill.svg',  //'Light drizzle',
  53: 'meteocons--overcast-day-drizzle-fill.svg',   //'Moderate drizzle',
  55: 'meteocons--extreme-day-drizzle-fill.svg',    //'Dense drizzle',
  56: 'meteocons--overcast-drizzle-fill.svg',  //'Freezing drizzle, light',
  57: 'meteocons--extreme-drizzle-fill.svg',   //'Freezing drizzle, dense',
  61: 'meteocons--partly-cloudy-day-rain-fill.svg',  //'Rain, slight',
  63: 'meteocons--overcast-day-rain-fill.svg', // 'Rain, moderate',
  65: 'meteocons--extreme-day-rain-fill.svg', //'Rain, heavy',
  66: 'meteocons--overcast-rain-fill.svg',   //'Freezing rain, slight',
  67: 'meteocons--extreme-rain-fill.svg',    //'Freezing rain, heavy',
  73: 'meteocons--extreme-day-snow-fill.svg',   //'Snow fall, moderate',
  75: 'meteocons--extreme-snow-fill.svg',   //'Snow fall, heavy',
  77: 'meteocons--snow-fill.svg',   //'Snow grains',
  80: 'meteocons--drizzle-fill.svg', //'Rain showers, slight',
  81: 'meteocons--overcast-rain-fill.svg',   //'Rain showers, moderate',
  82: 'meteocons--extreme-rain-fill.svg',   //'Rain shower s, violent',
  85: 'meteocons--partly-cloudy-day-snow-fill.svg',       //'Snow showers, slight',
  86: 'meteocons--extreme-snow-fill.svg',  //'Snow showers, heavy',
  95: 'meteocons--thunderstorms-day-fill.svg',   //'Thunderstorm, slight or moderate',
  96: 'meteocons--thunderstorms-day-overcast-fill.svg',  //'Thunderstorm with slight hail',
  99: 'meteocons--thunderstorms-day-extreme-fill.svg',  //'Thunderstorm with heavy hail',
  // ... Add more codes as needed
};

const Map<int, String> __nightImages = {
  // Adding more codes for a more complete map
  0: 'meteocons--clear-night-fill.svg', // clear sky
  1: 'meteocons--clear-night-fill.svg', // Mainly clear
  2: 'meteocons--partly-cloudy-night-fill.svg', //Partly cloudy',
  3: 'meteocons--overcast-night-fill.svg', //'Overcast',
  45: 'meteocons--fog-night-fill.svg',   //'Fog',
  48: 'meteocons--fog-night-fill.svg', //'Rime fog or depositing rime fog',
  51: 'meteocons--drizzle-fill.svg',     //'Light drizzle',
  53: 'meteocons--partly-cloudy-night-drizzle-fill.svg',   //'Moderate drizzle',
  55: 'meteocons--extreme-night-drizzle-fill.svg', //'Dense drizzle',
  57: 'meteocons--extreme-drizzle-fill.svg',   //'Freezing drizzle, dense',
  61: 'meteocons--partly-cloudy-night-rain-fill.svg',  //'Rain, slight',
  63: 'meteocons--overcast-night-rain-fill.svg', // 'Rain, moderate',
  65: 'meteocons--extreme-night-rain-fill.svg', //'Rain, heavy',
  66: 'meteocons--overcast-rain-fill.svg',   //'Freezing rain, slight',
  67: 'meteocons--extreme-rain-fill.svg',    //'Freezing rain, heavy',
  71: 'meteocons--snow-fill.svg', //'Snow fall, slight',
  73: 'meteocons--extreme-night-snow-fill.svg',   //'Snow fall, moderate',
  75: 'meteocons--extreme-snow-fill.svg',   //'Snow fall, heavy',
  77: 'meteocons--snow-fill.svg',   //'Snow grains',
  80: 'meteocons--drizzle-fill.svg', //'Rain showers, slight',
  81: 'meteocons--overcast-rain-fill.svg',   //'Rain showers, moderate',
  82: 'meteocons--extreme-rain-fill.svg',   //'Rain showers, violent',
  85: 'meteocons--partly-cloudy-night-snow-fill.svg',       //'Snow showers, slight',
  86: 'meteocons--extreme-snow-fill.svg',  //'Snow showers, heavy',
  95: 'meteocons--thunderstorms-night-fill.svg',   //'Thunderstorm, slight or moderate',
  96: 'meteocons--thunderstorms-night-overcast-fill.svg',  //'Thunderstorm with slight hail',
  99: 'meteocons--thunderstorms-night-extreme-fill.svg',  //'Thunderstorm with heavy hail',
  // ... Add more codes as needed
};

const Map<int, String> __descriptions = {
  // Adding more codes for a more complete map
  0: 'Clear Sky', // clear sky
  1: 'Mainly clear',
  2: 'Partly cloudy',
  3: 'Overcast',
  45: 'Fog',
  48: 'Rime fog or depositing rime fog',
  51: 'Light drizzle',
  53: 'Moderate drizzle',
  55: 'Dense drizzle',
  56: 'Freezing drizzle, light',
  57: 'Freezing drizzle, dense',
  61: 'Rain, slight',
  63: 'Rain, moderate',
  65: 'Rain, heavy',
  66: 'Freezing rain, slight',
  67: 'Freezing rain, heavy',
  71: 'Snow fall, slight',
  73: 'Snow fall, moderate',
  75: 'Snow fall, heavy',
  77: 'Snow grains',
  80: 'Rain showers, slight',
  81: 'Rain showers, moderate',
  82: 'Rain showers, violent',
  85: 'Snow showers, slight',
  86: 'Snow showers, heavy',
  95: 'Thunderstorm, slight or moderate',
  96: 'Thunderstorm with slight hail',
  99: 'Thunderstorm with heavy hail',
  // ... Add more codes as needed
};

class WeatherCode{
    final String image, description;

    WeatherCode({ required this.image, required this.description });

    factory WeatherCode.decode({ required int code, required bool isNight }){
        String image = (isNight ? __nightImages[code] : __dayImages[code]) ?? "";

        return WeatherCode(image: "files/icons/$image", description: __descriptions[code] ?? "unknown");
    }
}

extension WeatherCodes on int {
    WeatherCode weatherCode({ bool isNight = false }) {
        return WeatherCode.decode(code: this, isNight: isNight);
    }
}
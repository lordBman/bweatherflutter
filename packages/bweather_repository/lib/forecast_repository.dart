import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart' as api;
import 'package:bweather_repository/forecast.dart';
import 'package:bweather_repository/units.dart';

class ForecastRepository {
    Units __units;
    set units(Units value) => __units = value;

    ForecastRepository({ required Units units }): __units = units;

    Future<Forecast> getWeather(City city) async {
        final result = await WeatherClient.forecast(city, precipitationUnit: __units.precipitation_unit.serialize, tempUnit: __units.temp_unit.serialize, windSpeedUnit: __units.wind_speed_unit.serialize);
        
        return Forecast(city: city, result: result);
    }

    Future<List<City>> search(String query) async{
        final locations = await WeatherClient.locationSearch(query);

        return locations;
    }
}
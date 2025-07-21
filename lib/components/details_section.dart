import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/components/details.dart';
import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget{
    final Current current;
    final City city;

    const DetailsSection({ super.key, required this.current, required this.city });

    @override
    Widget build(BuildContext context) {
        return GridView.count(crossAxisCount: 2, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true,
            crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.4,
            children: [
                Details(title: "Wind Direction", info: "${current.wind_direction.value}${current.wind_direction.unit}", iconAsset: "noto--compass.svg"),
                Details(title: "Wind Guts", info: "${current.wind_gusts.value}${current.wind_gusts.unit}", iconAsset: "fluent-emoji-flat--leaf-fluttering-in-wind.svg"),
                Details(title: "Rain", info: "${city.forecast?.hourly[DateTime.now().hour].rain.value.ceil()}${city.forecast?.hourly[DateTime.now().hour].rain.unit}", iconAsset: "emojione--umbrella-with-rain-drops.svg"),
                Details(title: "Pressure", info: "${current.surface_pressure.value.ceil()}${current.surface_pressure.unit}", iconAsset: "emojione--stopwatch.svg"),
                Details(title: "Cloud Cover", info: "${current.cloud_cover.value}${current.cloud_cover.unit}", iconAsset: "emojione--sun-behind-cloud.svg"),
                Details(title: "Precipitation", info: "${current.precipitation.value.ceil()}${current.precipitation.unit}", iconAsset: "twemoji--droplet.svg"),
            ]
        );
    }
}
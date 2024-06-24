import 'package:bweatherflutter/components/location.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Locations extends StatelessWidget{
    const Locations({super.key});

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        WeatherNotifer weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);

        return Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_city_outlined, size: 28,),
                            const SizedBox(width: 10,),
                            Text("Saved Locations", style: TextStyle(color: theme.onSurface, fontSize: 20),),
                          ],
                      ),
                      IconButton(icon: Icon(Icons.add_location_alt, color: theme.secondary,  size: 28),
                      onPressed: (){ Navigator.pushNamed(context, "/cities"); },
                      color: theme.secondaryFixed),
                    ],
                  ),
              ),
              Expanded(child: ListView.builder(
                  itemCount: weatherNotifer.savedCities.length, itemBuilder: (context, index)=> LocationItem(index: index),
              )),
          ],
        );
    }
}
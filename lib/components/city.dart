import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityViewItem extends StatefulWidget{
    final City city;

    const CityViewItem({super.key,  required this.city });

    @override
    State<CityViewItem> createState() => __CityViewItemState();
}

class __CityViewItemState extends State<CityViewItem> {
    late WeatherNotifier weatherNotifier;

    void choose(BuildContext context){
        weatherNotifier.addCity(widget.city);
        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        weatherNotifier = context.watch<WeatherNotifier>();

        return IconButton(onPressed: ()=> choose(context), style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent), padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 10))),
            icon: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.location_pin, size: 30, color: theme.primary,),
                const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(widget.city.name, style: TextStyle(fontSize: 18, letterSpacing: 1.4, height: 1, fontWeight: FontWeight.w300, color: theme.primary),),
                    const SizedBox(height: 4,),
                    Text(widget.city.country, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: theme.onSurface.withOpacity(0.8)),),
                    Row(children: [
                        Text("Latitude: ${widget.city.latitude.ceil()}", style: const TextStyle(fontSize: 14 ),),
                        const SizedBox(width: 10,),
                        Text("Longitude: ${widget.city.longitude.ceil()}", style: const TextStyle(fontSize: 14 )),
                      ],),
                ],),
            ]),
        );
    }
}

class CityView extends StatelessWidget{
    final String? letter;
    final City city;

    const CityView({super.key, required this.city, this.letter });

    @override
    Widget build(BuildContext context) {
        if(letter == null){
            return CityViewItem(city: city);
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: letter == "A" ? 0 : 12,),
            Text(letter!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey),),
            CityViewItem(city: city),
        ],);
    }
}

class CityList extends StatefulWidget{
    const CityList({super.key});

    @override
    State<StatefulWidget> createState() => __CityListState();
}

class __CityListState extends State<CityList>{
    late CitiesNotifier citiesNotifier;

    @override
    Widget build(BuildContext context) {
        citiesNotifier = context.watch<CitiesNotifier>();

        return ListView.separated(itemCount: cities.length, itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CityView(city: cities[index], letter: citiesNotifier.letters[index],),
            );
        }, separatorBuilder: (context, index) => const Divider(height: 0.3,),);
    }
}
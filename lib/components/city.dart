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
    late WeatherNotifer weatherNotifer;

    void choose(BuildContext context){
        weatherNotifer.addCity(widget.city);
        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);

        return IconButton(onPressed: ()=> choose(context), style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 10))),
          icon: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(widget.city.name, style: TextStyle(fontSize: 22, letterSpacing: 1.4, fontWeight: FontWeight.w300, color: theme.primary),),
              Text(widget.city.country, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),),
              Row(children: [
                  Text("Lat: ${widget.city.latitude.ceil()}", style: const TextStyle(fontSize: 12 ),),
                  const SizedBox(width: 10,),
                  Text("Long: ${widget.city.longitude.ceil()}", style: const TextStyle(fontSize: 12 )),
              ],),
          ],),
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
            const SizedBox(height: 12,),
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
        citiesNotifier = Provider.of<CitiesNotifier>(context, listen: true);
        return ListView.separated(itemCount: cities.length, itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CityView(city: cities[index], letter: citiesNotifier.letters[index],),
            );
        }, separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200,),);
    }
}
import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityViewItem extends StatelessWidget{
    final City city;
    late WeatherNotifer weatherNotifer;

    CityViewItem({super.key,  required this.city });

    void choose(){
        weatherNotifer.setCity(city.latitude, city.longitude);
        weatherNotifer.toHome();
    }

    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        return IconButton(onPressed: choose, style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 10))),
          icon: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(city.name, style: const TextStyle(fontSize: 18, letterSpacing: 1.4, fontWeight: FontWeight.w300, color: Colors.deepOrangeAccent),),
              Text("Country code: ${city.country}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
              Row(children: [
                  Text("Lat: ${city.latitude.ceil()}", style: const TextStyle(fontSize: 12 ),),
                  const SizedBox(width: 10,),
                  Text("Long: ${city.longitude.ceil()}", style: const TextStyle(fontSize: 12 )),
              ],),
          ],),
        );
    }
}

class CityView extends StatefulWidget{
    String? letter;
    final City city;

    CityView({super.key, required this.city, this.letter });

    @override
    State<CityView> createState() => __CityViewState();
}

class __CityViewState extends State<CityView> {

    @override
    Widget build(BuildContext context) {
        if(widget.letter == null){
            return CityViewItem(city: widget.city);
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 12,),
            Text(widget.letter!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey),),
            CityViewItem(city: widget.city),
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
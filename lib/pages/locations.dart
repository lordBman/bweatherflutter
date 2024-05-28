import 'package:bweatherflutter/components/location.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Locations extends StatelessWidget{
    const Locations({super.key});

    @override
    Widget build(BuildContext context) {
        WeatherNotifer weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        return Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.location_city_outlined, size: 28,),
                            SizedBox(width: 10,),
                            Text("Saved Locations", style: TextStyle(color: Colors.grey, fontSize: 20),),
                          ],
                      ),
                      Container(alignment: Alignment.centerRight, padding:  const EdgeInsets.only(top: 8, right: 8), 
                          child: IconButton(icon: const Icon(Icons.add_location_alt,  size: 24),
                          onPressed: (){ Navigator.pushNamed(context, "/cities"); },
                          color: Colors.deepOrangeAccent),),
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
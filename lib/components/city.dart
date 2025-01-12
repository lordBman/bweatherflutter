import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/states/cities_cubit.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityViewItem extends StatelessWidget{
    final CityData city;

    const CityViewItem({super.key,  required this.city });

    void choose(BuildContext context){
        context.read<WeatherCubit>().requestCity(city.name);
        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return IconButton(onPressed: ()=> choose(context), style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent), padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 10))),
            icon: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.location_pin, size: 30, color: theme.primary,),
                const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(city.name, style: TextStyle(fontSize: 18, letterSpacing: 1.4, height: 1, fontWeight: FontWeight.w300, color: theme.primary),),
                    const SizedBox(height: 4,),
                    Text(city.country, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: theme.onSurface.withOpacity(0.8)),),
                    Row(children: [
                        Text("Latitude: ${city.latitude.ceil()}", style: const TextStyle(fontSize: 14 ),),
                        const SizedBox(width: 10,),
                        Text("Longitude: ${city.longitude.ceil()}", style: const TextStyle(fontSize: 14 )),
                      ],),
                ],),
            ]),
        );
    }
}

class CityView extends StatelessWidget{
    final String? letter;
    final CityData city;

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

class CityList extends StatelessWidget{
    const CityList({super.key});

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<CitiesCubit, CitiesState>(
            builder: (context, state) => ListView.separated(itemCount: cities.length, itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CityView(city: cities[index], letter: state.letters[index],),
              );
          }, separatorBuilder: (context, index) => const Divider(height: 0.2),),
        );
    }
}


class CityViewResultItem extends StatelessWidget{
    final City city;

    const CityViewResultItem({super.key,  required this.city });

    void choose(BuildContext context){
        context.read<WeatherCubit>().addCity(city);
        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return IconButton(onPressed: ()=> choose(context), style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent), padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 10))),
            icon: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.location_pin, size: 30, color: theme.primary,),
                const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(city.name, style: TextStyle(fontSize: 18, letterSpacing: 1.4, height: 1, fontWeight: FontWeight.w300, color: theme.primary),),
                    const SizedBox(height: 4,),
                    Text(city.country, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: theme.onSurface.withOpacity(0.8)),),
                    Row(children: [
                        Text("Latitude: ${city.latitude.ceil()}", style: const TextStyle(fontSize: 14 ),),
                        const SizedBox(width: 10,),
                        Text("Longitude: ${city.longitude.ceil()}", style: const TextStyle(fontSize: 14 )),
                      ],),
                ],),
            ]),
        );
    }
}
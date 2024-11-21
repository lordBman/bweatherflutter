import 'package:bweatherflutter/components/location.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:provider/provider.dart';

class Locations extends StatefulWidget {
    final GlobalKey<LiquidPullRefreshState> refreshIndicatorKey = GlobalKey<LiquidPullRefreshState>();

    Locations({super.key});

    @override
    State<StatefulWidget> createState() => __LocationsState();
}

class __LocationsState extends State<Locations>{
    late ScrollController __scrollController;
    late MainProvider __mainProvider;

    @override
    void initState() {
        __scrollController = ScrollController();
        __scrollController.addListener(onScroll);
        super.initState();
    }

    void onScroll(){
        switch(__scrollController.position.userScrollDirection){
            case ScrollDirection.forward:
                __mainProvider.showFAO = true;
                break;
            case ScrollDirection.reverse:
                __mainProvider.showFAO = false;
                break;
            case ScrollDirection.idle:
                break;
        }
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        WeatherNotifier weatherNotifier = context.watch<WeatherNotifier>();
        __mainProvider = context.watch<MainProvider>();

        return CustomScrollView(//controller: __scrollController,
            slivers: [
              SliverAppBar(pinned: true,
                  elevation: 200,
                  shadowColor: theme.onSurface,
                  leading: const Icon(Icons.map_outlined),
                  title: Text("Cities", style: TextStyle(color: theme.onSurface, fontSize: 20),)),
              SliverFillRemaining(child: LiquidPullRefresh(
                  onRefresh: () async{
                      await weatherNotifier.reload(force: true);
                  },
                  showChildOpacityTransition: false,
                  backgroundColor: theme.surface,
                  animSpeedFactor: 2.0,
                  color: theme.primary,
                  heightLoader: 80,
                  height: 80,
                  showDroplet: true,
                  springAnimationDurationInMilliseconds: 400,
                  key: widget.refreshIndicatorKey,
                  child: ListView.separated(
                      controller: __scrollController,
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: weatherNotifier.savedCities.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 15),
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: LocationItem(index: index),
                      ),
                      //separatorBuilder: (context, index) => const SizedBox(height: 15,),
                  ))),
              /*SliverList.s(
                  itemCount: weatherNotifier.savedCities.length,
                  itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 15, left: 15, bottom: 15, top: index == 0 ? 15 : 0),
                      child: LocationItem(index: index),
                  ),
                  //separatorBuilder: (context, index) => const SizedBox(height: 15,),
              ),*/
            ],
        );
    }

    @override
    void dispose(){
        __scrollController.removeListener(onScroll);
        __scrollController.dispose();
        super.dispose();
    }
}
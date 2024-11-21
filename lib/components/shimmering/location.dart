import 'package:bweatherflutter/components/shimmering/shimmer_wraper.dart';
import 'package:flutter/material.dart';

class LocationItemShimmering extends StatelessWidget{
    const LocationItemShimmering({ super.key });

    @override
    Widget build(BuildContext context) {
      ColorScheme theme = Theme.of(context).colorScheme;

    return Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: theme.surfaceContainerHigh,
          /*boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2)),
                ]*/
        ),
        child: ShimmerWrapper(
          child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), width: 70, height: 70),
              const SizedBox(width: 8),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), height: 24, width: 220),
                  const SizedBox(height: 8),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 14, width: 100),
                        const SizedBox(height: 8),
                        Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 10, width: 60)
                      ],),
                    ),
                    Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 60, width: 60),
                  ],)
                ],),
              ),
            ],),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [0, 1, 2, 3, 4].map((index){
              return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 50, width: 50),
                const SizedBox(height: 8),
                Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 12, width: 50),
                const SizedBox(height: 8),
                Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),  height: 10, width: 50)
              ],);
            }).toList(),)
          ],),
        )
    );
  }
}
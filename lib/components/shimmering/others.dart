import 'package:bweatherflutter/components/daily.dart';
import 'package:bweatherflutter/components/hourly.dart';
import 'package:bweatherflutter/components/option-button.dart';
import 'package:bweatherflutter/components/shimmering/shimmer_wraper.dart';
import 'package:bweatherflutter/utils/result.dart';
import 'package:flutter/material.dart';

class OthersShimmering extends StatelessWidget{

  const OthersShimmering({super.key });

  @override
  Widget build(BuildContext context) {

    return ShimmerWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(height: 40, width: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),),
            ),
            const SizedBox(height: 12),
            SizedBox(height: 140, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 6,
              itemBuilder: (context, index){
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: 80, decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        /*boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 3, offset: const Offset(0, 2)),
                        ]*/
                    )));
              },))
          ],
        ),
      );
  }
}
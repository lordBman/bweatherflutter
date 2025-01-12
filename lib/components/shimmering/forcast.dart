import 'package:bweatherflutter/components/shimmering/others.dart';
import 'package:bweatherflutter/components/shimmering/shimmer_wraper.dart';
import 'package:flutter/material.dart';

class ForecastShimmering extends StatelessWidget{
    const ForecastShimmering({super.key});

    @override
    Widget build(BuildContext context) {
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: ShimmerWrapper(
                  child: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 240, height: 50, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                      const SizedBox(height: 8,),
                      Container(width: 100, height: 14, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                      const SizedBox(height: 12,),
                      Container(width: 200, height: 24, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                      const SizedBox(height: 20,),
                      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                          Container(width: 180, height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                          const SizedBox(width: 10,),
                          Container(width: 120, height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Container(width: 240, height: 14, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                              const SizedBox(height: 8),
                              Container(width: 120, height: 14, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                        ])
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Container(width: 80, height: 40, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                              const SizedBox(height: 8,),
                              Container(width: 80, height: 20, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                          ],),
                          const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Container(width: 80, height: 40, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                            const SizedBox(height: 8,),
                            Container(width: 80, height: 20, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                          ],),
                          const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Container(width: 80, height: 40, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                            const SizedBox(height: 8,),
                            Container(width: 80, height: 20, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                          ],),
                        ],),
                      )
                    ],
                  )),
                ),
            ),
              const OthersShimmering()
            ],
          );
  }
}
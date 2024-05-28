import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget{
    final String message;

    const Loading({ super.key, required this.message });

    @override
    Widget build(BuildContext context) {
        return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 60, 
                child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored, colors: [Colors.orange],)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: 1.4,),),
            )
          ],
        );
    }
}
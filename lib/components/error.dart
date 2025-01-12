import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatelessWidget{
    final String message;

    const ErrorView({ super.key, required this.message });

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Lottie.asset('files/animations/Not found.json', width: 200, fit: BoxFit.fitWidth),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(message, textAlign: TextAlign.center, style: TextStyle(color: theme.error, fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 1.4,),),
                )
        ],);
    }
}
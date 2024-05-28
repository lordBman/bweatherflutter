import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget{
    final String message;

    const ErrorView({ super.key, required this.message });

    @override
    Widget build(BuildContext context) {
        return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                const Image(image: AssetImage('files/ic_splash.png')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: 1.4,),),
                )
        ],);
    }
}
import 'package:flutter/material.dart';

class Clickable extends StatelessWidget{
    final Function() clicked;
    final Widget child;

    const Clickable({ super.key, required this.clicked, required this.child });

    @override
    Widget build(BuildContext context) {
        return TextButton(
            style: const ButtonStyle( padding: WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: clicked, child: child);
    }
}
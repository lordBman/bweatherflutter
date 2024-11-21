import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatelessWidget{
    final String title, info, iconAsset;


    const Details({ super.key, required this.title, required this.info, required this.iconAsset });

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return Container(decoration: BoxDecoration(color: theme.surfaceContainerHigh, borderRadius: BorderRadius.circular(14)), padding: const EdgeInsets.all(12), alignment: Alignment.center,
            child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                SvgPicture.asset("files/$iconAsset", width: 36, fit: BoxFit.fitWidth),
                const SizedBox(width: 10),
                Expanded(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(info, style: GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.w100, letterSpacing: 1.4, color: Colors.blueGrey),),
                        Text(title, style: TextStyle(fontSize: 12, color: theme.onSurface),)
                    ],),
                )
        ],),);
    }
}
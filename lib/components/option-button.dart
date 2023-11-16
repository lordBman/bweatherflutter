import 'package:flutter/material.dart';

class OptionButtion extends StatelessWidget{
    final bool active;
    final String text;
    final Function() onPressed;
    final BorderRadius borderRadius;

    const OptionButtion({super.key,  required this.active, required this.text, required this.onPressed, required this.borderRadius});

    @override
    Widget build(BuildContext context) {
        return DecoratedBox(
            decoration: BoxDecoration(border: Border.all(color: Colors.deepOrangeAccent, width: 2), color: active ? Colors.deepOrangeAccent : Colors.transparent, borderRadius: borderRadius),
            child: SizedBox(
              height: 40,
              child: TextButton(onPressed: onPressed,
                  child: Text(text, style: TextStyle( color: active ? Colors.white : Colors.deepOrangeAccent, fontSize: 14, fontWeight: FontWeight.w300 ),)),
            ));
    }
}


class LeftOptionButton extends OptionButtion{
    const LeftOptionButton({super.key, required super.active, required super.text, required super.onPressed}): super(borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)));
}

class RightOptionButton extends OptionButtion{
    const RightOptionButton({super.key, required super.active, required super.text, required super.onPressed}): super(borderRadius: const BorderRadius.only(bottomRight: Radius.circular(6), topRight: Radius.circular(6)));
}

class Option extends StatefulWidget{
    final Function(String choice) onChoose;

    const Option({super.key,  required this.onChoose });

    @override
    State<StatefulWidget> createState() => __OptionState();
}

class __OptionState extends State<Option>{
    String active = "daily";

    toDaily(){
        if(active == "hourly"){
            widget.onChoose("daily");
            setState(() { active = "daily"; });
        }
    }

    toHourly(){
        if(active == "daily"){
            widget.onChoose("hourly");
            setState(() { active = "hourly"; });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
              LeftOptionButton(active: active == "daily", text: "Daily", onPressed: toDaily),
              RightOptionButton(active: active == "hourly", text: "Hourly", onPressed: toHourly)
          ]),
        );
    }
}
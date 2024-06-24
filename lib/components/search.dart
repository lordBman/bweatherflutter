import 'package:flutter/material.dart';

class Search extends StatefulWidget{
    final void Function(String query) onSearch;
    final void Function() cleared;

    const Search({super.key, required this.onSearch, required this.cleared });

    @override
    State<StatefulWidget> createState() => __SearchState();
  
}

class __SearchState extends State<Search>{
    TextEditingController textEditingController = TextEditingController();
    bool isEmpty = false;

    @override
    void initState() {
        super.initState();
        textEditingController.addListener(() {
            if(isEmpty){
                widget.cleared();
            }
        });
    }

    void clicked(){
        if(textEditingController.text.isNotEmpty){
            widget.onSearch(textEditingController.text);
        }
    }

    void clear(){
        textEditingController.clear();
        widget.cleared();
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return Padding(padding: const EdgeInsets.only(top: 12, left: 6, right: 6, bottom: 2 ),
          child: DecoratedBox(decoration: BoxDecoration(color: theme.surfaceContainerHigh, borderRadius: BorderRadius.circular(26)),
            child: Padding(padding: const EdgeInsets.all(2),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                children: [
                    IconButton(onPressed: clear, icon: const Icon(Icons.cancel)),
                    Expanded(
                        child: TextFormField( controller: textEditingController, textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration( border: InputBorder.none, hintText: "Search cities"),),
                    ),
                    FilledButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(theme.secondaryFixed)), onPressed: clicked, child: Icon(Icons.search_outlined, color: theme.onSecondaryFixed,),)
                ],
              ),
            ),
          ),
        );
    }
}
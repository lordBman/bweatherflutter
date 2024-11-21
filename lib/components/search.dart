import 'package:flutter/cupertino.dart';
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

    @override
    void initState() {
        super.initState();
        textEditingController.addListener(() {
            if(textEditingController.text.isEmpty){
                widget.cleared();
            }else{
                widget.onSearch(textEditingController.text);
            }
        });
    }

    void submitted(String? query){
        if(query != null && query.isNotEmpty){
            widget.onSearch(query);
        }
    }

    void clear(){
        textEditingController.clear();
        widget.cleared();
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return DecoratedBox(decoration: BoxDecoration(color: theme.surfaceContainerHigh, borderRadius: BorderRadius.circular(26)),
          child: Padding(padding: const EdgeInsets.all(2),
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
              children: [
                  Expanded(
                      child: TextFormField( style: const TextStyle(height: 1), maxLines: 1, scrollPadding: EdgeInsets.zero, controller: textEditingController, textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              prefixIconColor: theme.onSurface, suffixIconColor: theme.error,
                              suffixIcon: IconButton(onPressed: clear, icon: const Icon(Icons.cancel)),
                              prefixIcon: const Icon(Icons.search_outlined,),
                              border: InputBorder.none, hintText: "Search cities"), onFieldSubmitted: submitted,),
                  ),
              ],
            ),
          ),
        );
    }
}
import 'package:flutter/widgets.dart';

class Theme{
    String backgroundColor;
    String primaryColor;
    bool isLight = false;

    Theme.light(): backgroundColor = "white", primaryColor = "#3467ff", isLight = true;
    Theme.dark(): backgroundColor = "#220012", primaryColor = "#3467ff";
}

class ThemeNotifier extends ChangeNotifier{
    Theme? __theme;

    toggle(){
        if(__theme == null){
            __theme = Theme.light();
        }else{
            __theme = __theme!.isLight ? Theme.dark() : null;
        }
        notifyListeners();
    }

    Theme get current{
        return Theme.dark();
    }
}
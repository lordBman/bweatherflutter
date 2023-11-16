import 'package:flutter/material.dart';

class Settings{
    String unit;

    Settings.init(): unit = "";
}

class SettingsNotifier extends ChangeNotifier{
    final Settings __settings = Settings.init();

    Settings get current{
        return __settings;
    }
}
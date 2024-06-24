import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme.light(
      primary: Color(0xff00538a),
      surfaceTint: Color(0xff0062a1),
      onPrimary: Colors.white,
      primaryContainer: Color(0xff2678bc),
      onPrimaryContainer: Colors.white,
      secondary: Color(0xffad3306),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xffff825b),
      onSecondaryContainer: Color(0xff390a00),
      tertiary: Color(0xff526070),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xff919fb1),
      onTertiaryContainer: Color(0xff03111f),
      error: Color(0xffba1a1a),
      onError: Colors.white,
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff414750),
      outline: Color(0xff717881),
      outlineVariant: Color(0xffc0c7d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9ccaff),
      primaryFixed: Color(0xffd0e4ff),
      onPrimaryFixed: Color(0xff001d35),
      primaryFixedDim: Color(0xff9ccaff),
      onPrimaryFixedVariant: Color(0xff00497a),
      secondaryFixed: Color(0xffffdbd0),
      onSecondaryFixed: Color(0xff3a0a00),
      secondaryFixedDim: Color(0xffffb59f),
      onSecondaryFixedVariant: Color(0xff852300),
      tertiaryFixed: Color(0xffd5e4f8),
      onTertiaryFixed: Color(0xff0e1d2b),
      tertiaryFixedDim: Color(0xffbac8db),
      onTertiaryFixedVariant: Color(0xff3a4858),
      surfaceDim: Color(0xffd8dae0),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xfff2f3fa),
      surfaceContainer: Color(0xffeceef4),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e2e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004574),
      surfaceTint: Color(0xff0062a1),
      onPrimary: Colors.white,
      primaryContainer: Color(0xff2678bc),
      onPrimaryContainer: Colors.white,
      secondary: Color(0xff7e2100),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xffcb491e),
      onSecondaryContainer: Colors.white,
      tertiary: Color(0xff364454),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xff687687),
      onTertiaryContainer: Colors.white,
      error: Color(0xff8c0009),
      onError: Colors.white,
      errorContainer: Color(0xffda342e),
      onErrorContainer: Colors.white,
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff3d434c),
      outline: Color(0xff596069),
      outlineVariant: Color(0xff747b85),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9ccaff),
      primaryFixed: Color(0xff2678bc),
      onPrimaryFixed: Colors.white,
      primaryFixedDim: Color(0xff005f9d),
      onPrimaryFixedVariant: Colors.white,
      secondaryFixed: Color(0xffcb491e),
      onSecondaryFixed: Colors.white,
      secondaryFixedDim: Color(0xffa93103),
      onSecondaryFixedVariant: Colors.white,
      tertiaryFixed: Color(0xff687687),
      onTertiaryFixed: Colors.white,
      tertiaryFixedDim: Color(0xff4f5d6e),
      onTertiaryFixedVariant: Colors.white,
      surfaceDim: Color(0xffd8dae0),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xfff2f3fa),
      surfaceContainer: Color(0xffeceef4),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e2e8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002440),
      surfaceTint: Color(0xff0062a1),
      onPrimary: Colors.white,
      primaryContainer: Color(0xff004574),
      onPrimaryContainer: Colors.white,
      secondary: Color(0xff460e00),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xff7e2100),
      onSecondaryContainer: Colors.white,
      tertiary: Color(0xff152332),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xff364454),
      onTertiaryContainer: Colors.white,
      error: Color(0xff4e0002),
      onError: Colors.white,
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Colors.white,
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1e242d),
      outline: Color(0xff3d434c),
      outlineVariant: Color(0xff3d434c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xffe1edff),
      primaryFixed: Color(0xff004574),
      onPrimaryFixed: Colors.white,
      primaryFixedDim: Color(0xff002f50),
      onPrimaryFixedVariant: Colors.white,
      secondaryFixed: Color(0xff7e2100),
      onSecondaryFixed: Colors.white,
      secondaryFixedDim: Color(0xff581400),
      onSecondaryFixedVariant: Colors.white,
      tertiaryFixed: Color(0xff364454),
      onTertiaryFixed: Colors.white,
      tertiaryFixedDim: Color(0xff202e3d),
      onTertiaryFixedVariant: Colors.white,
      surfaceDim: Color(0xffd8dae0),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xfff2f3fa),
      surfaceContainer: Color(0xffeceef4),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e2e8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xff9ccaff),
      surfaceTint: Color(0xff9ccaff),
      onPrimary: Color(0xff003256),
      primaryContainer: Color(0xff2376ba),
      onPrimaryContainer: Colors.white,
      secondary: Color(0xffcb491e),
      onSecondary: Color(0xff5e1600),
      secondaryContainer: Color(0xfff6683a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbac8db),
      onTertiary: Color(0xff243240),
      tertiaryContainer: Color(0xff687687),
      onTertiaryContainer: Colors.white,
      error: Colors.red,
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101418),
      onSurface: Color(0xffe0e2e8),
      onSurfaceVariant: Color(0xffc0c7d2),
      outline: Color(0xff8a919b),
      outlineVariant: Color(0xff414750),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff0062a1),
      primaryFixed: Color(0xffd0e4ff),
      onPrimaryFixed: Color(0xff001d35),
      primaryFixedDim: Color(0xff9ccaff),
      onPrimaryFixedVariant: Color(0xff00497a),
      secondaryFixed: Color(0xffcb491e),
      onSecondaryFixed: Color(0xff3a0a00),
      secondaryFixedDim: Color(0xffcb491e),
      onSecondaryFixedVariant: Color(0xff852300),
      tertiaryFixed: Color(0xffd5e4f8),
      onTertiaryFixed: Color(0xff0e1d2b),
      tertiaryFixedDim: Color(0xffbac8db),
      onTertiaryFixedVariant: Color(0xff3a4858),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff272a2f),
      surfaceContainerHighest: Color(0xff32353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xffa4ceff),
      surfaceTint: Color(0xff9ccaff),
      onPrimary: Color(0xff00172c),
      primaryContainer: Color(0xff4b95da),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcb491e),
      onSecondary: Color(0xff310700),
      secondaryContainer: Color(0xfff6683a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbeccdf),
      onTertiary: Color(0xff091725),
      tertiaryContainer: Color(0xff8492a4),
      onTertiaryContainer: Color(0xff000000),
      error: Colors.red,
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101418),
      onSurface: Color(0xfffafaff),
      onSurfaceVariant: Color(0xffc5cbd6),
      outline: Color(0xff9da3ae),
      outlineVariant: Color(0xff7d848e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff004b7c),
      primaryFixed: Color(0xffd0e4ff),
      onPrimaryFixed: Color(0xff001224),
      primaryFixedDim: Color(0xff9ccaff),
      onPrimaryFixedVariant: Color(0xff003860),
      secondaryFixed: Color(0xffffdbd0),
      onSecondaryFixed: Color(0xff280500),
      secondaryFixedDim: Color(0xffffb59f),
      onSecondaryFixedVariant: Color(0xff681a00),
      tertiaryFixed: Color(0xffd5e4f8),
      onTertiaryFixed: Color(0xff041220),
      tertiaryFixedDim: Color(0xffbac8db),
      onTertiaryFixedVariant: Color(0xff2a3746),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff272a2f),
      surfaceContainerHighest: Color(0xff32353a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xfffafaff),
      surfaceTint: Color(0xff9ccaff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa4ceff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcb491e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffafaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbeccdf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Colors.red,
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101418),
      onSurface: Colors.white,
      onSurfaceVariant: Color(0xfffafaff),
      outline: Color(0xffc5cbd6),
      outlineVariant: Color(0xffc5cbd6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff002c4c),
      primaryFixed: Color(0xffd8e8ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa4ceff),
      onPrimaryFixedVariant: Color(0xff00172c),
      secondaryFixed: Color(0xffcb491e),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffcb491e),
      onSecondaryFixedVariant: Color(0xff310700),
      tertiaryFixed: Color(0xffdae8fc),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbeccdf),
      onTertiaryFixedVariant: Color(0xff091725),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff272a2f),
      surfaceContainerHighest: Color(0xff32353a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}
class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

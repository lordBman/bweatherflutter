import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(BuildContext context, String bodyFontString, String displayFontString) {
    TextTheme baseTextTheme = Theme.of(context).textTheme;
    TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
    TextTheme displayTextTheme = GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
    TextTheme textTheme = displayTextTheme.copyWith( bodyLarge: bodyTextTheme.bodyLarge, bodyMedium: bodyTextTheme.bodyMedium,
        bodySmall: bodyTextTheme.bodySmall, labelLarge: bodyTextTheme.labelLarge, labelMedium: bodyTextTheme.labelMedium,
        labelSmall: bodyTextTheme.labelSmall,
    );
    return textTheme;
}

const days =  ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
String day(int value)=> days[value % 7];

const months = ["January", "February", "Match", "April", "May", "June",  "July", "August", "September", "October", "November", "December"];
String month(int value) => months[value - 1];

String formatDate(DateTime time) => "${day(time.weekday)}, ${ time.day } ${ month(time.month) }";
String formatTime({ required DateTime time, required int timezone }){
    String hourFormat = time.hour % 12 == 0 ? "12" : (time.hour % 12).toString();
    String minutesFormat = time.minute < 10 ? "0${time.minute}" : time.minute.toString();
    String postFormat = time.hour >= 12 ? "pm" : "am";
    String timezoneFormat = "UTC${timezone >= 0 ? "+" : ""}$timezone";

    return "$hourFormat:$minutesFormat$postFormat $timezoneFormat";
}

class JsonParser{
    static int parseInt(dynamic json, String key) {
        return int.parse(json[key].toString());
    }

    static double parseDouble(dynamic json, String key) {
        return double.parse(json[key].toString());
    }

    static String parseString(dynamic json, String key) {
        return json[key].toString();
    }

    static DateTime parseDate(dynamic json, String key) {
        return DateTime.parse(json[key].toString());
    }

    static List<double> parseDoubleList(dynamic json, String key) {
        try{
            if (json[key] is List) {
                return (json[key] as List).map((objJson) =>  double.parse(objJson.toString())).toList();
            }
        }catch(error){
            log("json parsing error encountered", error: error);
        }
        log("json value encountered: $json is not a List");
        return [];
    }

    static List<int> parseIntList(dynamic json, String key) {
        try{
            if (json[key] is List) {
                return (json[key] as List).map((objJson) =>  int.parse(objJson.toString())).toList();
            }
        }catch(error){
            log("json parsing error encountered", error: error);
        }
        log("json value encountered: $json is not a List");
        return [];
    }

    static List<String> parseStringList(dynamic json, String key) {
        try{
            if (json[key] is List) {
                return (json[key] as List).map((objJson) =>  objJson.toString()).toList();
            }
        }catch(error){
            log("json parsing error encountered", error: error);
        }
        log("json value encountered: $json is not a List");
        return [];
    }

    static List<DateTime> parseDateList(dynamic json, String key) {
        try{
            if (json[key] is List) {
                return (json[key] as List).map((objJson) =>  DateTime.parse(objJson.toString())).toList();
            }
        }catch(error){
            log("json parsing error encountered", error: error);
        }
        log("json value encountered: $json is not a List");
        return [];
    }
}
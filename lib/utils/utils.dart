
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
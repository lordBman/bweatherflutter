import 'dart:developer';

const Map<String, double> __timeZones = {
    "ACDT": 10.5, "ACST": 9.5, "ADT": -3, "AEST": 10, "AEDT": 11, "AKDT": -8, "AKST": -9,"AST": -4, "AWST": 8,
    "BST": 1, "CAT": 2, "CDT": -5, "CET": 1, "CEST": 2, "ChST": 10, "CST": -6, "EAT": 3, "EDT": -4, "EET": 2, "EEST": 3,
    "EST": -5, "GMT": 0, "HDT": -9,"HST": -10, "HKT": 8, "IST": 5.5, "IDT": 3, "JST": 9, "KST": 9, "MDT": -6, "MST": -7,
    "MSK": 3, "NDT": -2.5, "NST": -3.5, "NZST": 12, "NZDT": 13, "NDST": 13, "PDT": -7, "PST": -8, "SAST": 2, "SST": -11,
    "WAT": 1, "WIB": 7, "WIT": 9, "WITA": 8, "WET": 0, "WEST": 1,
};



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
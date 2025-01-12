import 'package:flutter/services.dart';

class Bridge{
    static const MethodChannel __channel = MethodChannel("com.example/native");

    static Future<String> getNativeData() async{
        try{
            final String result = await __channel.invokeMethod("getNativeData");

            return result;
        }catch(error){
            throw "Failed to get data: $error";
        }
    }
}
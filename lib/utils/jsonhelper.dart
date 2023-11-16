class JsonHelper{
    static String getString(Object value)=> value.toString();
    static bool getBoolean(Object value){
        if(value is bool){
          return value;
        }
        return value.toString() == "1" || value.toString() == "true";
    }

    static int getInt(Object value){
        if(value is int){
          return value;
        }
        return int.parse(value.toString());
    }

    static double getDouble(Object value){
      if(value is double){
        return value;
      }
      return double.parse(value.toString());
    }

    static Map<String, dynamic> getObject(Object value){
        if(value is Map<String, dynamic>){
            return value;
        }
        return {};
    }
}

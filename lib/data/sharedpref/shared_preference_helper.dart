import 'dart:async';

class SharedPreferenceHelper {
  // singleton object
  static final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper._internal();

  // named private constructor
  SharedPreferenceHelper._internal();

  // factory method to return the same object each time its needed
  factory SharedPreferenceHelper() => _sharedPreferenceHelper;

  // General Methods: ----------------------------------------------------------
  /*
  Future<void> removeValue () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("s1");
  }

  Future<bool> get savedValue async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("s1") ?? false;
  }*/
}

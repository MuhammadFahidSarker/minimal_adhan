/*
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPref() async {
  return  SharedPreferences.getInstance();
}

Future<void> sharedPref(Future<void> Function(SharedPreferences) smth) async {
  final pref = await getSharedPref();
  await smth(pref);
}

Future<String?> getStringFromSharedPref(String key) async {
  return (await getSharedPref()).getString(key);
}

Future<int?> getIntFromSharedPref(String key) async {
  return (await getSharedPref()).getInt(key);
}

Future<bool?> getBoolFromSharedPref(String key) async {
  return (await getSharedPref()).getBool(key);
}

Future<bool> setBoolToSharedPref(String key, bool value) async {
  return (await getSharedPref()).setBool(key, value);
}

Future<bool> setIntToSharedPref(String key, int value) async {
  return (await getSharedPref()).setInt(key, value);
}

Future<bool> setStringToSharedPref(String key, String value) async {
  return (await getSharedPref()).setString(key, value);
}
*/

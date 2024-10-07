import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  // Keys for SharedPreferences
  static const String _tokenKey = 'token';
  static const String _dominid = 'dominid';
  static const String _idKey = 'userId';
  static const String _userNameKey = 'userName';
  static const String _emailKey = 'userEmail';
  static const String _isProvider = 'isProvider';
  static const String _currentLocation = 'currentLocation';

  //Save Token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> savedominid(String dominid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dominid, dominid);
  }

  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getdominid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dominid);
  }

  //Save Location Token
  static Future<void> saveLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentLocation, location);
  }

  // Get Location
  static Future<String?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentLocation);
  }

  // Save user data
  static Future<void> saveUserData(
      {required String id,
      required String userName,
      required String email,
      required String token,
      required bool isProvider}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_idKey, id);
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_emailKey, email);
    await prefs.setBool(_isProvider, isProvider);
  }

  //Get isProvider

  static Future<bool?> getIsProvider() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isProvider);
  }

  // Save user data
  static Future<void> updateUserData(
      {required String userName, required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_emailKey, email);
  }

  // Get user ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idKey);
  }

  // Get user name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  // Clear all data
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_idKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_isProvider);
    await prefs.remove(_currentLocation);
    await prefs.remove(_dominid);
  }

  Future<String> currentLocation() async {
    final getLocation = await LocalStore.getLocation();
    return getLocation ?? "";
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:lg_star_command/core/models/connection_params_model.dart';
class SettingsService {
  // Keys for local storage
  static const String _keyHost = 'lg_host';
  static const String _keyPort = 'lg_port';
  static const String _keyUsername = 'lg_username';
  static const String _keyPassword = 'lg_password';

  // Save connection settings
  Future<void> saveConnectionSettings(ConnectionParams params) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyHost, params.host);
    await prefs.setInt(_keyPort, params.port);
    await prefs.setString(_keyUsername, params.username);
    await prefs.setString(_keyPassword, params.password);
  }

  // Load connection settings
  Future<ConnectionParams?> loadConnectionSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final host = prefs.getString(_keyHost);
    final port = prefs.getInt(_keyPort);
    final username = prefs.getString(_keyUsername);
    final password = prefs.getString(_keyPassword);

    if (host != null && port != null && username != null && password != null) {
      return ConnectionParams(
        host: host,
        port: port,
        username: username,
        password: password,
      );
    }
    return null; // No saved settings found
  }

  // Clear settings (optional, good for "Forget Connection")
  Future<void> clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHost);
    await prefs.remove(_keyPort);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyPassword);
  }
}
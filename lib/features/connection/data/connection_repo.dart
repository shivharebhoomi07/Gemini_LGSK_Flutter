// Corrected Absolute Imports
import 'package:lg_star_command/core/services/ssh_service.dart';
import 'package:lg_star_command/core/services/settings_service.dart';
import 'package:lg_star_command/core/models/connection_params_model.dart';
import 'package:lg_star_command/core/failures/lg_exception.dart';

class ConnectionRepository {
  final SSHService _sshService;
  final SettingsService _settingsService;

  ConnectionRepository(this._sshService, this._settingsService);

  // -- Status Check --
  bool get isConnected => _sshService.isConnected;

  // -- Actions --

  /// Attempts to connect to the LG rig.
  /// If successful, it automatically saves the credentials to local storage.
  /// Throws [LGException] if connection fails.
  Future<void> connect(ConnectionParams params) async {
    try {
      // 1. Attempt connection
      await _sshService.connect(params);

      // 2. If we reach here, connection was successful. Save settings.
      await _settingsService.saveConnectionSettings(params);
    } catch (e) {
      // Rethrow so the BLoC can show the error message to the user
      rethrow;
    }
  }

  /// Disconnects from the LG rig.
  Future<void> disconnect() async {
    await _sshService.disconnect();
  }

  /// Loads the last used connection details (if any).
  /// Useful for auto-filling the login form.
  Future<ConnectionParams?> getSavedConnectionParams() async {
    return await _settingsService.loadConnectionSettings();
  }
}
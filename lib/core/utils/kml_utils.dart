// Corrected Absolute Import
import 'package:lg_star_command/core/services/ssh_service.dart';

class KMLUtils {
  final SSHService _sshService;

  KMLUtils(this._sshService);

  // -- File Paths on LG Rig --
  static const String _kmlSyncPath = '/var/www/html/kmls.txt';
  static const String _queryPath = '/tmp/query.txt';

  /// Clears all KMLs from the screen.
  /// This is essential before showing a new presentation to avoid clutter.
  Future<void> clearScreen() async {
    // We send an empty string to the sync file
    await _sshService.execute("echo '' > $_kmlSyncPath");
  }

  /// Flies the Liquid Galaxy to a specific view.
  /// [lookAt] should be a formatted KML LookAt string (from KMLGenerator).
  Future<void> flyTo(String lookAt) async {
    // The query.txt file is watched by Earth; writing to it triggers the move.
    await _sshService.execute("echo '$lookAt' > $_queryPath");
  }

  /// Starts an orbit (Tour) that has already been uploaded.
  /// [tourName] is the name defined inside the <gx:Tour> tag in your KML.
  Future<void> startOrbit(String tourName) async {
    await _sshService.execute("echo 'playtour=$tourName' > $_queryPath");
  }

  /// Stops any currently playing tour or orbit.
  Future<void> stopOrbit() async {
    await _sshService.execute("echo 'exittour=true' > $_queryPath");
  }

  /// Helper to send a command to a specific slave screen.
  /// Useful for showing different images on different screens (Task 3 advanced).
  /// [screenNumber]: 1 = Right, 2 = Left (usually).
  Future<void> sendToSlave(int screenNumber, String command) async {
    // Note: This requires the LG rig to be configured to accept SSH on slaves
    // or shared storage. This is a placeholder for advanced usage.
    // Standard LG setups usually manage everything from the Master.
  }
}

import 'package:lg_star_command/core/services/ssh_service.dart';
import 'package:lg_star_command/core/services/settings_service.dart'; // Import Settings
import 'package:lg_star_command/core/utils/kml_generator.dart';
import 'package:lg_star_command/core/failures/lg_exception.dart';
import 'package:lg_star_command/features/dashboard/domain/dashboard_repository_interface.dart';

class DashboardRepository implements DashboardRepositoryInterface {
  final SSHService _sshService;
  final SettingsService _settingsService; // Add SettingsService

  DashboardRepository(this._sshService, this._settingsService);

  // --- Helper: Get the Screen Number (Your Logic) ---
  Future<int> _getLeftScreen() async {
    final settings = await _settingsService.loadConnectionSettings();
    final int screens = settings?.screens ?? 3; // Default to 3 if null
    
    if (screens <= 1) return 1;
    
    // Your Formula: (screens / 2).floor() + 2
    // For 3 screens: floor(1.5) + 2 = 3 (Left)
    return (screens / 2).floor() + 2;
  }

  // --- Helper to reduce repetition ---
  Future<void> _query(String content) async {
    await _sshService.execute('echo "$content" > /tmp/query.txt');
  }

  // --- IMPLEMENTATION ---

  @override
  Future<void> showLogo() async {
    try {
      final int targetScreen = await _getLeftScreen();
      
      // Note: We use a remote URL here so it works immediately without 
      // needing to upload a local asset file first.
      const String logoUrl = "https://raw.githubusercontent.com/shivharebhoomi07/FlutterControllerApp/main/assets/logo.png";
      
      // Your Exact KML Structure
      final String kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>Logos</name>
    <ScreenOverlay>
      <name>Logo</name>
      <Icon>
        <href>$logoUrl</href>
      </Icon>
      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
      <screenXY x="0.02" y="0.95" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <size x="300" y="300" xunits="pixels" yunits="pixels"/>
    </ScreenOverlay>
  </Document>
</kml>''';

      // Upload to the specific Slave KML path
      // e.g. /var/www/html/kml/slave_3.kml
      await _sshService.uploadKml(kml, 'kml/slave_$targetScreen.kml');
      
    } catch (e) {
      throw LGException('Failed to show logo on screen: $e');
    }
  }

  @override
  Future<void> clearLogo() async {
    try {
      final int targetScreen = await _getLeftScreen();
      
      // Blank KML to clear the overlay
      const String blankKml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
  </Document>
</kml>''';

      await _sshService.uploadKml(blankKml, 'kml/slave_$targetScreen.kml');
    } catch (e) {
      throw LGException('Failed to clear logo: $e');
    }
  }

  @override
  Future<void> flyToHome() async {
    try {
      await _query(
        'flytoview=<LookAt>'
        '<longitude>77.2090</longitude>'
        '<latitude>28.6139</latitude>'
        '<range>10000</range>'
        '<tilt>0</tilt>'
        '<heading>0</heading>'
        '</LookAt>',
      );
    } catch (e) {
      throw LGException('Failed to fly home: $e');
    }
  }

  @override
  Future<void> sendKML() async {
    try {
      const kml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Placemark>
    <name>Google HQ</name>
    <Point>
      <coordinates>-122.084,37.422,0</coordinates>
    </Point>
  </Placemark>
</kml>''';

      await _sshService.uploadKml(kml, 'kml/slave_2.kml');
      await _sshService.uploadKml(kml, 'kml/slave_3.kml');
      await _sshService.uploadKml(kml, 'kml2.kml');
      await _sshService.execute("echo 'http://localhost:81/kml2.kml' > /var/www/html/kmls.txt");

      await Future.delayed(const Duration(milliseconds: 1000));
      await _query(
        'flytoview=<LookAt>'
        '<longitude>-122.084</longitude>'
        '<latitude>37.422</latitude>'
        '<range>1000</range>'
        '<tilt>60</tilt>'
        '<heading>0</heading>'
        '</LookAt>',
      );
    } catch (e) {
      throw LGException('Failed to send KML: $e');
    }
  }

  @override
  Future<void> clearKml() async {
    try {
      await _query('exittour=true');
      await _sshService.execute('> /var/www/html/kmls.txt');

      const blankKml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>''';
      
      await _sshService.uploadKml(blankKml, 'kml/slave_2.kml');
      await _sshService.uploadKml(blankKml, 'kml/slave_3.kml');
      
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw LGException('Failed to clear KML: $e');
    }
  }

  @override
  Future<void> reboot() async {
    try {
      await _sshService.execute('echo "123456" | sudo -S reboot');
    } catch (e) {
      throw LGException('Failed to reboot: $e');
    }
  }

  @override
  Future<void> shutdown() async {
    try {
      await _sshService.execute('echo "123456" | sudo -S poweroff');
    } catch (e) {
      throw LGException('Failed to shutdown: $e');
    }
  }

  @override
  Future<void> relaunch() async {
    try {
      const String relaunchCommand = """
        export DISPLAY=:0
        /home/lg/bin/lg-relaunch > /home/lg/lg-relaunch.log 2>&1 &
      """;
      await _sshService.execute(relaunchCommand);
    } catch (e) {
      throw LGException('Failed to relaunch: $e');
    }
  }
}
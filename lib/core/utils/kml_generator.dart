// import 'dart:math';

// class KMLGenerator {
//   // -- KML Structure Constants --
//   static const String _kmlHeader = '''<?xml version="1.0" encoding="UTF-8"?>
// <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
//   <Document>''';

//   static const String _kmlFooter = '''  </Document>
// </kml>''';

//   /// Generates the KML for a Screen Overlay (Logo).
//   /// [imageUrl]: The URL where the image is hosted (or a local path on the LG machine).
//   static String generateLogoKML(String imageUrl) {
//     return '''$_kmlHeader
//     <name>Logo</name>
//     <ScreenOverlay>
//       <name>LogoOverlay</name>
//       <Icon>
//         <href>$imageUrl</href>
//       </Icon>
//       <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
//       <screenXY x="0.02" y="0.95" xunits="fraction" yunits="fraction"/>
//       <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
//       <size x="0.1" y="0" xunits="fraction" yunits="fraction"/>
//     </ScreenOverlay>
// $_kmlFooter''';
//   }

//   /// Generates a blank KML to clear the screen (removes logos/placemarks).
//   static String generateBlankKML() {
//     return '$_kmlHeader$_kmlFooter';
//   }

//   /// Generates a 'LookAt' string specifically formatted for the `flytoview` command.
//   /// Note: This does NOT return a full KML file, but a command string for query.txt.
//   static String generateFlyTo(
//     double lat,
//     double lng,
//     double altitude,
//     double tilt,
//     double heading,
//   ) {
//     return 'flytoview=<LookAt>'
//         '<longitude>$lng</longitude>'
//         '<latitude>$lat</latitude>'
//         '<altitude>$altitude</altitude>'
//         '<heading>$heading</heading>'
//         '<tilt>$tilt</tilt>'
//         '<range>1000</range>'
//         '<gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode>'
//         '</LookAt>';
//   }

//   /// Generates a robust Orbit KML using gx:Tour (The "Professional" way).
//   /// This creates a smooth cinematic circle around a point.
//   static String generateOrbitKML(
//     double centerLat,
//     double centerLng,
//     double range,
//     double tilt,
//     double altitude,
//   ) {
//     String tour = '';
//     int heading = 0;
//     int steps = 36; // 36 steps * 10 degrees = 360 degrees

//     // Construct the Playlist
//     tour += '<gx:Tour><name>Orbit</name><gx:Playlist>';

//     for (int i = 0; i <= steps; i++) {
//       heading = i * 10;
//       tour += '''
//       <gx:FlyTo>
//         <gx:duration>1.0</gx:duration>
//         <gx:flyToMode>smooth</gx:flyToMode>
//         <LookAt>
//           <longitude>$centerLng</longitude>
//           <latitude>$centerLat</latitude>
//           <altitude>$altitude</altitude>
//           <heading>$heading</heading>
//           <tilt>$tilt</tilt>
//           <range>$range</range>
//           <gx:altitudeMode>relativeToGround</gx:altitudeMode>
//         </LookAt>
//       </gx:FlyTo>''';
//     }

//     tour += '</gx:Playlist></gx:Tour>';

//     return '$_kmlHeader$tour$_kmlFooter';
//   }
// }

import 'dart:math';

class KMLGenerator {
  // -- KML Structure Constants --
  static const String _kmlHeader = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>''';

  static const String _kmlFooter = '''  </Document>
</kml>''';

  /// Helper to wrap any inner KML content (like Placemarks or Tours) 
  /// with the required Liquid Galaxy XML header and footer.
  static String wrapInDocument(String innerKml) {
    return '$_kmlHeader\n$innerKml\n$_kmlFooter';
  }

  /// Generates a blank KML to clear the screen (removes logos/placemarks).
  static String generateBlankKML() {
    return '$_kmlHeader$_kmlFooter';
  }

  /// Generates the KML for a Screen Overlay (e.g., a Logo).
  /// [imageUrl]: The URL where the image is hosted (or a local path on the LG machine).
  static String generateLogoKML(String imageUrl) {
    String overlay = '''
    <name>Logo</name>
    <ScreenOverlay>
      <name>LogoOverlay</name>
      <Icon>
        <href>$imageUrl</href>
      </Icon>
      <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
      <screenXY x="0.02" y="0.95" xunits="fraction" yunits="fraction"/>
      <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
      <size x="0.1" y="0" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>''';
    
    return wrapInDocument(overlay);
  }

  /// Generates a 'LookAt' string specifically formatted for the `flytoview` command.
  /// NOTE: Send this to `/tmp/query.txt`, NOT `kmls.txt`.
  static String generateFlyTo(
    double lat,
    double lng,
    double altitude,
    double tilt,
    double heading,
  ) {
    return 'flytoview=<LookAt>'
        '<longitude>$lng</longitude>'
        '<latitude>$lat</latitude>'
        '<altitude>$altitude</altitude>'
        '<heading>$heading</heading>'
        '<tilt>$tilt</tilt>'
        '<range>2000</range>'
        '<gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode>'
        '</LookAt>';
  }

  /// Generates a single Placemark for an Earthquake.
  /// To display this on the Rig, generate it, then pass it through [wrapInDocument].
  static String generateEarthquakePlacemark(
    double lat,
    double lng,
    String magnitude,
    String title,
  ) {
    return '''
    <Placemark>
      <name>$title</name>
      <description><![CDATA[
        <h2>Earthquake Details</h2>
        <p><b>Magnitude:</b> $magnitude</p>
        <p><b>Coordinates:</b> $lat, $lng</p>
      ]]></description>
      <Point>
        <coordinates>$lng,$lat,0</coordinates>
      </Point>
    </Placemark>''';
  }

  /// Generates a robust Orbit KML using gx:Tour (The "Professional" way).
  /// This creates a smooth cinematic circle around a point.
  static String generateOrbitKML(
    double centerLat,
    double centerLng,
    double range,
    double tilt,
    double altitude,
  ) {
    String tour = '<gx:Tour><name>Orbit</name><gx:Playlist>';
    int steps = 36; // 36 steps * 10 degrees = 360 degrees

    for (int i = 0; i <= steps; i++) {
      int heading = i * 10;
      tour += '''
      <gx:FlyTo>
        <gx:duration>1.0</gx:duration>
        <gx:flyToMode>smooth</gx:flyToMode>
        <LookAt>
          <longitude>$centerLng</longitude>
          <latitude>$centerLat</latitude>
          <altitude>$altitude</altitude>
          <heading>$heading</heading>
          <tilt>$tilt</tilt>
          <range>$range</range>
          <gx:altitudeMode>relativeToGround</gx:altitudeMode>
        </LookAt>
      </gx:FlyTo>''';
    }

    tour += '</gx:Playlist></gx:Tour>';

    return wrapInDocument(tour);
  }

  /// Generates the command to START the orbit we just uploaded.
  /// NOTE: Send this to `/tmp/query.txt` immediately after uploading the Orbit KML.
  static String generateOrbitStartCommand() {
    return 'playtour=Orbit';
  }
}
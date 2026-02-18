class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // -- UI Strings --
  static const String appTitle = 'LG Starter Kit';
  static const String connectionPageTitle = 'Connect to Galaxy';
  static const String dashboardPageTitle = 'LG Controller';

  // -- Connection Defaults (Standard LG Setup) --
  static const String defaultIp = '192.168.0.100';
  static const int defaultPort = 22;
  static const String defaultUsername = 'lg';
  static const String defaultPassword = 'lg';

  // -- Liquid Galaxy System Paths --
  // The folder on the Master machine where KMLs/assets must be placed to be visible
  static const String lgWebRoot = '/var/www/html';
  
  // The file Liquid Galaxy watches for movement commands
  static const String lgQueryFile = '/tmp/query.txt';
  
  // The file Liquid Galaxy watches for KML loading
  static const String lgKmlSyncFile = '/var/www/html/kmls.txt';

  // -- Local Asset Paths --
  static const String logoAsset = 'assets/images/logo.png'; // Ensure you have a logo here
}
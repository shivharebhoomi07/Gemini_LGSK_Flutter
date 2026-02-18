/// Interface defining the contract for Dashboard operations.
/// This ensures your business logic (BLoC) is decoupled from the data implementation.
abstract class DashboardRepositoryInterface {
  
  // -- Presentation Controls --
  Future<void> showLogo();
  Future<void> clearLogo();

  // -- Content Controls (Task 2) --
  Future<void> sendKML();
  Future<void> clearKml();

  // -- Navigation Controls --
  Future<void> flyToHome();

  // -- System Controls --
  Future<void> reboot();
  Future<void> shutdown();
  Future<void> relaunch();
}
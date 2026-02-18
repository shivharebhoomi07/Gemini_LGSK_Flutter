import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

// --- Basic Task 2 Events (Content) ---

class ShowLogoEvent extends DashboardEvent {}

class ClearLogoEvent extends DashboardEvent {}

class FlyToHomeEvent extends DashboardEvent {}

class SendKmlEvent extends DashboardEvent {}   // <--- The new event for "Send KML"

class ClearKmlEvent extends DashboardEvent {}  // <--- The new event for "Clear KML"

// --- System Events (Admin Controls) ---

class ShutdownEvent extends DashboardEvent {}

class RebootEvent extends DashboardEvent {}

class RelaunchEvent extends DashboardEvent {}
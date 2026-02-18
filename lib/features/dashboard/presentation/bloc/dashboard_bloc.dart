import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Corrected Absolute Imports
import 'package:lg_star_command/features/dashboard/data/dashboard_repository.dart';
import 'package:lg_star_command/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:lg_star_command/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _repository;

  DashboardBloc(this._repository) : super(DashboardInitial()) {
    
    // --- Logos ---
    on<ShowLogoEvent>((event, emit) async {
      await _performAction(emit, _repository.showLogo, "Logo Shown on Galaxy");
    });
    
    on<ClearLogoEvent>((event, emit) async {
      await _performAction(emit, _repository.clearLogo, "Logo Cleared");
    });

    // --- KMLs (Task 2) ---
    on<SendKmlEvent>((event, emit) async {
      await _performAction(emit, _repository.sendKML, "KML Sent (Google HQ)");
    });
    
    on<ClearKmlEvent>((event, emit) async {
      await _performAction(emit, _repository.clearKml, "All KMLs Cleared");
    });

    // --- Navigation ---
    on<FlyToHomeEvent>((event, emit) async {
      await _performAction(emit, _repository.flyToHome, "Flying to Home City...");
    });

    // --- System ---
    on<ShutdownEvent>((event, emit) async {
      await _performAction(emit, _repository.shutdown, "Shutting Down LG...");
    });
    
    on<RebootEvent>((event, emit) async {
      await _performAction(emit, _repository.reboot, "Rebooting LG...");
    });
    
    on<RelaunchEvent>((event, emit) async {
      await _performAction(emit, _repository.relaunch, "Relaunching Interface...");
    });
  }

  // Helper function to reduce code duplication for simple async actions
  Future<void> _performAction(
    Emitter<DashboardState> emit,
    Future<void> Function() action,
    String successMsg,
  ) async {
    emit(DashboardLoading());
    try {
      await action();
      emit(DashboardSuccess(successMsg));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
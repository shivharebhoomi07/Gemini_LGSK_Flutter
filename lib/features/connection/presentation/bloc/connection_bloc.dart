import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Corrected Absolute Imports
import 'package:lg_star_command/features/connection/data/connection_repo.dart';
import 'package:lg_star_command/core/models/connection_params_model.dart';
abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();
  @override
  List<Object> get props => [];
}

class ConnectEvent extends ConnectionEvent {
  final ConnectionParams params;
  const ConnectEvent(this.params);
  @override
  List<Object> get props => [params];
}

class DisconnectEvent extends ConnectionEvent {}

class CheckConnectionEvent extends ConnectionEvent {}

// --- STATES ---
abstract class ConnectionState extends Equatable {
  const ConnectionState();
  @override
  List<Object> get props => [];
}

class ConnectionInitial extends ConnectionState {}

class ConnectionLoading extends ConnectionState {}

class ConnectionSuccess extends ConnectionState {
  final ConnectionParams params;
  const ConnectionSuccess(this.params);
  @override
  List<Object> get props => [params];
}

class ConnectionFailure extends ConnectionState {
  final String error;
  const ConnectionFailure(this.error);
  @override
  List<Object> get props => [error];
}

class ConnectionDisconnected extends ConnectionState {}

// --- BLOC ---
class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final ConnectionRepository _repository;

  ConnectionBloc(this._repository) : super(ConnectionInitial()) {
    on<ConnectEvent>(_onConnect);
    on<DisconnectEvent>(_onDisconnect);
    on<CheckConnectionEvent>(_onCheckConnection);
  }

  Future<void> _onConnect(ConnectEvent event, Emitter<ConnectionState> emit) async {
    emit(ConnectionLoading());
    try {
      await _repository.connect(event.params);
      emit(ConnectionSuccess(event.params));
    } catch (e) {
      emit(ConnectionFailure(e.toString()));
    }
  }

  Future<void> _onDisconnect(DisconnectEvent event, Emitter<ConnectionState> emit) async {
    emit(ConnectionLoading());
    try {
      await _repository.disconnect();
      emit(ConnectionDisconnected());
    } catch (e) {
      emit(ConnectionFailure("Failed to disconnect: $e"));
    }
  }

  Future<void> _onCheckConnection(CheckConnectionEvent event, Emitter<ConnectionState> emit) async {
    // Check if we have saved credentials and try to reconnect automatically
    // or just check the current status.
    if (_repository.isConnected) {
       final params = await _repository.getSavedConnectionParams();
       if (params != null) {
         emit(ConnectionSuccess(params));
       }
    } else {
      // Try to load saved params to pre-fill the UI
      final params = await _repository.getSavedConnectionParams();
      if (params != null) {
        // We found saved params, but we are not connected yet.
        // We could emit a specific state like 'ConnectionReady' to fill text fields
        // For now, staying in Initial is fine, UI can read repo directly or use a separate event.
      }
    }
  }
}
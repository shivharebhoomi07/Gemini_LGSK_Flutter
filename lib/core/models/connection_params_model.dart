import 'package:equatable/equatable.dart';

class ConnectionParams extends Equatable {
  final String host;
  final int port;
  final String username;
  final String password;
  final int screens;

  const ConnectionParams({
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    this.screens = 3,
  });

  @override
  List<Object> get props => [host, port, username, password, screens];

  // Helper to convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
      'username': username,
      'password': password,
      'screens': screens,
    };
  }

  // Helper to create from JSON
  factory ConnectionParams.fromJson(Map<String, dynamic> json) {
    return ConnectionParams(
      host: json['host'] ?? '',
      port: json['port'] ?? 22,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      screens: json['screens'] ?? 3,
    );
  }
}
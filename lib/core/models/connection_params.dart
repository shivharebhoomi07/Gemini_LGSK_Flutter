import 'package:equatable/equatable.dart';

class ConnectionParams extends Equatable {
  final String host;
  final int port;
  final String username;
  final String password;

  const ConnectionParams({
    required this.host,
    required this.port,
    required this.username,
    required this.password,
  });

  // Allows creating a copy of this object with updated fields
  // Useful if the user only changes the IP but keeps the password
  ConnectionParams copyWith({
    String? host,
    int? port,
    String? username,
    String? password,
  }) {
    return ConnectionParams(
      host: host ?? this.host,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [host, port, username, password];
  
  @override
  String toString() => 'ConnectionParams(host: $host, port: $port, user: $username)';
}
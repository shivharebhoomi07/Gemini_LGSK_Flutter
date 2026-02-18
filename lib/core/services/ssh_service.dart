import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/foundation.dart';

import 'package:lg_star_command/core/models/connection_params_model.dart';
import 'package:lg_star_command/core/failures/lg_exception.dart';

class SSHService {
  SSHClient? _client;

  // Check if currently connected
  bool get isConnected => _client != null && !(_client?.isClosed ?? true);

  // Connect to the Liquid Galaxy rig
  Future<void> connect(ConnectionParams params) async {
    try {
      final socket = await SSHSocket.connect(
        params.host,
        params.port,
        timeout: const Duration(seconds: 10),
      );

      _client = SSHClient(
        socket,
        username: params.username,
        onPasswordRequest: () => params.password,
      );
      
      // Wait for the authenticated state
      await _client?.authenticated;
      debugPrint('SSH Connected to ${params.host}');
    } catch (e) {
      debugPrint('SSH Connection Failed: $e');
      throw LGException('Failed to connect: $e');
    }
  }

  // Disconnect safely
  Future<void> disconnect() async {
    _client?.close();
    _client = null;
    debugPrint('SSH Disconnected');
  }

  // Execute a command and return the session
  Future<SSHSession?> execute(String command) async {
    if (!isConnected) {
      throw LGException('Not connected to LG Rig');
    }

    try {
      final session = await _client!.execute(command);
      
      // --- THE FIX IS HERE ---
      // We cast the stream to <List<int>> so the decoder accepts it.
      
      session.stdout
          .cast<List<int>>()
          .transform(const Utf8Decoder())
          .listen((data) => debugPrint('STDOUT: $data'));

      session.stderr
          .cast<List<int>>()
          .transform(const Utf8Decoder())
          .listen((data) => debugPrint('STDERR: $data'));
          
      return session;
    } catch (e) {
      debugPrint('SSH Execution Failed: $e');
      throw LGException('Command failed: $e');
    }
  }

  // Upload a KML file (Helper)
  Future<void> uploadKml(String content, String filename) async {
    if (!isConnected) return;
    
    try {
      final sftp = await _client!.sftp();
      final file = await sftp.open('/var/www/html/$filename', mode: SftpFileOpenMode.write | SftpFileOpenMode.create | SftpFileOpenMode.truncate);
      await file.write(Stream.value(utf8.encode(content) as Uint8List));
      await file.close();
    } catch (e) {
      // Fallback if SFTP fails: use echo
      // Note: This is less robust for large files but works for simple strings
      await execute("echo '$content' > /var/www/html/$filename");
    }
  }
}
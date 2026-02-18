import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import your Core Services
import 'package:lg_star_command/core/services/ssh_service.dart';
import 'package:lg_star_command/core/services/settings_service.dart';
import 'package:lg_star_command/core/theme/app_theme.dart';

// Import Connection Features
import 'package:lg_star_command/features/connection/data/connection_repo.dart';
import 'package:lg_star_command/features/connection/presentation/bloc/connection_bloc.dart';
import 'package:lg_star_command/features/connection/presentation/pages/connection_page.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LGStarterKitApp());
}

class LGStarterKitApp extends StatelessWidget {
  const LGStarterKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Initialize Services
    // We create these here so they exist for the entire lifetime of the app.
    final sshService = SSHService();
    final settingsService = SettingsService();

    // 2. Initialize Repository
    // The repo needs the services to do its job.
    final connectionRepo = ConnectionRepository(sshService, settingsService);

    return MultiRepositoryProvider(
      providers: [
        // Make SSHService available to the entire app
        RepositoryProvider<SSHService>.value(value: sshService),
        
        // --- THE FIX IS HERE ---
        // We must provide SettingsService so DashboardPage can find it!
        RepositoryProvider<SettingsService>.value(value: settingsService),
        
        // Make ConnectionRepo available
        RepositoryProvider<ConnectionRepository>.value(value: connectionRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          // We provide the ConnectionBloc at the very top.
          BlocProvider(
            create: (context) => ConnectionBloc(connectionRepo)..add(CheckConnectionEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'LG Starter Kit',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme, 
          home: const ConnectionPage(), 
        ),
      ),
    );
  }
}
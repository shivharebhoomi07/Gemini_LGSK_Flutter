import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_star_command/core/services/ssh_service.dart';
import 'package:lg_star_command/core/services/settings_service.dart';
import 'package:lg_star_command/features/dashboard/data/dashboard_repository.dart';
import 'package:lg_star_command/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:lg_star_command/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:lg_star_command/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:lg_star_command/features/connection/presentation/pages/connection_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sshService = context.read<SSHService>();
    final settingsService = context.read<SettingsService>();
    
    return BlocProvider(
      create: (context) => DashboardBloc(
        DashboardRepository(sshService, settingsService)
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LG Controller'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () async {
              await sshService.disconnect();
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ConnectionPage()),
                );
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync_disabled_rounded, color: Colors.redAccent),
              tooltip: 'Disconnect',
              onPressed: () async {
                await sshService.disconnect();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const ConnectionPage()),
                  );
                }
              },
            ),
          ],
        ),
        body: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DashboardSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message), 
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is DashboardError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error), 
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Task 2 Controls", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.4,
                    children: [
                      _DashboardButton(
                        title: "Show Logo",
                        icon: Icons.image,
                        color: Colors.blue,
                        onTap: () => context.read<DashboardBloc>().add(ShowLogoEvent()),
                      ),
                      _DashboardButton(
                        title: "Clear Logo",
                        icon: Icons.hide_image,
                        color: Colors.orange,
                        onTap: () => context.read<DashboardBloc>().add(ClearLogoEvent()),
                      ),
                      _DashboardButton(
                        title: "Send KML",
                        icon: Icons.send,
                        color: Colors.pink,
                        onTap: () => context.read<DashboardBloc>().add(SendKmlEvent()),
                      ),
                      _DashboardButton(
                        title: "Clear KML",
                        icon: Icons.layers_clear,
                        color: Colors.amber,
                        onTap: () => context.read<DashboardBloc>().add(ClearKmlEvent()),
                      ),
                      _DashboardButton(
                        title: "Fly Home",
                        icon: Icons.flight_takeoff,
                        color: Colors.green,
                        onTap: () => context.read<DashboardBloc>().add(FlyToHomeEvent()),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "System Controls", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                       _DashboardButton(
                        title: "Relaunch",
                        icon: Icons.refresh,
                        color: Colors.purple,
                        isSmall: true,
                        onTap: () => context.read<DashboardBloc>().add(RelaunchEvent()),
                      ),
                      _DashboardButton(
                        title: "Reboot",
                        icon: Icons.restart_alt,
                        color: Colors.deepOrange,
                        isSmall: true,
                        onTap: () => context.read<DashboardBloc>().add(RebootEvent()),
                      ),
                      _DashboardButton(
                        title: "Shutdown",
                        icon: Icons.power_settings_new,
                        color: Colors.red,
                        isSmall: true,
                        onTap: () => context.read<DashboardBloc>().add(ShutdownEvent()),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- MISSING WIDGET CLASS ADDED BACK HERE ---
class _DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isSmall;

  const _DashboardButton({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        color: color.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withOpacity(0.5), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: isSmall ? 32 : 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmall ? 14 : 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
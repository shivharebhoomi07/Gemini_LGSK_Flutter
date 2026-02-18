// import 'package:flutter/material.dart' hide ConnectionState;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lg_star_command/core/theme/app_theme.dart';
// import 'package:lg_star_command/core/models/connection_params_model.dart';
// import 'package:lg_star_command/features/connection/presentation/bloc/connection_bloc.dart';
// import 'package:lg_star_command/features/dashboard/presentation/pages/dashboard_page.dart';

// class ConnectionPage extends StatefulWidget {
//   const ConnectionPage({super.key});

//   @override
//   State<ConnectionPage> createState() => _ConnectionPageState();
// }

// class _ConnectionPageState extends State<ConnectionPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _hostController = TextEditingController();
//   final _portController = TextEditingController(text: '22');
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _screensController = TextEditingController(text: '3');
//   bool _isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // --- 1. UPDATED APP BAR TITLE ---
//       appBar: AppBar(
//         title: const Text("Liquid Galaxy"),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: true, // Makes the background go behind the app bar
//       body: BlocConsumer<ConnectionBloc, ConnectionState>(
//         listener: (context, state) {
//           if (state is ConnectionSuccess) {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (_) => const DashboardPage()),
//             );
//           } else if (state is ConnectionFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error),
//                 backgroundColor: Colors.redAccent,
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is ConnectionLoading;

//           return Container(
//             // Background Gradient
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xFF1E1E2C), Color(0xFF0F0F1A)],
//               ),
//             ),
//             child: Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // --- HEADER ICON ---
//                       const Icon(
//                         Icons.rocket_launch_rounded,
//                         size: 80,
//                         color: Colors.blueAccent,
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         "Mission Control",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         "Enter Rig Coordinates",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.white54),
//                       ),
//                       const SizedBox(height: 40),

//                       // --- INPUT FIELDS ---
                      
//                       // Row 1: Host and Port
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: _buildTextField(
//                               controller: _hostController,
//                               label: 'IP Address',
//                               icon: Icons.wifi,
//                               hint: '192.168.x.x',
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             flex: 1,
//                             child: _buildTextField(
//                               controller: _portController,
//                               label: 'Port',
//                               icon: Icons.dns,
//                               isNumber: true,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Row 2: Username
//                       _buildTextField(
//                         controller: _usernameController,
//                         label: 'Username',
//                         icon: Icons.person,
//                         hint: 'lg',
//                       ),
//                       const SizedBox(height: 16),

//                       // Row 3: Password
//                       _buildTextField(
//                         controller: _passwordController,
//                         label: 'Password',
//                         icon: Icons.lock,
//                         isPassword: true,
//                       ),
//                       const SizedBox(height: 16),
                      
//                       // Row 4: Screen Count (for your custom logic)
//                       _buildTextField(
//                         controller: _screensController,
//                         label: 'Total Screens',
//                         icon: Icons.monitor,
//                         isNumber: true,
//                         hint: '3',
//                       ),

//                       const SizedBox(height: 40),

//                       // --- 2. UPDATED BUTTON ---
//                       SizedBox(
//                         height: 56,
//                         child: ElevatedButton.icon(
//                           onPressed: isLoading ? null : _onConnectPressed,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueAccent,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 5,
//                             shadowColor: Colors.blueAccent.withOpacity(0.4),
//                           ),
//                           // Show loading spinner OR the text/icon
//                           icon: isLoading 
//                               ? const SizedBox.shrink() 
//                               : const Icon(Icons.power_settings_new),
//                           label: isLoading
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : const Text(
//                                   "Connect to Liquid Galaxy",
//                                   style: TextStyle(
//                                     fontSize: 18, 
//                                     fontWeight: FontWeight.bold
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // --- Helper Widget for cleaner TextFields ---
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     String? hint,
//     bool isPassword = false,
//     bool isNumber = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword && !_isPasswordVisible,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         prefixIcon: Icon(icon, color: Colors.blueAccent),
//         suffixIcon: isPassword
//             ? IconButton(
//                 icon: Icon(
//                   _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                   color: Colors.grey,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _isPasswordVisible = !_isPasswordVisible;
//                   });
//                 },
//               )
//             : null,
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.05),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.blueAccent),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Required';
//         }
//         return null;
//       },
//     );
//   }

//   void _onConnectPressed() {
//     if (_formKey.currentState!.validate()) {
//       final params = ConnectionParams(
//         host: _hostController.text,
//         port: int.parse(_portController.text),
//         username: _usernameController.text,
//         password: _passwordController.text,
//         screens: int.parse(_screensController.text),
//       );
//       context.read<ConnectionBloc>().add(ConnectEvent(params));
//     }
//   }
// }

import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lg_star_command/core/theme/app_theme.dart';
import 'package:lg_star_command/core/models/connection_params_model.dart';
import 'package:lg_star_command/features/connection/presentation/bloc/connection_bloc.dart';
import 'package:lg_star_command/features/connection/data/connection_repo.dart'; // Added for auto-fill
import 'package:lg_star_command/features/dashboard/presentation/pages/dashboard_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers initialized without hardcoded values (except defaults)
  final _hostController = TextEditingController();
  final _portController = TextEditingController(text: '22');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _screensController = TextEditingController(text: '3');
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Auto-fill credentials on startup
    _loadSavedCredentials();
  }

  /// Fetches saved data from the Repository and populates the text fields
  Future<void> _loadSavedCredentials() async {
    final repo = context.read<ConnectionRepository>();
    final savedParams = await repo.getSavedConnectionParams();

    if (savedParams != null) {
      setState(() {
        _hostController.text = savedParams.host;
        _portController.text = savedParams.port.toString();
        _usernameController.text = savedParams.username;
        _passwordController.text = savedParams.password;
        _screensController.text = savedParams.screens.toString();
      });
    }
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _screensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liquid Galaxy"), // Corrected Title
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true, 
      body: BlocConsumer<ConnectionBloc, ConnectionState>(
        listener: (context, state) {
          if (state is ConnectionSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            );
          } else if (state is ConnectionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ConnectionLoading;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1E1E2C), Color(0xFF0F0F1A)],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.rocket_launch_rounded,
                        size: 80,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Mission Control",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Enter Rig Coordinates",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white54),
                      ),
                      const SizedBox(height: 40),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildTextField(
                              controller: _hostController,
                              label: 'IP Address',
                              icon: Icons.wifi,
                              hint: '192.168.x.x',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: _buildTextField(
                              controller: _portController,
                              label: 'Port',
                              icon: Icons.dns,
                              isNumber: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _usernameController,
                        label: 'Username',
                        icon: Icons.person,
                        hint: 'lg',
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      
                      _buildTextField(
                        controller: _screensController,
                        label: 'Total Screens',
                        icon: Icons.monitor,
                        isNumber: true,
                        hint: '3',
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: isLoading ? null : _onConnectPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: Colors.blueAccent.withOpacity(0.4),
                          ),
                          icon: isLoading 
                              ? const SizedBox.shrink() 
                              : const Icon(Icons.power_settings_new),
                          label: isLoading
                              ? const SizedBox(
                                  height: 20, 
                                  width: 20, 
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                                )
                              : const Text(
                                  "Connect to Liquid Galaxy", // Corrected Button Label
                                  style: TextStyle(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    bool isPassword = false,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }

  void _onConnectPressed() {
    if (_formKey.currentState!.validate()) {
      final params = ConnectionParams(
        host: _hostController.text,
        port: int.parse(_portController.text),
        username: _usernameController.text,
        password: _passwordController.text,
        screens: int.parse(_screensController.text),
      );
      context.read<ConnectionBloc>().add(ConnectEvent(params));
    }
  }
}
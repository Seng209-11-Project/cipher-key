import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../app_navigation_bar/protein_bar.dart';
import '../l10n/app_localizations.dart';

class AuthGuard extends StatefulWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> with WidgetsBindingObserver {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _authenticate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      setState(() {
        _isAuthenticated = false;
      });
    }
    else if (state == AppLifecycleState.resumed) {
      setState(() {
        _isAuthenticated = true;
      });
    }
  }

  Future<bool> _authenticate() async {
    final t = AppLocalizations.of(context)!;
    final LocalAuthentication auth = LocalAuthentication();

    try {
      return await auth.authenticate(
        localizedReason: t.requireFingerprint,
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      proteinBarM(context, t.authFailed, icon: Icons.error);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
      if (_isAuthenticated) {
        return widget.child;
      }
      else {
        return Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 256,
                  height: 256,
                  child: Image.asset("assets/icon.png"),
                ),
                const Text("CipherKey", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 25),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.grey),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  onPressed: _authenticate,
                  child: Text(AppLocalizations.of(context)!.authenticateButton),
                ),
              ],
            ),
          ),
        );
      }
  }
      }

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticate();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _authenticate() async {
    final t = AppLocalizations.of(context)!;

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: t.requireFingerprint,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true, 
        ),
      );

      if (didAuthenticate && mounted) {
        setState(() {
          _isAuthenticated = true;
        });
      }
    } on PlatformException catch (e) {
      if (mounted) {
        proteinBarM(context, t.authFailed, icon: Icons.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (_isAuthenticated) {
      return widget.child;
    } else {
      return Scaffold(
        backgroundColor: cs.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(55),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        color: cs.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Image.asset("assets/icon.png")
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "CipherKey",
                      style: TextStyle(
                        color: cs.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Used safe accessor ? in case l10n isn't ready
                    Text(
                      AppLocalizations.of(context)?.fingerprintDescription ?? "Authentication required",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: cs.secondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton.icon(
                        style: ButtonStyle(
                          foregroundColor:
                          WidgetStateProperty.all<Color>(cs.onPrimary),
                          backgroundColor:
                          WidgetStateProperty.all<Color>(cs.primary),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: _authenticate,
                        icon: const Icon(Icons.fingerprint),
                        label: Text(
                          AppLocalizations.of(context)?.authenticateButton ?? "Authenticate",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
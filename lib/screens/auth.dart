import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Localauth {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    try {
      return await _auth.authenticate(
          localizedReason: 'Scan to Authenticate',
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      return false;
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/login_repository.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isOtpSent = false;
  bool _isVerified = false;
  bool _canResend = true;
  int _resendTime = 30;
  Timer? _timer; // ✅ Timer instance

  bool get isOtpSent => _isOtpSent;
  bool get isVerified => _isVerified;
  bool get canResend => _canResend;
  int get resendTime => _resendTime;

  /// Registers a user and starts the OTP resend timer
  Future<void> registerUser(String mobile) async {
    try {
      bool success = await Apiservice.registerUser(mobile);
      if (success) {
        _isOtpSent = true;
        startResendTimer();
        notifyListeners();
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  /// Verifies OTP and saves session in SharedPreferences
  Future<void> verifyOtp(String mobile, String otp) async {
    try {
      bool success = await Apiservice.verifyOtp(mobile, otp);
      if (success) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_mobile", mobile);
        _isVerified = true;
        notifyListeners();
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  /// Starts the resend OTP countdown timer
  void startResendTimer() {
    _resendTime = 30;
    _canResend = false;
    notifyListeners();

    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendTime > 0) {
        _resendTime--;
        notifyListeners();
      } else {
        _canResend = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  /// Resends OTP and restarts timer
  Future<void> resendOtp(String mobile) async {
    if (!_canResend) return; // Prevent multiple requests

    bool success = await Apiservice.registerUser(mobile); // Reuse register API to resend OTP
    if (success) {
      startResendTimer();
    }
  }

  /// Logs out user and resets state
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_mobile');

    _isVerified = false;
    _isOtpSent = false;
    _canResend = true;
    _resendTime = 30;
    _timer?.cancel(); // ✅ Stop timer
    notifyListeners();
  }
}

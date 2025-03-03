import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/login_repository.dart';




class AuthViewModel extends ChangeNotifier {
  bool _isOtpSent = false;
  bool _isVerified = false;
  bool _canResend = true;
  int _resendTime = 30;

  bool get isOtpSent => _isOtpSent;
  bool get isVerified => _isVerified;
  bool get canResend => _canResend;
  int get resendTime => _resendTime;

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

  void startResendTimer() {
    _resendTime = 30;
    _canResend = false;
    notifyListeners();

    Future.delayed(Duration(seconds: _resendTime), () {
      _canResend = true;
      notifyListeners();
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_mobile');
    _isVerified = false;
    _isOtpSent = false;
    notifyListeners();
  }
}


import 'package:fastbagproject/modules/main/splashsceen.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/view/home.dart';
import 'modules/home/view_model/category_view_model.dart';
import 'modules/login/view/Login.dart';
import 'modules/login/view/otp_verify.dart';
import 'modules/login/view_model/auth_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isLoggedIn = await checkUserLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}
Future<bool> checkUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  String? mobile = prefs.getString('user_mobile');
  return mobile != null && mobile.isNotEmpty; // Ensure user is logged in
}


class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OTP Login App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isLoggedIn ? HomeScreen() : Splashsceen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/otp': (context) => OtpVerificationScreen(mobileNumber: 'mobile_number'),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}


import 'package:fastbagproject/common/widget/bottom_nav_bar.dart';
import 'package:fastbagproject/modules/main/splashsceen.dart';
import 'package:fastbagproject/modules/shop/view_model/shoplist_view_model.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/Category/view/category_home.dart';
import 'modules/Category/view_model/category_view_model.dart';
import 'modules/login/view/Login.dart';
import 'modules/login/view/otp_verify.dart';
import 'modules/login/view_model/auth_view_model.dart';
import 'modules/shop/view_model/favoroite_view_model.dart';

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
        ChangeNotifierProvider(create: (_)=>StoreViewModel()..fetchStores()),
        // ChangeNotifierProvider(create: (_)=>FavoriteVendorViewModel()..fetchFavoriteVendors(vendorId: 1))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OTP Login App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isLoggedIn ? BottomNavExample() : Splashsceen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/otp': (context) => OtpVerificationScreen(mobileNumber: 'mobile_number'),
          '/home': (context) => CatecoryHomeScreen(),
        },
      ),
    );
  }
}

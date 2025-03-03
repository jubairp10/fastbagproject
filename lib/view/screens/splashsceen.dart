import 'dart:ui';

import 'package:flutter/material.dart';

import 'Login.dart';

class Splashsceen extends StatelessWidget {
  const Splashsceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/img/delicious-vietnamese-food-including-pho-ga-noodles-spring-rolls-white-table 1.png', // Replace with your image path
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black87.withOpacity(0), // Optional, to add color overlay
                  ),
                ),
              ],
            ),
          ),

          // Your content on top of the blurred image
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 250,),
              Center(child: Image.asset('assets/img/fastbag_logo-removebg-preview 1.png',height: 244,width: 314,)),
              SizedBox(height: 150,),
              Text(
                'FastBag brings food, groceries, and fashion together, making it easy to find everything you need in one place.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,

                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50,),
              InkWell(onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
                  child: CircleAvatar(backgroundColor: Colors.blue,radius: 33,child: Icon(Icons.arrow_forward_outlined),backgroundImage: AssetImage('assets/img/Ellipse 43.png'),))
            ],
          ),
         

        ],
      ),
    );
  }
}

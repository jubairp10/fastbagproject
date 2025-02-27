// import 'package:fastbagproject/view/home.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// import '../view/Categorys.dart';
// import '../view/Profile.dart';
// import '../view/shop.dart';
//
//
//
// class BottomNavExample extends StatefulWidget {
//   @override
//   _BottomNavExampleState createState() => _BottomNavExampleState();
// }
//
// class _BottomNavExampleState extends State<BottomNavExample> {
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Center(child: _getpage(_selectedIndex),) ,
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         decoration: BoxDecoration(color: Colors.white, boxShadow: [
//           BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1))
//         ]),
//         child: GNav(
//           gap: 8,
//           color: Colors.grey,
//           activeColor: Colors.blue,
//           tabBackgroundColor: Colors.blue.withOpacity(0.1),
//           padding: EdgeInsets.all(16),
//           tabs: [
//             GButton(icon: Icons.home, text: 'Home'),
//             GButton(icon: Icons.category, text: 'Categories'),
//             GButton(icon: Icons.shopping_cart, text: 'Cart'),
//             GButton(icon: Icons.person, text: 'Profile'),
//           ],
//           selectedIndex: _selectedIndex,
//           onTabChange: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
//   _getpage(int page){
//     switch(page){
//       case 0:
//         return HomeScreen();
//       case 1:
//         return Shop() ;
//       case  2:
//         return Categorys();
//       case 3:
//         return Account();
//     }
//   }
// }


import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:fastbagproject/view/home.dart';
import 'package:flutter/material.dart';

import '../view/Categorys.dart';
import '../view/Profile.dart';
import '../view/shop.dart';

class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  final NotchBottomBarController _controller = NotchBottomBarController();
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomeScreen(),
    Shop(),
    Categorys(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        blurOpacity: 10,
        blurFilterX: .5,
        blurFilterY: 10,
        bottomBarHeight: 12,
        elevation: 0,
        notchBottomBarController: _controller, // ✅ Corrected this
        notchColor: Colors.blue,
        kBottomRadius: 10.0,
        showLabel: true,
        bottomBarItems: [
          BottomBarItem( // ✅ Use BottomBarItem
            inActiveItem: Icon(Icons.home, color: Colors.grey),
            activeItem: Icon(Icons.home, color: Colors.white),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.category, color: Colors.grey),
            activeItem: Icon(Icons.category, color: Colors.white),
            itemLabel: 'Categories',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.shopping_cart, color: Colors.grey),
            activeItem: Icon(Icons.shopping_cart, color: Colors.white),
            itemLabel: 'Cart',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: Colors.grey),
            activeItem: Icon(Icons.person, color: Colors.white),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        }, kIconSize: 20,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }
}


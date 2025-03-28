//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../login/view/Login.dart';
// import '../../login/view_model/auth_view_model.dart';
//
// class Account extends StatefulWidget {
//   const Account({Key? key}) : super(key: key);
//
//   @override
//   State<Account> createState() => _AccountState();
// }
//
// class _AccountState extends State<Account> {
//   bool light=true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.white,
//         appBar: AppBar(title: Text('Profile'),),
//         body:SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[600]),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(crossAxisAlignment: CrossAxisAlignment.start,
//          
//                       children: [
//                         Container(height: 150,
//                           width: 150,
//                           // color: Colors.yellowAccent,
//                           child: Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius: 60,
//                               ),
//                               Positioned(bottom: 20
//                                   ,right: 30,
//                                   child: CircleAvatar(backgroundColor: Colors.blue,
//                                       child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 30,)))))
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 20,),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Jubair p',style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),),
//                             SizedBox(height: 10,),
//          
//                             Text('Jubi@gmail.com',style: TextStyle(fontSize: 20,color:Colors.white),),
//                             SizedBox(height: 10,),
//                             Text('20   ',style: TextStyle(fontSize: 20,color:Colors.white),),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//          
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add functionality for updating profile
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue, // Button background color
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     'Update Profile',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//          
//          
//          
//               ),
//          
//               const SizedBox(height: 32),
//               ListTile(
//                 leading: Icon(Icons.notifications, color: Colors.grey[600]),
//                 title: const Text("Notifications" ,style: TextStyle(fontSize: 18, color: Colors.grey)),
//                 onTap: () {},
//               ),
//               const Divider(),
//               ListTile(
//                   leading: Icon(Icons.dark_mode, color: Colors.grey[600]),
//                   title: const Text("Dark Mode", style: TextStyle(fontSize: 18, color: Colors.grey)),
//                   trailing:  Switch(
//                     // This bool value toggles the switch.
//                       value: light,
//                       activeColor: Colors.red,
//                       onChanged: (bool value) {
//                         // This is called when the user toggles the switch.
//                         setState(() {
//                           light = value;
//                         });})
//          
//               ),
//          
//               const Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.grey[600]),
//                 title: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.grey)),
//                 onTap: (){
//                   Provider.of<AuthViewModel>(context, listen: false).logout();
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                         (route) => false,
//                   );
//                 },
//               ),
//          
//             ],
//           ),
//         )
//     );
//   }
// }
import 'package:fastbagproject/constants/app_color.dart';
import 'package:fastbagproject/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../login/view/Login.dart';
import '../../login/view_model/auth_view_model.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.asset('assets/icon/Ellipse 3.png'),
              title: Text('Prethewram MR',style: MainFont(fontsize: 18, fontweight: FontWeight.w400, color: AppColors.black),),
            ),
            SizedBox(height: 10,),
            ListTile(
              leading:Icon(Icons.save),
              title: Text('Orders',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
            ),
            ListTile(
              leading:Icon(Icons.favorite),
              title: Text('Your Favorite',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
            ),
            ListTile(
              leading:Icon(Icons.wallet),
              title: Text('Wallet',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
            ),
            ListTile(
              leading:Icon(Icons.card_giftcard_rounded),
              title: Text('Send a Gift',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
            ),
            ListTile(
              leading:Icon(Icons.shopping_bag),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Buissness Preference',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
                  Text('Make work meals quicker and easier',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: Color(0xFF028BD2)),)
                ],
              )

            ),
            ListTile(
              leading:Icon(Icons.local_offer),
              title: Text('Promotion',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
            ),
            ListTile(
              leading:Icon(Icons.confirmation_num),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
                  Text('Make work meals quicker and easier',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: Color(0xFF028BD2)),)
                ],
              )
            ),
            ListTile(
              leading:Icon(Icons.shopping_bag),
              title: Text('Deliver With Uber',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
            ),
            ListTile(
              leading:Icon(Icons.settings),
              title: Text('Settigs',style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black),),
            ),
        ListTile(
                leading: Icon(Icons.logout, ),
                title:  Text("Logout", style: MainFont(fontsize: 14, fontweight: FontWeight.w500, color: AppColors.black)),
                onTap: (){
                  showDialog(context: (context), builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Logout'),
                      content:Text ("Are You Want Logout?"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Cancel')),
                        TextButton(onPressed: (){
                          Provider.of<AuthViewModel>(context,listen: false).logout();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                                (route) => false,
                          );
                        }, child: Text('Logout'))
                      ],
                    );
                  });

                },
              ),
            SizedBox(height: 5,),
            TextButton(onPressed: (){

            }, child: Text('About',style: MainFont(fontsize: 12, fontweight: FontWeight.w400, color: AppColors.black),))
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import 'Login.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool light=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Profile'),),
        body:SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[600]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          
                      children: [
                        Container(height: 150,
                          width: 150,
                          // color: Colors.yellowAccent,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                              ),
                              Positioned(bottom: 20
                                  ,right: 30,
                                  child: CircleAvatar(backgroundColor: Colors.blue,
                                      child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 30,)))))
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jubair p',style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
          
                            Text('Jubi@gmail.com',style: TextStyle(fontSize: 20,color:Colors.white),),
                            SizedBox(height: 10,),
                            Text('20   ',style: TextStyle(fontSize: 20,color:Colors.white),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for updating profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
          
          
          
              ),
          
              const SizedBox(height: 32),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.grey[600]),
                title: const Text("Notifications" ,style: TextStyle(fontSize: 18, color: Colors.grey)),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                  leading: Icon(Icons.dark_mode, color: Colors.grey[600]),
                  title: const Text("Dark Mode", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  trailing:  Switch(
                    // This bool value toggles the switch.
                      value: light,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          light = value;
                        });})
          
              ),
          
              const Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.grey[600]),
                title: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.grey)),
                onTap: (){
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                  );
                },
              ),
          
            ],
          ),
        )
    );
  }
}

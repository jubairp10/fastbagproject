
import 'package:fastbagproject/constants/app_color.dart';
import 'package:fastbagproject/constants/app_fonts.dart';
import 'package:fastbagproject/constants/dummydata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/category_view_model.dart';

class CatecoryHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double size=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 50),
            child: Container(height: 44,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none,suffixIcon: Icon(Icons.mic,color: Colors.white,),
                    prefixIcon: Icon(Icons.search,color: Colors.black,),labelText: 'food,shopping,drinks,etc',labelStyle: TextStyle(color: Colors.black)),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Recently Viewed", style: Normalfont3(fontsize: 16, fontweigt: FontWeight.w500, color: AppColors.black)),
          ),
          SizedBox(height: 10),

          // Top Categories (Horizontal Scroll)
          SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Dummydata().topCategories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(Dummydata().topCategories[index]["image"]!),
                        ),
                        SizedBox(height: 5),
                        Text(Dummydata().topCategories[index]["name"]!, style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  );
                },
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                // crossAxisSpacing: 4,
                // mainAxisSpacing: 4,
                // ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Text("All categories", style:  Normalfont3(fontsize: 16, fontweigt: FontWeight.w500, color: AppColors.black)),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30,right: 30,),
              child: Consumer<CategoryViewModel>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    print('No Data Fetch');
                    return Center(child: CircularProgressIndicator(

                    ));
                  }
                  return GridView.builder(
                    itemCount: provider.categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      return Container(
                        height: 139,
                        width: 166,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(category.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipRRect(borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    category.name,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      // backgroundColor: Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
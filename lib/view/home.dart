
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/service/category_provider.dart';







class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> topCategories = [
    {"name": "Healthy", "image": "assets/img/anna-pelzer-IGfIGP5ONV0-unsplash 1.png"},
    {"name": "Biriyani", "image": "assets/img/Biryani.png"},
    {"name": "Cake", "image": "assets/img/david-holifield-kPxsqUGneXQ-unsplash 1.png"},
    {"name": "Shawarma", "image": "assets/img/cindy-fernandez-iS8oyh-yMcM-unsplash 1 (1).png"},
    {"name": "Kids", "image": "assets/img/food-photographer-david-fedulov-E94j3rMcxlw-unsplash 1.png"},
    {"name": "Spices", "image":'assets/img/spices.jpg'},
    {"name": "Vegtable", "image":'assets/img/spices.jpg'},
    {"name":"Jean" , "image":'assets/img/jean.jpg'},
    {"name": "Drinks", "image":'assets/img/download (9).jpg'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      
      body: SafeArea(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none,suffixIcon: Icon(Icons.mic,color: Colors.white,),
                      prefixIcon: Icon(Icons.search,color: Colors.black,),labelText: 'food,shopping,drinks,etc',labelStyle: TextStyle(color: Colors.black)),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Top categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
              SizedBox(height: 10),
        
              // Top Categories (Horizontal Scroll)
              SizedBox(
                height: 310,
                child: GridView.builder(
        
                  itemCount: topCategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(topCategories[index]["image"]!),
                          ),
                          SizedBox(height: 5),
                          Text(topCategories[index]["name"]!, style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  ),
                ),
              ),
            SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("All categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Consumer<CategoryProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      itemCount: provider.categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (context, index) {
                        final category = provider.categories[index];
                        return Container(
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
                                        color: Colors.black,
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
      ),
    );
  }
}
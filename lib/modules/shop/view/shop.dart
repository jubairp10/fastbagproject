import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widget/store_widget.dart';
import '../../../constants/app_color.dart';
import '../../../constants/app_fonts.dart';
import '../view_model/shoplist_view_model.dart';

class Shop extends StatelessWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stores',
          style: MainFont(
            fontsize: 24,
            fontweight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10),
            SizedBox(
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:5,
                    itemBuilder: (context, index) {
                      // final store = favoriteStores[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StoreWidget(
                          text: 'buffon',
                          tex2: 'Opens at 10 AM',
                          image: 'assets/icon/Gopuff.png',
                        ),
                      );
                    })
    ),
            // Consumer<StoreViewModel>(
            //   builder: (context, viewModel, child) {
            //     if (viewModel.isLoading) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (viewModel.errorMessage != null) {
            //       return Center(child: Text(viewModel.errorMessage!));
            //     } else {
            //       final favoriteStores = viewModel.stores
            //           .where((store) => store.isFavorite)
            //           .toList();
            //       if (favoriteStores.isEmpty) {
            //         return Text('No favorite stores available.');
            //       }
            //       return SizedBox(
            //         height: 210,
            //         child: ListView.builder(
            //           scrollDirection: Axis.horizontal,
            //           itemCount: favoriteStores.length,
            //           itemBuilder: (context, index) {
            //             final store = favoriteStores[index];
            //             return Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: StoreWidget(
            //                 text: store.businessName,
            //                 tex2: 'Opens at ${store.openingTime}',
            //                 image: store.displayImage,
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     }
            //   },
            // ),
            SizedBox(height: 20),
            Text(
              'All Stores',
              style: MainFont(
                fontsize: 24,
                fontweight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<StoreViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (viewModel.errorMessage != null) {
                    return Center(child: Text(viewModel.errorMessage!));
                  } else {
                    return ListView.builder(
                      itemCount: viewModel.stores.length,
                      itemBuilder: (context, index) {
                        final store = viewModel.stores[index];
                        return Container(
                          width: double.infinity,
                          height: 100,
                          child: ListTile(
                            key: ValueKey(store.id),
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(store.displayImage),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store.businessName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Opens at ${store.openingTime}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                store.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: store.isFavorite ? Colors.red : null,
                              ),
                              onPressed: () {
                               // Provider.of()
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

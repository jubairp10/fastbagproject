import 'package:fastbagproject/constants/app_color.dart';
import 'package:fastbagproject/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class StoreWidget extends StatelessWidget {
  final String text;
  final String tex2;
  final String image;

  const StoreWidget({
    Key? key,
    required this.text,
    required this.tex2,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 164,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
           image,
            height: 80.23,
            width: 124.45,
          ),

          SizedBox(height: 15,),
          Text(text,style: MainFont(fontsize: 16, fontweight: FontWeight.w500, color: AppColors.black),),
          Text(tex2,style: MainFont(fontsize: 14, fontweight: FontWeight.w400, color: AppColors.greyColor),)
        ],
      ),
    );
  }
}

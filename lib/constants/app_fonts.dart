import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';


TextStyle MainFont(
    {required double fontsize,
      required FontWeight fontweight,
      required Color color}) {
  return GoogleFonts.figtree(
      fontSize: fontsize, fontWeight: fontweight, color: color,letterSpacing: 1);
}

TextStyle LoginFont(
{
  required double fontsize,
  required FontWeight fontweigt,
  required Color color}){
  return GoogleFonts.jomhuria(
    fontSize: fontsize,fontWeight: fontweigt,color: color,letterSpacing: 1
  );
}
TextStyle Normalfont(
    {
      required double fontsize,
      required FontWeight fontweigt,
      required Color color}){
  return GoogleFonts.tinos(
      fontSize: fontsize,fontWeight: fontweigt,color: color,letterSpacing: 1
  );
}
TextStyle Normalfont2(
    {
      required double fontsize,
      required FontWeight fontweigt,
      required Color color}){
  return GoogleFonts.roboto(
      fontSize: fontsize,fontWeight: fontweigt,color: color,letterSpacing: 1
  );
}
TextStyle Normalfont3(
    {
      required double fontsize,
      required FontWeight fontweigt,
      required Color color}){
  return GoogleFonts.inter(
      fontSize: fontsize,fontWeight: fontweigt,color: color,letterSpacing: 1
  );
}
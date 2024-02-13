import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

double defPadding = 24.0;
const Color primaryColor = Color(0xff1FA0C9);
const Color secondaryColor = Color(0xffD6E4EC);
const Color bodyTextColor = Color(0xffB9B9B9);
const Color headingColor = Color(0xff121212);


const double defaultTextSize = 14;
const double headerTextSize = 21;
const double appTitleSize = 17;


TextStyle   headerTextStyle = GoogleFonts.inter(color: headingColor,fontSize: headerTextSize,fontWeight: FontWeight.w600);
TextStyle   bodyTextStyle = GoogleFonts.inter(color: bodyTextColor,fontSize: defaultTextSize,fontWeight: FontWeight.normal);
TextStyle   appTitleTextStyle = GoogleFonts.inter(color: headingColor,fontSize: appTitleSize , fontWeight: FontWeight.w500);

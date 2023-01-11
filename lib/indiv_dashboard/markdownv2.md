import '../flutter_flow/flutter_flow_icon_button.dart'; import '../flutter_flow/flutter_flow_place_picker.dart'; import '../flutter_flow/flutter_flow_theme.dart'; import '../flutter_flow/flutter_flow_util.dart'; import '../flutter_flow/flutter_flow_widgets.dart'; import '../flutter_flow/place.dart'; import 'dart:io'; import 'package:flutter/material.dart'; import 'package:flutter_rating_bar/flutter_rating_bar.dart'; import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget { const HomePageWidget({Key? key}) : super(key: key);

@override _HomePageWidgetState createState() => _HomePageWidgetState(); } //home page widget state class _HomePageWidgetState extends State { double? ratingBarValue1; var placePickerValue = FFPlace(); double? ratingBarValue2; final scaffoldKey = GlobalKey();

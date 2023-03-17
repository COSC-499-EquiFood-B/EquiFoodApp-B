import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}
//home page widget state
class _HomePageWidgetState extends State<HomePageWidget> {
  double? ratingBarValue1;
  var placePickerValue = FFPlace();
  double? ratingBarValue2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFACE4AF),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 1.2),
                child: Container(
                  width: 420,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ),
              Stack(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.9, -1),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 50,
                              icon: Icon(
                                Icons.arrow_back_sharp,
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                size: 25,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.24, -0.99),
                            child: FlutterFlowPlacePicker(
                              iOSGoogleMapsApiKey: '',
                              androidGoogleMapsApiKey: '',
                              webGoogleMapsApiKey: '',
                              onSelect: (place) async {
                                setState(() => placePickerValue = place);
                              },
                              defaultText: 'Select Location',
                              icon: Icon(
                                Icons.place,
                                color: Colors.white,
                                size: 16,
                              ),
                              buttonOptions: FFButtonOptions(
                                width: 200,
                                height: 40,
                                color: Color(0xFFACE4AF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.52, -1.02),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 60,
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                size: 30,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.19, -0.85),
                            child: Text(
                              'Find available food \nnear you',
                              textAlign: TextAlign.justify,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.06, -0.58),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Search Restaurants',
                              icon: Icon(
                                Icons.search,
                                color: Color(0xFFCACACA),
                                size: 10,
                              ),
                              options: FFButtonOptions(
                                width: 320,
                                height: 40,
                                color: Color(0x99FFFFFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFCACACA),
                                      fontWeight: FontWeight.normal,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.84, -0.45),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Browse',
                              options: FFButtonOptions(
                                height: 40,
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                color: Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.84, -0.45),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Browse',
                              options: FFButtonOptions(
                                height: 40,
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                color: Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Align(


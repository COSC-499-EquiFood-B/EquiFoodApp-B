import 'package:equi_food_app/admin/adminpage.dart';
import 'package:equi_food_app/admin/approvalpage.dart';
import 'package:equi_food_app/admin/deniedpage.dart';
import 'package:equi_food_app/utils/displaySnackbar.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

//Firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';

class ApproveordenyWidget extends StatefulWidget {
  final String restaurantID;
  final Map<String, dynamic> restaurantData;

  const ApproveordenyWidget(
      {Key? key, required this.restaurantID, required this.restaurantData})
      : super(key: key);

  @override
  _ApproveordenyWidgetState createState() => _ApproveordenyWidgetState();
}

class _ApproveordenyWidgetState extends State<ApproveordenyWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Create reference to users collection
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('users');

  // function to approve a restaurant
  Future<void> approveRestaurant() async {
    restaurants
        .doc(widget.restaurantID)
        .update({
          'is_approved': true,
        })
        .then((value) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RestaurantapprovedWidget()),
              ),
              displaySnackbar(context, 'Restaurant approved.'),
            })
        .catchError((onError) => {
              displaySnackbar(context,
                  'An unknown error occurred. Couldn\'t complete your request.')
            });
  }

  // function to deny a restaurant
  Future<void> denyRestaurant() async {
    restaurants
        .doc(widget.restaurantID)
        .delete()
        .then((value) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RestaurantdeniedWidget()),
              ),
              displaySnackbar(context, 'Restaurant denied.'),
            })
        .catchError((onError) => {
              displaySnackbar(context,
                  'An unknown error occurred. Couldn\'t complete your request.')
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 240,
                    child: Stack(
                      alignment: AlignmentDirectional(-0.95, -0.7),
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Image.network(
                            widget.restaurantData["profile_img"],
                            width: MediaQuery.of(context).size.width,
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.95, -0.55),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminpageWidget()),
                              );
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          widget.restaurantData["restaurant_name"],
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          style:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 16),
                          child: Text(
                            widget.restaurantData["address_line_1"],
                            textAlign: TextAlign.start,
                            style:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF14181B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 16),
                          child: Text(
                            widget.restaurantData["email"],
                            textAlign: TextAlign.start,
                            style:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF14181B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 24),
              child: Column(
                children: [
                  FFButtonWidget(
                    onPressed: approveRestaurant,
                    text: 'Approve',
                    options: FFButtonOptions(
                      width: 360,
                      height: 40,
                      color: Color.fromRGBO(38, 189, 104, 1),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 8),
                  FFButtonWidget(
                    onPressed: denyRestaurant,
                    text: 'Deny',
                    options: FFButtonOptions(
                      width: 360,
                      height: 40,
                      color: Color(0xFF353C41),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

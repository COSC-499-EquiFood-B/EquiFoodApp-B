import 'package:equi_food_app/admin/adminpage.dart';
import 'package:equi_food_app/admin/approvalpage.dart';
import 'package:equi_food_app/admin/approvedrestaurants.dart';
import 'package:equi_food_app/admin/deniedpage.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApproveordenyWidget extends StatefulWidget {
  final String restaurantIDs;

  const ApproveordenyWidget({Key? key, required this.restaurantIDs})
      : super(key: key);

  @override
  _ApproveordenyWidgetState createState() => _ApproveordenyWidgetState();
}

class _ApproveordenyWidgetState extends State<ApproveordenyWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Create reference to donations collection
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: restaurants.doc(widget.restaurantIDs).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> restaurantsData =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                appBar: AppBar(
                  backgroundColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  automaticallyImplyLeading: false,
                  leading: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminpageWidget()),
                      );
                    },
                    child: Icon(
                      Icons.chevron_left_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 32,
                    ),
                  ),
                  title: Text(
                    'Restaurant Details',
                    style: FlutterFlowTheme.of(context).subtitle1,
                  ),
                  actions: [],
                  centerTitle: false,
                  elevation: 0,
                ),
                body: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14, 16, 0, 0),
                                  child: Text(
                                    restaurantsData["restaurant_name"],
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Image.network(
                                  restaurantsData["profile_img"],
                                  width: 360,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(14, 8, 0, 0),
                                child: Text(
                                  'Restaurant Pending Approval',
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF353C41),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    14, 12, 0, 4),
                                child: Text(
                                  'Locations: ${restaurantsData["address"]}',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Divider(
                                height: 24,
                                thickness: 2,
                                indent: 14,
                                endIndent: 20,
                                color: Color.fromARGB(255, 76, 191, 82),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RestaurantapprovedWidget()),
                                    );
                                  },
                                  text: 'Approve',
                                  options: FFButtonOptions(
                                    width: 360,
                                    height: 40,
                                    color: Color.fromARGB(255, 76, 191, 82),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    13, 15, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RestaurantdeniedWidget()),
                                    );
                                  },
                                  text: 'Deny',
                                  options: FFButtonOptions(
                                    width: 360,
                                    height: 40,
                                    color: Color(0xFF353C41),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                        ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }
          // Loading Spinner at the centre of the page
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 52, 185, 59),
                ),
              ));
        });
  }
}

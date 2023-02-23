import 'package:firebase_core/firebase_core.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// imports for database-related stuff
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// importing custom-defined functions
import '../utils/displaySnackbar.dart'; // to render a SnackBar

class CreateDonationWidget extends StatefulWidget {
  const CreateDonationWidget({Key? key}) : super(key: key);

  @override
  _CreateDonationWidgetState createState() => _CreateDonationWidgetState();
}

class _CreateDonationWidgetState extends State<CreateDonationWidget> {
  TextEditingController? donationDescriptionController;
  TextEditingController? donationNameController;
  TextEditingController? donationQtyController;
  TextEditingController? donationPriceController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    donationDescriptionController = TextEditingController();
    donationNameController = TextEditingController();
    donationQtyController = TextEditingController();
    donationPriceController = TextEditingController();
  }

  @override
  void dispose() {
    donationDescriptionController?.dispose();
    donationNameController?.dispose();
    donationQtyController?.dispose();
    donationPriceController?.dispose();
    super.dispose();
  }

  // method to write donation details to firebase under the "donations" Collection
  Future createDonation() async {
    // get user ID of Restaurant User (uid)
    final currentRestaurantUser = FirebaseAuth.instance.currentUser;

    // create ref to specific restaurant User ID (uid) in "users" Collection
    final restaurantRef = FirebaseFirestore.instance
        .collection("users")
        .doc(currentRestaurantUser?.uid);

    // proceed only if all the donation fields are filled
    if (checkDonationFields()) {
      try {
// add details to the "donations" Collection
        await FirebaseFirestore.instance.collection("donations").add({
          "item_name": donationNameController!.text.toString(),
          "item_img":
              "https://cleangreensimple.com/wp-content/uploads/2020/04/7-sweet-peas-and-saffron-air-fryer-cauliflower-chickpea-tacos.jpg", // default img
          "description": donationDescriptionController!.text.toString(),
          "restaurant_name": currentRestaurantUser?.displayName,
          "quantity": int.parse(donationQtyController!.text),
          "price": double.parse(donationPriceController!.text),
          "created_at": DateTime.now(),
          "restaurant_ref": restaurantRef,
          "is_reserved":
              false // since the donation is not reserved by a user yet
        }).then((value) => {
              // clear all text fields
              clearDonationFields(),

              // display SnackBar with success message
              displaySnackbar(context, "Donation created."),
            });
      } on FirebaseException catch (e) {
        //print(e.code);
        displaySnackbar(context, e.code);
      } on FormatException catch (e) {
        // in case a wrong input is entered by the user
        //print(e);
        displaySnackbar(
            context, "Invalid input for one of the fields. Please try again.");
      }
    }
  }

  // function to check if all the fields are filled
  bool checkDonationFields() {
    if (donationNameController!.text.isEmpty ||
        donationDescriptionController!.text.isEmpty ||
        donationQtyController!.text.isEmpty ||
        donationPriceController!.text.isEmpty) {
      return false;
    }

    return true;
  }

  // function to clear all text fields
  void clearDonationFields() {
    donationNameController!.clear();
    donationDescriptionController!.clear();
    donationQtyController!.clear();
    donationPriceController!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 76, 191, 82),
          automaticallyImplyLeading: true,
          title: SelectionArea(
              child: Text(
            'Create Donation',
            style: FlutterFlowTheme.of(context).title1.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).primaryBtnText,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
          )),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
              child: TextFormField(
                controller: donationNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: FlutterFlowTheme.of(context).bodyText2,
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationQtyController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Qty.',
                  labelStyle: FlutterFlowTheme.of(context).bodyText2,
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationDescriptionController,
                obscureText: false,
                decoration: InputDecoration(
                  labelStyle: FlutterFlowTheme.of(context).bodyText2,
                  hintText: 'Description',
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationPriceController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: FlutterFlowTheme.of(context).bodyText2,
                  hintStyle: FlutterFlowTheme.of(context).bodyText2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: FFButtonWidget(
                  onPressed: createDonation,
                  text: 'Create',
                  options: FFButtonOptions(
                    width: 340,
                    height: 60,
                    color: Color.fromARGB(255, 76, 191, 82),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

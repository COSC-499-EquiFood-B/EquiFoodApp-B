import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../login/login_widget.dart';

// imports for database-related stuff
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
  TextEditingController? donationImgController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    donationDescriptionController = TextEditingController();
    donationNameController = TextEditingController();
    donationQtyController = TextEditingController();
    donationPriceController = TextEditingController();
    donationImgController = TextEditingController();
  }

  @override
  void dispose() {
    donationDescriptionController?.dispose();
    donationNameController?.dispose();
    donationQtyController?.dispose();
    donationPriceController?.dispose();
    donationImgController?.dispose();
    super.dispose();
  }

  // styles for all TextFields
  TextStyle textFieldStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w100,
    fontSize: 16,
    color: Color.fromARGB(255, 44, 44, 45),
  );

  // styles for all TextFields LABELS
  TextStyle textFieldLabelStyle = TextStyle(
    color: Color.fromARGB(255, 113, 113, 116),
  );

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
          "item_img": donationImgController?.text
              .toString()
              .toString(), // donation image link (temporary)
          "description": donationDescriptionController!.text.toString(),
          "restaurant_name": currentRestaurantUser?.displayName,
          "quantity": int.parse(donationQtyController!.text),
          "price": double.parse(donationPriceController!.text),
          "created_at": DateTime.now(),
          "restaurant_ref": restaurantRef,
          "is_reserved":
              false, // since the donation is not reserved by a user yet
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
        donationPriceController!.text.isEmpty ||
        donationImgController!.text.isEmpty) {
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
    donationImgController!.clear();
  }

  Future signOutUser() async {
    // log out user
    await FirebaseAuth.instance.signOut();

    // redirect user to the Login page
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginWidget()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 243, 248, 249),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 189, 104, 1),
        automaticallyImplyLeading: false,
        title: Text(
          'Create Donations',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Inter',
                color: Color.fromRGBO(247, 255, 250, 1),
                fontSize: 24,
              ),
        ),
        actions: [
          // Sign-Out Icon
          IconButton(
              icon: const Icon(Icons.logout_outlined),
              iconSize: 25,
              onPressed: () async {
                await showDialog<bool>(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        content: Text('Are you sure you want to sign out? '),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(alertDialogContext, false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(alertDialogContext, false),
                              // call function to delete donation
                              signOutUser()
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    });
              }),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // TextField for Donation name
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
              child: TextFormField(
                controller: donationNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Item name',
                  labelStyle: textFieldLabelStyle,
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
                style: textFieldStyle,
              ),
            ),
            // TextField for Quantity
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationQtyController,
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Qty.',
                  labelStyle: textFieldLabelStyle,
                  hintText: 'Number of servings',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 167, 167, 170),
                  ),
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
                style: textFieldStyle,
              ),
            ),
            // TextField for Description
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationDescriptionController,
                obscureText: false,
                maxLength: 200,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: textFieldLabelStyle,
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
                style: textFieldStyle,
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
            // TextField for Price
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationPriceController,
                obscureText: false,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: textFieldLabelStyle,
                  hintText: 'CAD',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 167, 167, 170),
                  ),
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
                style: textFieldStyle,
              ),
            ),
            // TextField for image link (temporary)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationImgController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Image link',
                  labelStyle: textFieldLabelStyle,
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
                style: textFieldStyle,
              ),
            ),
            // Create Button
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
                    color: Color.fromRGBO(38, 189, 104, 1),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(247, 255, 250, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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

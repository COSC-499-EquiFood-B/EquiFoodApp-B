// custom Widget similar to IndivItem, that allows the Restaurant User to edit their current Donation

import 'package:equi_food_app/utils/displaySnackbar.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

//Firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';

import 'restaurant_dashboard_widget_2.dart';

class EditDonationWidget extends StatefulWidget {
  final String donationID;
  final Map<String, dynamic> donationData;

  const EditDonationWidget(
      {Key? key, required this.donationID, required this.donationData})
      : super(key: key);

  @override
  _EditDonationWidget createState() => _EditDonationWidget();
}

class _EditDonationWidget extends State<EditDonationWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Create reference to donations collection
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  // state variable to change the text/color of the "Reserve" Button
  bool isDonationReserved = false;
  bool isFieldChanged = false;

  // fields related to Donation that could be edited/updated
  TextEditingController? donationNameController;
  TextEditingController? donationDescriptionController;
  TextEditingController? donationQtyController;
  TextEditingController? donationPriceController;
  TextEditingController? donationImgController;

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

  // function to update Donation
  Future<void> updateDonation() async {
    // update fields on firebase
    donations
        .doc(widget.donationID)
        .update(
            // sending data to update (Map<String, dynamic>)
            // if either of the fields are empty, then write their respective values to them
            {
              "item_name": donationNameController!.text.isNotEmpty
                  ? donationNameController?.text.toString()
                  : widget.donationData["item_name"],
              "item_img": donationImgController!.text.isNotEmpty
                  ? donationImgController?.text.toString()
                  : widget.donationData["item_img"],
              "description": donationDescriptionController!.text.isNotEmpty
                  ? donationDescriptionController?.text.toString()
                  : widget.donationData["description"],
              "price": donationPriceController!.text.isNotEmpty
                  ? double.parse(donationPriceController!.text)
                  : widget.donationData["price"],
              "quantity": donationQtyController!.text.isNotEmpty
                  ? int.parse(donationQtyController!.text)
                  : widget.donationData["quantity"],
            })
        .then((value) => {
              // empty fields
              clearDonationFields(),
              // display SnackBar with success message
              displaySnackbar(context, "Data updated successfully."),

              // Redirect Restaurant User to Dashboard
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => DonationsWidget()),
                  (route) => false),
            })
        .catchError((onError) => {
              // display error message
              displaySnackbar(context,
                  "An unknown error occurred. Couldn\'t complete your request.")
            });
  }

  // function to clear all text fields
  void clearDonationFields() {
    donationNameController!.clear();
    donationDescriptionController!.clear();
    donationQtyController!.clear();
    donationPriceController!.clear();
    donationImgController!.clear();
  }

// function to initialize the TextControllers with their initial value
// The fields are read from donationData into these TextControllers
  void initializeTextControllers() {
    donationNameController =
        TextEditingController(text: widget.donationData["item_name"]);
    donationImgController =
        TextEditingController(text: widget.donationData["item_img"]);
    donationDescriptionController =
        TextEditingController(text: widget.donationData["description"]);
    donationPriceController = TextEditingController(
        text: widget.donationData["price"]
            .toString()); // convert int field to String
    donationQtyController = TextEditingController(
        text: widget.donationData["quantity"]
            .toString()); // convert double field to String
  }

  @override
  void initState() {
    super.initState();

    // initialize the TextControllers with the current value of fields in the database
    initializeTextControllers();

    donationNameController?.addListener(() {
      print(donationNameController?.text);

      if (!isFieldChanged) {
        setState(() {
          isFieldChanged = true;
        });
      }
    });

    donationDescriptionController?.addListener(() {
      if (!isFieldChanged) {
        setState(() {
          isFieldChanged = true;
        });
      }
    });

    donationPriceController?.addListener(() {
      if (!isFieldChanged) {
        setState(() {
          isFieldChanged = true;
        });
      }
    });

    donationQtyController?.addListener(() {
      if (!isFieldChanged) {
        setState(() {
          isFieldChanged = true;
        });
      }
    });

    donationImgController?.addListener(() {
      if (!isFieldChanged) {
        setState(() {
          isFieldChanged = true;
        });
      }
    });
  }

  // function to release all resources after use
  @override
  void dispose() {
    donationDescriptionController?.dispose();
    donationNameController?.dispose();
    donationQtyController?.dispose();
    donationPriceController?.dispose();
    donationImgController?.dispose();
    super.dispose();
  }

  // Map<String, dynamic> donationData = {}

  // Future<void> getDonationFields() async {
  //   donations.doc(widget.donationID).get().then((snapshot) => {
  //         donationData = snapshot.data() as Map<String, dynamic>,
  //       });
  // }

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
                            widget.donationData["item_img"],
                            width: MediaQuery.of(context).size.width,
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.95, -0.55),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
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

            // TextField for the Donation Name field
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

            // TextField for the Donation Description field
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationDescriptionController,
                maxLength: 200,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Description',
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

            // TextField for the Donation Image field
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationImgController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Item image',
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

            // TextField for the Donation Price Field
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationPriceController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: textFieldLabelStyle,
                  hintText: 'CAD',
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

            // TextField for the Donation Quantity Field
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
              child: TextFormField(
                controller: donationQtyController,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Quantity',
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

            // Update Button
            Align(
                alignment: AlignmentDirectional(0, 0.05),
                child: SizedBox(
                  height: 95,
                  width: 100,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                    child: ElevatedButton(
                      onPressed: isFieldChanged ? () => updateDonation() : null,
                      child: Text('Update'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(38, 189, 104, 1),
                          elevation: 2,
                          textStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

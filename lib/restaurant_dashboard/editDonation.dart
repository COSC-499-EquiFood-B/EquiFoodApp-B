// custom Widget similar to IndivItem, that allows the Restaurant User to edit their current Donation

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDonationWidget extends StatefulWidget {
  final String donationID;

  const EditDonationWidget({Key? key, required this.donationID})
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

  // function to update Donation
  Future<void> updateDonation() async {}

  @override
  void initState() {
    super.initState();
    donationDescriptionController = TextEditingController();
    donationNameController = TextEditingController();
    donationQtyController = TextEditingController();
    donationPriceController = TextEditingController();
  }

  // function to release all resources after use
  @override
  void dispose() {
    donationDescriptionController?.dispose();
    donationNameController?.dispose();
    donationQtyController?.dispose();
    donationPriceController?.dispose();
    super.dispose();
  }

  void initializeInputFields(Map<String, dynamic> donationsData) {
    donationNameController =
        TextEditingController(text: donationsData["item_name"]);
    donationDescriptionController =
        TextEditingController(text: donationsData["description"]);
    donationPriceController = TextEditingController(
        text: donationsData["price"].toString()); // convert int field to String
    donationQtyController = TextEditingController(
        text: donationsData["quantity"]
            .toString()); // convert double field to String
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        // get the Donation Item with the given donationID
        future: donations.doc(widget.donationID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> donationsData =
                snapshot.data!.data() as Map<String, dynamic>;

            initializeInputFields(donationsData);

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
                                    donationsData["item_img"],
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: Icon(
                                          Icons.arrow_back_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
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
                      child: TextField(
                        controller: donationNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Item name',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
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
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),

                    // TextField for the Donation Price Field
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
                      child: TextField(
                        controller: donationPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),

                    // TextField for the Donation Quantity Field
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
                      child: TextField(
                        controller: donationQtyController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
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
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),

                    // Update Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: FFButtonWidget(
                        onPressed: isFieldChanged
                            ? () {
                                // update Donation Details
                                updateDonation();
                              }
                            : () {},
                        text: 'Update',
                        options: FFButtonOptions(
                          height: 40,
                          color: Color.fromARGB(255, 76, 191, 82),
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
                    ),
                  ],
                ),
              ),
            );
          }
          // Loading Spinner at the centre of the page
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(209, 255, 189, 1),
                ),
              ));
        });
  }
}

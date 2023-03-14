// Custom Widget to render a Donation Card on the Restaurant Dashboard
/* takes 2 inputs: 
   - The ID of the Donation Item
   - a Map<String, dynamic> as a required input. This contains a Donation Document retrieved from the Collection on firebase
*/
// This Widget renders Cards showing the Donation info sent to it

import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equi_food_app/utils/displaySnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class DonationCard extends StatelessWidget {
  final String donationID;
  final Map<String, dynamic> donationData;

  DonationCard({required this.donationID, required this.donationData});

  // function to delete the Donation
  // triggered when the Delete Icon on the Donation Card is clicked
  Future deleteDonationItem(BuildContext context) async {
    // create Collection Reference to the "donations" Collection
    CollectionReference donations =
        FirebaseFirestore.instance.collection('donations');

    // delete the Donation ID with the given donationID
    donations
        .doc(donationID)
        .delete()
        .then((value) => {
              // confirmation Snackbar
              displaySnackbar(context, 'Donation deleted.'),
            })
        .catchError((onError) => {
              // display Snackbar showing error
              displaySnackbar(context,
                  'An unknown error occurred. Couldn\'t complete your request.'),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              '${donationData["item_img"]}',
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${donationData["item_name"]} (${donationData["quantity"]} servings)',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 10,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.edit_sharp,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 25,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 20,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.delete,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 25,
                            ),
                            onPressed: () async {
                              await showDialog<bool>(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        content: Text(
                                            'Are you sure? This action can\'t be undone. '),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext, false),
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => {
                                              Navigator.pop(
                                                  alertDialogContext, false),
                                              // call function to delete donation
                                              deleteDonationItem(context)
                                            },
                                            child: Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    },
                                  ) ??
                                  false;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

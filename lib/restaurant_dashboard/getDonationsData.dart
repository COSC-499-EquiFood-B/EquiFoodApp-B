import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class GetDonationsData extends StatelessWidget {
  final String donationsID;

  GetDonationsData({required this.donationsID});

  @override
  Widget build(BuildContext context) {
    // create reference to the "donations" Collection in firebase
    CollectionReference donations =
        FirebaseFirestore.instance.collection('donations');

    return FutureBuilder<DocumentSnapshot>(
        future: donations.doc(donationsID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> donationsData =
                snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
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
                      '${donationsData["item_img"]}',
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
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${donationsData["item_name"]} (${donationsData["quantity"]} servings)',
                              style: FlutterFlowTheme.of(context).subtitle1,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 30,
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        'Remove Donation?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
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
          return Text('Loading...');
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equi_food_app/flutter_flow/flutter_flow_util.dart';
import 'package:equi_food_app/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class getDonations extends StatelessWidget {
  final String donationsID;

  getDonations({required this.donationsID});

  @override
  //create reference to the "donations" collection in firebase
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: donations.doc(donationsID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> donationsData =
                snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IndivItemWidget(donationsID: donationsID)),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 190,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x230E151B),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 4, 4, 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${donationsData["item_img"]}',
                                width: double.infinity,
                                height: 115,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                              child: Text(
                                '${donationsData["restaurant_name"]}',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle1
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF14181B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                              child: Text(
                                'Meals Available: ${donationsData["quantity"]}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF57636C),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center();
        });
  }
}

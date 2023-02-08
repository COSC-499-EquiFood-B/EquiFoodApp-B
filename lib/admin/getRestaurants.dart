import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equi_food_app/flutter_flow/flutter_flow_util.dart';
import 'package:equi_food_app/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class getRestaurants extends StatelessWidget {
  final String restaurantIDs;

  getRestaurants({required this.restaurantIDs});

  @override
  //create reference to the "donations" collection in firebase
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(restaurantIDs).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> restaurantsData =
                snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 3),
              child: Wrap(
                spacing: 7,
                runSpacing: 2,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: InkWell(
                      onTap: () async {
                        context.pushNamed('confirmationscreen');
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                          child: InkWell(
                            onTap: () async {
                              context.pushNamed('approveordeny');
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    '${restaurantsData["profile_img"]}',
                                    width: double.infinity,
                                    height: 115,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 12, 0, 0),
                                  child: Text(
                                    '${restaurantsData["restaurant_name"]}',
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF14181B),
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 4, 0, 0),
                                  child: Text(
                                    'Awaiting Approval Since:',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

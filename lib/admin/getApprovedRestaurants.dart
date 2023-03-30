import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equi_food_app/admin/approvedrestaurants.dart';
import 'package:equi_food_app/admin/approveordeny.dart';
import 'package:equi_food_app/flutter_flow/flutter_flow_util.dart';
import 'package:equi_food_app/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class ApprovedRestaurantCard extends StatelessWidget {
  final String restaurantID;
  final Map<String, dynamic> restaurantData;

  // receives the ID for an Approved Restaurant and the document containing its info
  ApprovedRestaurantCard(
      {required this.restaurantID, required this.restaurantData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: ListView(
        addRepaintBoundaries: false,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                    color: Color(0xFFE0E3E7),
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Color(0xFF4B39EF),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(44),
                          child: Image.network(
                            restaurantData["profile_img"],
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                              child: Text(
                                restaurantData["restaurant_name"],
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF101213),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Text(
                              restaurantData["email"],
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF57636C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF57636C),
                      size: 24,
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
}

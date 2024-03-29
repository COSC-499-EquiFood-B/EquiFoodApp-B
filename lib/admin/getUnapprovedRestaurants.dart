import 'package:equi_food_app/admin/approveordeny.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';

class UnapprovedRestaurantCard extends StatelessWidget {
  final String restaurantID;
  final Map<String, dynamic> restaurantData;

  // receives the ID for an Unapproved Restaurant and the document containing its info
  UnapprovedRestaurantCard(
      {required this.restaurantID, required this.restaurantData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
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
                    builder: (context) => ApproveordenyWidget(
                        restaurantID: restaurantID,
                        restaurantData: restaurantData)),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 4),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${restaurantData["profile_img"]}',
                        width: double.infinity,
                        height: 115,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                      child: Text(
                        '${restaurantData["restaurant_name"]}',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Inter',
                              color: Color(0xFF14181B),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                      child: Text(
                        'Pending: 5 days',
                        style: FlutterFlowTheme.of(context).bodyText2.override(
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
}

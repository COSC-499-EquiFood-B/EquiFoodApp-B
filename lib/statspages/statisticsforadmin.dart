import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login/login_widget.dart';

//Firebase imports
import 'package:firebase_auth/firebase_auth.dart';

class StatisticsforadminWidget extends StatefulWidget {
  const StatisticsforadminWidget({Key? key}) : super(key: key);

  @override
  _StatisticsforadminWidgetState createState() =>
      _StatisticsforadminWidgetState();
}

class _StatisticsforadminWidgetState extends State<StatisticsforadminWidget>
    with TickerProviderStateMixin {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
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
          'Savings',
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
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Sales & Revenue',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Inter',
                              color: Color(0xFF0F1113),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -0.05),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 147,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x230E151B),
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.payments,
                                color: Color(0xFF0F1113),
                                size: 40,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 12),
                                child: Text(
                                  '\$320k',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF0F1113),
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                                child: Text(
                                  'Total Donations',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF57636C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 138,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x230E151B),
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.supervisor_account_rounded,
                                color: Color(0xFF0F1113),
                                size: 32,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 12),
                                child: Text(
                                  '56.4k',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF0F1113),
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Text(
                                'Customers',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 138,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x230E151B),
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.web_asset_rounded,
                                color: Color(0xFF0F1113),
                                size: 32,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 12),
                                child: Text(
                                  '59',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF0F1113),
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Text(
                                'Restaurants',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 138,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x230E151B),
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pie_chart_rounded,
                                color: Color(0xFF0F1113),
                                size: 32,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 12),
                                child: Text(
                                  '300',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF0F1113),
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Text(
                                'Meals Saved',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

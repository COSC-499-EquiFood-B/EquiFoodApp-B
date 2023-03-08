import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticsforrestoWidget extends StatefulWidget {
  const StatisticsforrestoWidget({Key? key}) : super(key: key);

  @override
  _StatisticsforrestoWidgetState createState() =>
      _StatisticsforrestoWidgetState();
}

class _StatisticsforrestoWidgetState extends State<StatisticsforrestoWidget>
    with TickerProviderStateMixin {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromRGBO(38, 189, 104, 1),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Text(
                    'Your Restaurant\'s\nEquifood Statistics',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(247, 255, 250, 1),
                          fontSize: 32,
                        ),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 500,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    '40',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 1),
                                  child: Text(
                                    'Through Equifood you have prevented ____ meals from going to a landfill. Thank you!',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

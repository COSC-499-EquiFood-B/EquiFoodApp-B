import 'package:equi_food_app/index.dart';
import 'package:equi_food_app/indiv_dashboard/indivDashboard.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ConfirmationscreenWidget extends StatefulWidget {
  const ConfirmationscreenWidget({Key? key}) : super(key: key);

  @override
  _ConfirmationscreenWidgetState createState() =>
      _ConfirmationscreenWidgetState();
}

class _ConfirmationscreenWidgetState extends State<ConfirmationscreenWidget> {
  StopWatchTimer? timerController;
  String? timerValue;
  int? timerMilliseconds;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    timerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromRGBO(209, 255, 189, 1),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_xlkxtmul.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      frameRate: FrameRate(60),
                      repeat: false,
                      animate: true,
                    ),
                  ],
                ),
              ),
              Text(
                'Congrats!',
                style: FlutterFlowTheme.of(context).title2.override(
                      fontFamily: 'Outfit',
                      color: Color.fromARGB(255, 76, 191, 82),
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Text(
                    'Your Order Is Held For',
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: Color.fromARGB(255, 76, 191, 82),
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: FlutterFlowTimer(
                  timerValue: timerValue ??= StopWatchTimer.getDisplayTime(
                    timerMilliseconds ??= 600000,
                    hours: true,
                    minute: true,
                    second: true,
                    milliSecond: false,
                  ),
                  timer: timerController ??= StopWatchTimer(
                    mode: StopWatchMode.countDown,
                    presetMillisecond: timerMilliseconds ??= 600000,
                    onChange: (value) {
                      setState(() {
                        timerMilliseconds = value;
                        timerValue = StopWatchTimer.getDisplayTime(
                          value,
                          hours: true,
                          minute: true,
                          second: true,
                          milliSecond: false,
                        );
                      });
                    },
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 76, 191, 82),
                        fontSize: 24,
                      ),
                  onEnded: () {},
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.05),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'View Order Details',
                    options: FFButtonOptions(
                      width: 180,
                      height: 50,
                      color: Color.fromARGB(255, 76, 191, 82),
                      textStyle: FlutterFlowTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(44, 32, 44, 44),
                child: FFButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HmepageWidget()),
                    );
                  },
                  text: 'Cancel Order',
                  options: FFButtonOptions(
                    width: 180,
                    height: 50,
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF36AC64),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

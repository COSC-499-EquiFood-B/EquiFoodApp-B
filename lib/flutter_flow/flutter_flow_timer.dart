import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class FlutterFlowTimer extends StatefulWidget {
  const FlutterFlowTimer({
    Key? key,
    required this.timerValue,
    required this.timer,
    required this.onEnded,
    required this.textAlign,
    required this.style,
  }) : super(key: key);

  final String timerValue;
  final StopWatchTimer timer;
  final Function() onEnded;
  final TextAlign textAlign;
  final TextStyle style;

  @override
  State<FlutterFlowTimer> createState() => _FlutterFlowTimerState();
}

class _FlutterFlowTimerState extends State<FlutterFlowTimer> {
  @override
  void initState() {
    widget.timer.fetchEnded.listen((_) => widget.onEnded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.timerValue,
      textAlign: widget.textAlign,
      style: widget.style,
    );
  }
}

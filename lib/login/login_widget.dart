// import '../auth/auth_util.dart';
// import 'package:go_router/go_router.dart';
// import '../flutter_flow/flutter_flow_icon_button.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginWidget extends StatefulWidget {
//   const LoginWidget({Key? key}) : super(key: key);

//   @override
//   _LoginWidgetState createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   TextEditingController? emailTextController;
//   TextEditingController? passwordTextController;

//   late bool passwordVisibility;
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     emailTextController = TextEditingController();
//     passwordTextController = TextEditingController();
//     passwordVisibility = false;
//   }

//   @override
//   void dispose() {
//     emailTextController?.dispose();
//     passwordTextController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//       body: SafeArea(
//         child: Visibility(
//           visible: responsiveVisibility(
//             context: context,
//             tablet: false,
//           ),
//           child: Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     InkWell(
//                       onTap: () async {
//                         context.pop();
//                       },
//                       child: Image.asset(
//                         'assets/images/logoTranslation@3x.png',
//                         width: 40,
//                         height: 40,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: FlutterFlowTheme.of(context).primaryBackground,
//                         ),
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
//                           child: Text(
//                             'Sign In',
//                             style: FlutterFlowTheme.of(context).title1,
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           context.pushNamed(
//                             'signup',
//                             extra: <String, dynamic>{
//                               kTransitionInfoKey: TransitionInfo(
//                                 hasTransition: true,
//                                 transitionType: PageTransitionType.fade,
//                                 duration: Duration(milliseconds: 200),
//                               ),
//                             },
//                           );
//                         },
//                         child: Container(
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color:
//                                 FlutterFlowTheme.of(context).primaryBackground,
//                           ),
//                           alignment: AlignmentDirectional(-1, 0),
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
//                             child: Text(
//                               'Sign Up',
//                               style:
//                                   FlutterFlowTheme.of(context).title1.override(
//                                         fontFamily: 'Poppins',
//                                         color: FlutterFlowTheme.of(context)
//                                             .secondaryText,
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Text(
//                         'Use the form below, to access your account.',
//                         style: FlutterFlowTheme.of(context).bodyText2,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 6,
//                           color: Color(0x3416202A),
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
//                       child: TextFormField(
//                         controller: emailTextController,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           labelText: 'Your email address',
//                           labelStyle: FlutterFlowTheme.of(context).bodyText2,
//                           hintStyle: FlutterFlowTheme.of(context).bodyText2,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           filled: true,
//                           fillColor:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           contentPadding:
//                               EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 6,
//                           color: Color(0x3416202A),
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
//                       child: TextFormField(
//                         controller: passwordTextController,
//                         obscureText: !passwordVisibility,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           labelStyle: FlutterFlowTheme.of(context).bodyText2,
//                           hintStyle: FlutterFlowTheme.of(context).bodyText2,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           filled: true,
//                           fillColor:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           contentPadding:
//                               EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
//                           suffixIcon: InkWell(
//                             onTap: () => setState(
//                               () => passwordVisibility = !passwordVisibility,
//                             ),
//                             focusNode: FocusNode(skipTraversal: true),
//                             child: Icon(
//                               passwordVisibility
//                                   ? Icons.visibility_outlined
//                                   : Icons.visibility_off_outlined,
//                               color: Color(0xFF757575),
//                               size: 22,
//                             ),
//                           ),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: FFButtonWidget(
//                           onPressed: () async {
//                             GoRouter.of(context).prepareAuthEvent();

//                             final user = await signInWithEmail(
//                               context,
//                               emailTextController!.text,
//                               passwordTextController!.text,
//                             );
//                             if (user == null) {
//                               return;
//                             }

//                             context.goNamedAuth('setting', mounted);
//                           },
//                           text: 'Login',
//                           options: FFButtonOptions(
//                             width: 150,
//                             height: 50,
//                             color: Color(0xFF147536),
//                             textStyle:
//                                 FlutterFlowTheme.of(context).subtitle1.override(
//                                       fontFamily: 'Poppins',
//                                       color: Colors.white,
//                                     ),
//                             elevation: 3,
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 1,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
//                             child: FlutterFlowIconButton(
//                               borderColor: Colors.transparent,
//                               borderRadius: 30,
//                               borderWidth: 1,
//                               buttonSize: 50,
//                               fillColor: FlutterFlowTheme.of(context)
//                                   .secondaryBackground,
//                               icon: FaIcon(
//                                 FontAwesomeIcons.google,
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 size: 24,
//                               ),
//                               onPressed: () async {
//                                 GoRouter.of(context).prepareAuthEvent();
//                                 final user = await signInWithGoogle(context);
//                                 if (user == null) {
//                                   return;
//                                 }

//                                 context.goNamedAuth('setting', mounted);
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
//                             child: FlutterFlowIconButton(
//                               borderColor: Colors.transparent,
//                               borderRadius: 30,
//                               borderWidth: 1,
//                               buttonSize: 50,
//                               fillColor: FlutterFlowTheme.of(context)
//                                   .secondaryBackground,
//                               icon: FaIcon(
//                                 FontAwesomeIcons.apple,
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 size: 24,
//                               ),
//                               onPressed: () async {
//                                 GoRouter.of(context).prepareAuthEvent();
//                                 final user = await signInWithApple(context);
//                                 if (user == null) {
//                                   return;
//                                 }

//                                 context.goNamedAuth('setting', mounted);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

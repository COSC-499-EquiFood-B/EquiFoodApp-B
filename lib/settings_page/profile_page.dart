// import '../auth/auth_util.dart';
// import '../backend/backend.dart';
// import '../backend/firebase_storage/storage.dart';
// import '../flutter_flow/flutter_flow_icon_button.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
// import '../flutter_flow/upload_media.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProflieWidget extends StatefulWidget {
//   const ProflieWidget({Key? key}) : super(key: key);

//   @override
//   _ProflieWidgetState createState() => _ProflieWidgetState();
// }

// class _ProflieWidgetState extends State<ProflieWidget> {
//   bool isMediaUploading = false;
//   String uploadedFileUrl = '';

//   TextEditingController? yourNameController;
//   TextEditingController? myBioController;
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     myBioController = TextEditingController();
//     yourNameController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     myBioController?.dispose();
//     yourNameController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<UserRecord>(
//       stream: UserRecord.getDocument(currentUserReference!),
//       builder: (context, snapshot) {
//         // Customize what your widget looks like when it's loading.
//         if (!snapshot.hasData) {
//           return Center(
//             child: SizedBox(
//               width: 50,
//               height: 50,
//               child: CircularProgressIndicator(
//                 color: FlutterFlowTheme.of(context).primaryColor,
//               ),
//             ),
//           );
//         }
//         final proflieUserRecord = snapshot.data!;
//         return Scaffold(
//           key: scaffoldKey,
//           backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(100),
//             child: AppBar(
//               backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//               automaticallyImplyLeading: false,
//               title: Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                             child: FlutterFlowIconButton(
//                               borderColor: Colors.transparent,
//                               borderRadius: 30,
//                               borderWidth: 1,
//                               buttonSize: 50,
//                               icon: Icon(
//                                 Icons.arrow_back_rounded,
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 size: 30,
//                               ),
//                               onPressed: () async {
//                                 context.pop();
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
//                       child: Text(
//                         'Edit Profile',
//                         style: FlutterFlowTheme.of(context).title2.override(
//                               fontFamily: 'Inter',
//                               color: FlutterFlowTheme.of(context).primaryText,
//                               fontSize: 22,
//                             ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [],
//               centerTitle: true,
//               elevation: 0,
//             ),
//           ),
//           body: SafeArea(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFDBE2E7),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
//                         child: AuthUserStreamWidget(
//                           child: InkWell(
//                             onTap: () async {
//                               final userUpdateData = {
//                                 'photo_url': FieldValue.delete(),
//                               };
//                               await proflieUserRecord.reference
//                                   .update(userUpdateData);
//                             },
//                             child: Container(
//                               width: 90,
//                               height: 90,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Image.network(
//                                 currentUserPhoto,
//                                 fit: BoxFit.fitWidth,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 16),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       AuthUserStreamWidget(
//                         child: FutureBuilder<List<UserRecord>>(
//                           future: queryUserRecordOnce(
//                             queryBuilder: (userRecord) => userRecord.where(
//                                 'photo_url',
//                                 isEqualTo: currentUserPhoto),
//                             singleRecord: true,
//                           ),
//                           builder: (context, snapshot) {
//                             // Customize what your widget looks like when it's loading.
//                             if (!snapshot.hasData) {
//                               return Center(
//                                 child: SizedBox(
//                                   width: 40,
//                                   height: 40,
//                                   child: CircularProgressIndicator(
//                                     color: FlutterFlowTheme.of(context)
//                                         .primaryColor,
//                                   ),
//                                 ),
//                               );
//                             }
//                             List<UserRecord> buttonUserRecordList =
//                                 snapshot.data!;
//                             // Return an empty Container when the document does not exist.
//                             if (snapshot.data!.isEmpty) {
//                               return Container();
//                             }
//                             final buttonUserRecord =
//                                 buttonUserRecordList.isNotEmpty
//                                     ? buttonUserRecordList.first
//                                     : null;
//                             return FFButtonWidget(
//                               onPressed: () async {
//                                 final selectedMedia =
//                                     await selectMediaWithSourceBottomSheet(
//                                   context: context,
//                                   allowPhoto: true,
//                                 );
//                                 if (selectedMedia != null &&
//                                     selectedMedia.every((m) =>
//                                         validateFileFormat(
//                                             m.storagePath, context))) {
//                                   setState(() => isMediaUploading = true);
//                                   var downloadUrls = <String>[];
//                                   try {
//                                     showUploadMessage(
//                                       context,
//                                       'Uploading file...',
//                                       showLoading: true,
//                                     );
//                                     downloadUrls = (await Future.wait(
//                                       selectedMedia.map(
//                                         (m) async => await uploadData(
//                                             m.storagePath, m.bytes),
//                                       ),
//                                     ))
//                                         .where((u) => u != null)
//                                         .map((u) => u!)
//                                         .toList();
//                                   } finally {
//                                     ScaffoldMessenger.of(context)
//                                         .hideCurrentSnackBar();
//                                     isMediaUploading = false;
//                                   }
//                                   if (downloadUrls.length ==
//                                       selectedMedia.length) {
//                                     setState(() =>
//                                         uploadedFileUrl = downloadUrls.first);
//                                     showUploadMessage(context, 'Success!');
//                                   } else {
//                                     setState(() {});
//                                     showUploadMessage(
//                                         context, 'Failed to upload media');
//                                     return;
//                                   }
//                                 }
//                               },
//                               text: 'Change Photo',
//                               options: FFButtonOptions(
//                                 width: 130,
//                                 height: 40,
//                                 color: FlutterFlowTheme.of(context)
//                                     .primaryBackground,
//                                 textStyle: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Lexend Deca',
//                                       color: FlutterFlowTheme.of(context)
//                                           .primaryColor,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                                 elevation: 1,
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 1,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
//                   child: StreamBuilder<UserRecord>(
//                     stream: UserRecord.getDocument(proflieUserRecord.reference),
//                     builder: (context, snapshot) {
//                       // Customize what your widget looks like when it's loading.
//                       if (!snapshot.hasData) {
//                         return Center(
//                           child: SizedBox(
//                             width: 40,
//                             height: 40,
//                             child: CircularProgressIndicator(
//                               color: FlutterFlowTheme.of(context).primaryColor,
//                             ),
//                           ),
//                         );
//                       }
//                       final yourNameUserRecord = snapshot.data!;
//                       return TextFormField(
//                         controller: yourNameController,
//                         onFieldSubmitted: (_) async {
//                           final userUpdateData = {
//                             'display_name': FieldValue.delete(),
//                           };
//                           await currentUserReference!.update(userUpdateData);
//                         },
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           labelText: 'Your Name',
//                           labelStyle: FlutterFlowTheme.of(context).bodyText2,
//                           hintStyle: FlutterFlowTheme.of(context).bodyText2,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context)
//                                   .primaryBackground,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context)
//                                   .primaryBackground,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(0x00000000),
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           filled: true,
//                           fillColor:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           contentPadding:
//                               EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                         maxLines: null,
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
//                   child: TextFormField(
//                     controller: myBioController,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       labelStyle: FlutterFlowTheme.of(context).bodyText2,
//                       hintText: 'Your bio',
//                       hintStyle: FlutterFlowTheme.of(context).bodyText2,
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: FlutterFlowTheme.of(context).primaryBackground,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: FlutterFlowTheme.of(context).primaryBackground,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0x00000000),
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0x00000000),
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       filled: true,
//                       fillColor:
//                           FlutterFlowTheme.of(context).secondaryBackground,
//                       contentPadding:
//                           EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
//                     ),
//                     style: FlutterFlowTheme.of(context).bodyText1,
//                     textAlign: TextAlign.start,
//                     maxLines: 3,
//                   ),
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(0, 0.05),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
//                     child: FFButtonWidget(
//                       onPressed: () async {
//                         context.pop();
//                       },
//                       text: 'Save Changes',
//                       options: FFButtonOptions(
//                         width: 340,
//                         height: 60,
//                         color: FlutterFlowTheme.of(context).primaryColor,
//                         textStyle:
//                             FlutterFlowTheme.of(context).subtitle2.override(
//                                   fontFamily: 'Lexend Deca',
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                         elevation: 2,
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }




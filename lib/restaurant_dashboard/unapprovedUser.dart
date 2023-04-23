// this page is rendered when an unapproved Restaurant User logs in

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../login/login_widget.dart';

class UnapprovedUserWidget extends StatefulWidget {
  const UnapprovedUserWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnapprovedUserWidget();
}

class _UnapprovedUserWidget extends State<UnapprovedUserWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // function to sign out the user WITH EMAIL AND PASSWORD
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 243, 248, 249),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: Color.fromRGBO(38, 189, 104, 1),
            automaticallyImplyLeading: false,
            title: Text(
              'Hello, Restaurant user  👋',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Inter',
                    color: Color.fromRGBO(247, 255, 250, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            centerTitle: false,
            toolbarHeight: double.infinity,
            elevation: 2,
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
                            content:
                                Text('Are you sure you want to sign out? '),
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
          ),
        ),
        body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Text.rich(
                        TextSpan(
                          text: "Your account is pending approval from the admin.\n" +
                              "It may take up to 2 business days from the date of account creation for the admins to approve your account.\n" +
                              "\nIf you still haven't heard from our team, please contact us at: ",
                          style: TextStyle(fontWeight: FontWeight.w300),
                          children: <InlineSpan>[
                            TextSpan(
                                text: "adminteam@equifoodb.com",
                                style: TextStyle(fontWeight: FontWeight.w700))
                          ],
                        ),
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color.fromARGB(255, 113, 113, 116),
                            fontSize: 16,
                            fontStyle: FontStyle.italic))))));
  }
}

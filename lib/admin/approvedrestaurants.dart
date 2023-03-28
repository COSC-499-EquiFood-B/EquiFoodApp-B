import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/login_widget.dart';
import 'getApprovedRestaurants.dart';

class ApprovedrestaurantsWidget extends StatefulWidget {
  const ApprovedrestaurantsWidget({Key? key}) : super(key: key);

  @override
  _ApprovedrestaurantsWidgetState createState() =>
      _ApprovedrestaurantsWidgetState();
}

class _ApprovedrestaurantsWidgetState extends State<ApprovedrestaurantsWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? textController;

  // get reference of the current Restaurant User
  final currAdminUser = FirebaseAuth.instance.currentUser;
  late String? userName = "";

  // List to store restaurant donation IDs
  List<String> restaurantIDs = [];

  // creating reference to "donations" Collection in firebase
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // bug fix for FutureBuilder re-rendering Cards multiple times
  late Future dataFuture;

  Future getRestaurantIDs() async {
    // get donation IDs from the "donations" Collection
    // and then store them in the "restaurantDonationIDs" List.

    // get reference of the current Restaurant User
    final currAdminUser = FirebaseAuth.instance.currentUser;

    // create reference for the current Restaurant User located in the "users" collection on firebase
    final adminUserRef =
        FirebaseFirestore.instance.collection("users").doc(currAdminUser?.uid);

    await FirebaseFirestore.instance
        .collection('users')
        .where('user_type', isEqualTo: 2)
        .where('is_approved', isEqualTo: true)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((element) {
                // add restaurant Donation IDs to the List
                restaurantIDs.add(element.reference.id);
                print(element.reference.id);
              })
            });
  }

  // function to sign out the user WITH EMAIL AND PASSWORD
  Future signOutUser() async {
    // log out user
    await FirebaseAuth.instance.signOut();

    // redirect user to the Login page
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginWidget()));
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();

    userName = currAdminUser?.displayName;

    // bug-fix for FutureBuilder
    dataFuture = getRestaurantIDs();
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
          'Approved Restaurants',
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
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                    future: dataFuture, // bug-fix for FutureBuilder
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //Error Handling conditions
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && snapshot.data != null) {
                        return Text("Document does not exist");
                      }

                      //Data is output to the user
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 6.2,
                          ),
                          scrollDirection:
                              Axis.vertical, // required for infinite scrolling
                          shrinkWrap: true, // required for infinite scrolling
                          itemCount: restaurantIDs.length,
                          itemBuilder: (context, int index) {
                            return getRestaurants(
                                restaurantIDs: restaurantIDs[index]);
                          },
                        );
                      }
                      // Loading Spinner at the centre of the page
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(209, 255, 189, 1),
                            ),
                          ));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

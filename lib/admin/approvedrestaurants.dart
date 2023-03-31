import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

//Firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/login_widget.dart';
import 'getApprovedRestaurants.dart';

// This is the "Approved Restaurants" tab on the Admin Screen
class ApprovedRestaurantsPage extends StatefulWidget {
  const ApprovedRestaurantsPage({Key? key}) : super(key: key);

  @override
  _ApprovedRestaurantsPageState createState() =>
      _ApprovedRestaurantsPageState();
}

class _ApprovedRestaurantsPageState extends State<ApprovedRestaurantsPage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? textController;

  // creating reference to "donations" Collection in firebase
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Stream for StreamBuilder
  // create Stream to get Approved Restaurants from the "users" Collection
  late final Stream<QuerySnapshot> approvedRestaurantsStream = FirebaseFirestore
      .instance
      .collection("users")
      .where('user_type', isEqualTo: 2)
      .where("is_approved",
          isEqualTo:
              true) // only get Donations which are not reserved (is_reserved = false)
      .snapshots();

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
                StreamBuilder(
                    stream:
                        approvedRestaurantsStream, // bug-fix for FutureBuilder
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      //Error Handling conditions
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Loading Spinner at the centre of the page
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(38, 189, 104, 1),
                              ),
                            ));
                      }

                      // if the data has loaded properly, do the following

                      // if there are current no approved restaurants available, display text
                      if (snapshot.data!.docs.length == 0) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                                child: Text(
                                    "There are no approved restaurants. Head to the Dashboard to approve Restaurant accounts.",
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                            fontFamily: 'Inter',
                                            color: Color.fromARGB(
                                                255, 113, 113, 116),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic))));
                      }

                      // if the snapshot has data, display it
                      // displaying list of Approved Restaurants
                      return GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 6.2,
                        scrollDirection:
                            Axis.vertical, // required for infinite scrolling
                        shrinkWrap: true, // required for infinite scrolling
                        // for each document, contained within the snapshot,
                        // generate a card layout
                        children: snapshot.data!.docs.map((document) {
                          // get document (info of an Approved Restaurant)
                          // one document at a time
                          Map<String, dynamic> restaurantData =
                              document.data()! as Map<String, dynamic>;

                          // render Cards for Approved Restaurants by sending info to them
                          return ApprovedRestaurantCard(
                            restaurantID: document.id,
                            restaurantData: restaurantData,
                          );
                        }).toList(),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

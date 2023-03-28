import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

//Firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/login_widget.dart';
import 'getReservedOrders.dart';

class ReservedOrdersWidget extends StatefulWidget {
  const ReservedOrdersWidget({Key? key}) : super(key: key);

  @override
  _ReservedOrdersWidgetState createState() => _ReservedOrdersWidgetState();
}

class _ReservedOrdersWidgetState extends State<ReservedOrdersWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? textController;

  // get reference of the current Restaurant User
  final currIndivUser = FirebaseAuth.instance.currentUser;
  late String? userName = "";

  // List to store restaurant donation IDs
  List<String> donationIDs = [];

  // creating reference to "donations" Collection in firebase
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // bug fix for FutureBuilder re-rendering Cards multiple times
  late Future dataFuture;

  Future getDonationIDs() async {
    // get donation IDs from the "donations" Collection
    // and then store them in the "restaurantDonationIDs" List.

    // get reference of the current Restaurant User
    final currIndivUser = FirebaseAuth.instance.currentUser;

    // create reference for the current Restaurant User located in the "users" collection on firebase
    print(currIndivUser?.uid);
  }

  // creating Stream for the Streambuilder
  // this stream makes accessible the documents in the "donations" Collection
  // and it keeps listening for changes (create, update, delete)
  late final Stream<QuerySnapshot> donationsStream = FirebaseFirestore.instance
      .collection("donations")
      .where("customer_id",
          isEqualTo: currIndivUser
              ?.uid) // only get Donations which are not reserved (is_reserved = true)
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

    userName = currIndivUser?.displayName;

    // bug-fix for FutureBuilder
    dataFuture = getDonationIDs();
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
          'Orders',
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
                    stream: donationsStream, // bug-fix for FutureBuilder
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

                      //Data is output to the user
                      if (snapshot.data!.docs.length == 0) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                                child: Text(
                                    "You have no reserved donations at the moment.",
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
                      // display reserved donations
                      return GridView.count(
                          crossAxisCount: 1,
                          childAspectRatio: 6.2,
                          scrollDirection:
                              Axis.vertical, // required for infinite scrolling
                          shrinkWrap: true, // required for infinite scrolling

                          children: snapshot.data!.docs.map((document) {
                            Map<String, dynamic> donationData =
                                document.data()! as Map<String, dynamic>;

                            return getReservedOrders(
                                donationIDs: document.id,
                                donationData: donationData);
                          }).toList());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

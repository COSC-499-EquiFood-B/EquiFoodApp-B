import 'package:equi_food_app/index.dart';
import 'package:equi_food_app/indiv_dashboard/getDonations.dart';
import 'package:equi_food_app/indiv_dashboard/reservedOrders.dart';
import 'package:equi_food_app/restaurant_dashboard/restaurantSettings.dart';
import 'package:equi_food_app/statspages/statisticsforindiv.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

//firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';

class HmepageWidget extends StatefulWidget {
  const HmepageWidget({Key? key}) : super(key: key);

  @override
  _HmepageWidgetState createState() => _HmepageWidgetState();
}

class _HmepageWidgetState extends State<HmepageWidget> {
  // Navbar
  int _selectedIndex = 0;
  List<Widget> _screens = [
    HmepageWidget(),
    ReservedOrdersWidget(),
    StatisticsforindivWidget(),
    SettingsWidget(),
  ];

  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // get reference of the current Restaurant User
  final currIndivUser = FirebaseAuth.instance.currentUser;
  late String? userName = "";

  // List to store restaurant donation IDs
  List<String> donationIDs = [];

  // creating reference to "donations" Collection in firebase
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  // bug fix for FutureBuilder re-rendering Cards multiple times
  late Future dataFuture;

  // method to get IDs for restaurant donations,
  // stored under "donations" Collection in firebase
  Future getDonationIDs() async {
    // get donation IDs from the "donations" Collection
    // and then store them in the "restaurantDonationIDs" List.

    await FirebaseFirestore.instance
        .collection('donations')
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((element) {
                // add restaurant Donation IDs to the List
                donationIDs.add(element.reference.id);
              })
            });
  }

  // creating Stream for the Streambuilder
  // this stream makes accessible the documents in the "donations" Collection
  // and it keeps listening for changes (create, update, delete)
  late final Stream<QuerySnapshot> donationsStream = FirebaseFirestore.instance
      .collection("donations")
      .where("is_reserved",
          isEqualTo:
              false) // only get Donations which are not reserved (is_reserved = false)
      .snapshots();

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
    textController = TextEditingController();

    userName = currIndivUser?.displayName;

    // bug-fix for FutureBuilder
    dataFuture = getDonationIDs();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 243, 248, 249),
      // APPBAR
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Color.fromRGBO(38, 189, 104, 1),
              automaticallyImplyLeading: false,
              title: Text(
                'Hello, $userName  👋',
                style: FlutterFlowTheme.of(context).title2.override(
                      fontFamily: 'Inter',
                      color: Color.fromRGBO(247, 255, 250, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
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
              centerTitle: false,
              elevation: 0,
            )
          : null,
      body: _selectedIndex == 0
          ? GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                      child: TextFormField(
                        controller: textController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Search restaurants...',
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Color(0xFF57636C),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Inter',
                              color: Color(0xFF14181B),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
                            child: Text(
                              'Restaurants',
                              style: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
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
                          // if data is still loading
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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

                          // if there are current no donations available, display text
                          if (snapshot.data!.docs.length == 0) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                    child: Text(
                                        "There are no donations available at the moment. Check back later!",
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

                          // or else, show the available Donations
                          return GridView.count(
                              scrollDirection: Axis
                                  .vertical, // required for infinite scrolling
                              shrinkWrap:
                                  true, // required for infinite scrolling
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2.0),
                              children: snapshot.data!.docs.map((doc) {
                                // get document (info of a Donation item)
                                Map<String, dynamic> donationData =
                                    doc.data()! as Map<String, dynamic>;

                                // render Donation Cards by sending info to them
                                return getDonations(
                                    donationsID: doc.id,
                                    donationData: donationData);
                              }).toList());
                        })
                  ],
                ),
              ),
            )
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color.fromRGBO(38, 189, 104, 1),
        unselectedItemColor: Color.fromRGBO(194, 194, 194, 1),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Savings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedLabelStyle: TextStyle(fontFamily: 'Inter'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Inter'),
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
    );
  }
}

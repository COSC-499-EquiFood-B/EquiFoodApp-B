import 'package:equi_food_app/admin/approvedrestaurants.dart';
import 'package:equi_food_app/restaurant_dashboard/restaurantSettings.dart';
import 'package:equi_food_app/statspages/statisticsforadmin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

//Import code to link to database
import '../login/login_widget.dart';
import 'getUnapprovedRestaurants.dart';

//Firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminpageWidget extends StatefulWidget {
  const AdminpageWidget({Key? key}) : super(key: key);

  @override
  _AdminpageWidgetState createState() => _AdminpageWidgetState();
}

class _AdminpageWidgetState extends State<AdminpageWidget> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    AdminpageWidget(),
    ApprovedRestaurantsPage(),
    StatisticsforadminWidget(),
    SettingsWidget(),
  ];

  final _unfocusNode = FocusNode();

  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // get reference of the current Restaurant User
  final currAdminUser = FirebaseAuth.instance.currentUser;
  late String? userName = "";

  // List to store restaurant donation IDs
  List<String> restaurantIDs = [];

  // creating reference to "donations" Collection in firebase
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Stream for Streambuilder
  // get list of unapproved restaurants from the "users" Collection
  late final Stream<QuerySnapshot> unapprovedRestaurantsStream = FirebaseFirestore
      .instance
      .collection("users")
      .where('user_type', isEqualTo: 2)
      .where("is_approved",
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

    userName = currAdminUser?.displayName;
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
      // APPBAR
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Color.fromRGBO(38, 189, 104, 1),
              automaticallyImplyLeading: false,
              title: Text(
                'Admin Dashboard  👋',
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
                            child: Text(
                              'Waiting Approval',
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
                        stream:
                            unapprovedRestaurantsStream, // bug-fix for FutureBuilder
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          //Error Handling conditions
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          // if data is stil loading, show loading spinner
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

                          // if there are current no Unapproved restaurants, display text
                          if (snapshot.data!.docs.length == 0) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.74,
                                child: Center(
                                    child: Text(
                                        "There are no unapproved restaurants. You can review the approved restaurants in the Approved tab.",
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

                          // if there are unapproved restaurants, display them
                          return GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2.1),
                              scrollDirection: Axis
                                  .vertical, // required for infinite scrolling
                              shrinkWrap:
                                  true, // required for infinite scrolling
                              children: snapshot.data!.docs.map((document) {
                                // get document (info of an Unapproved Restaurant)
                                // one document at a time
                                Map<String, dynamic> restaurantData =
                                    document.data()! as Map<String, dynamic>;

                                // render Cards for Unapproved Restaurants by sending info to them
                                return UnapprovedRestaurantCard(
                                    restaurantID: document.id,
                                    restaurantData: restaurantData);
                              }).toList());
                        })
                  ],
                ),
              ),
            )
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 76, 191, 82),
        unselectedItemColor: Color(0x8A000000),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.approval),
            label: 'Approved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
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

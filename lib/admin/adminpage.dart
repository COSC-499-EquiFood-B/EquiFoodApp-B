import 'package:equi_food_app/admin/approvedrestaurants.dart';
import 'package:equi_food_app/restaurant_dashboard/restaurantSettings.dart';
import 'package:equi_food_app/statspages/statisticsforadmin.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Import code to link to database
import 'getAdminRestaurants.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
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
    ApprovedrestaurantsWidget(),
    StatisticsforadminWidget(),
    SettingsWidget(),
  ];

  final _unfocusNode = FocusNode();

  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // List to store restaurant donation IDs
  List<String> restaurantIDs = [];

  // creating reference to "donations" Collection in firebase
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // bug fix for FutureBuilder re-rendering Cards multiple times
  late Future dataFuture;

  // method to get IDs for restaurant donations,
  // stored under "donations" Collection in firebase
  Future getRestaurantIDs() async {
    // get donation IDs from the "donations" Collection
    // and then store them in the "restaurantDonationIDs" List.

    await FirebaseFirestore.instance
        .collection('users')
        .where('user_type', isEqualTo: 2)
        .where('is_approved', isEqualTo: false)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((element) {
                // add restaurant Donation IDs to the List
                restaurantIDs.add(element.reference.id);
                print("Hi");
                print(element.reference.id);
              })
            });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();

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
      backgroundColor: Color(0xFFACE4AF),
      // APPBAR
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Color(0xFFACE4AF),
              automaticallyImplyLeading: false,
              title: Text(
                'Hello, Jason',
                style: FlutterFlowTheme.of(context).title2.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF14181B),
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              actions: [],
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
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                            child: Text(
                              'Restaurants',
                              style: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Text(
                            'See All',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF14181B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: dataFuture, // bug-fix for FutureBuilder
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          //Error Handling conditions
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && snapshot.data != null) {
                            return Text("Document does not exist");
                          }

                          //Data is output to the user
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                //crossAxisSpacing: 0.0,
                                //mainAxisSpacing: 10.0,
                              ),
                              scrollDirection: Axis
                                  .vertical, // required for infinite scrolling
                              shrinkWrap:
                                  true, // required for infinite scrolling
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
                                  color: Color.fromARGB(255, 52, 185, 59),
                                ),
                              ));
                        })
                  ],
                ),
              ),
            )
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: FlutterFlowTheme.of(context).primaryColor,
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

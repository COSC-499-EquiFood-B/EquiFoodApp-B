import 'package:equi_food_app/index.dart';
import 'package:equi_food_app/indiv_dashboard/default-stats.dart';
import 'package:equi_food_app/indiv_dashboard/getDonations.dart';
import 'package:equi_food_app/restaurant_dashboard/restaurantSettings.dart';
import 'package:equi_food_app/statspages/statisticsforindiv.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//firebase imports
import 'package:firebase_core/firebase_core.dart';
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
    PickupMapWidget(),
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
      backgroundColor: Color(0xFFACE4AF),
      // APPBAR
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Color(0xFFACE4AF),
              automaticallyImplyLeading: false,
              title: Text(
                'Hello, $userName',
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
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
                              fontFamily: 'Outfit',
                              color: Color(0xFF14181B),
                              fontSize: 12,
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
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
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
                              itemCount: donationIDs.length,
                              itemBuilder: (context, int index) {
                                return getDonations(
                                    donationsID: donationIDs[index]);
                              },
                            );
                          }
                          // Loading Spinner at the centre of the page
                          return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFACE4AF),
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
            icon: Icon(Icons.map),
            label: 'Map',
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

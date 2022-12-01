import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// imports for database-related stuff
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import Widget to display Donations Data for the Restaurant User
import './getDonationsData.dart';

// import pages for the NavBar
import './restaurantSettings.dart';
import './createDonation.dart';

class DonationsWidget extends StatefulWidget {
  const DonationsWidget({Key? key}) : super(key: key);

  @override
  _DonationsWidgetState createState() => _DonationsWidgetState();
}

class _DonationsWidgetState extends State<DonationsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // get reference of the current Restaurant User
  final currRestaurantUser = FirebaseAuth.instance.currentUser;

  // List to store restaurant donation IDs
  List<String> restaurantDonationIDs = [];

  // creating reference to "donations" Collection in firebase
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  // Navbar
  int selectedIndex = 0;

  // screens to show on Nav-Bar
  List<Widget> screens = [
    DonationsWidget(),
    CreateDonationWidget(),
    SettingsWidget(),
  ];

  // method to get IDs for restaurant donations,
  // stored under "donations" Collection in firebase
  Future getRestaurantDonationIDs() async {
    // get donation IDs from the "donations" Collection
    // and then store them in the "restaurantDonationIDs" List.
    await FirebaseFirestore.instance
        .collection('donations')
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((element) {
                // add restaurant Donation IDs to the List
                restaurantDonationIDs.add(element.reference.id);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: Color(0xFFACE4AF),
            automaticallyImplyLeading: false,
            title: Text(
              'Donations',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 70,
                icon: Icon(
                  Icons.add,
                  color: Color(0xFFFEFEFE),
                  size: 30,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ],
            centerTitle: false,
            toolbarHeight: double.infinity,
            elevation: 2,
          ),
        ),
        body: selectedIndex == 0
            ? SafeArea(
                // show Donation Cards if selectedIndex == 0
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.circle,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: getRestaurantDonationIDs(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
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
                                  return ListView.builder(
                                    scrollDirection: Axis
                                        .vertical, // required for infinite scrolling
                                    shrinkWrap:
                                        true, // required for infinite scrolling
                                    itemCount: restaurantDonationIDs.length,
                                    itemBuilder: (context, int index) {
                                      // return Widget generating Card for a Donation with a donationID sent to it
                                      return GetDonationsData(
                                          donationsID:
                                              restaurantDonationIDs[index]);
                                    },
                                  );
                                }

                                return Text("loading");
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : screens[selectedIndex], // show the page clicked on the Nav-Bar
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
              icon: Icon(Icons.add_box_rounded),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (int index) {
            // set selectedIndex to index of icon clicked on the Nav-Bar
            setState(() {
              selectedIndex = index;
            });
          },
        ));
  }
}

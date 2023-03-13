import 'package:equi_food_app/index.dart';
import 'package:equi_food_app/restaurant_dashboard/donationCard.dart';
import 'package:equi_food_app/statspages/statisticsforresto.dart';

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
    StatisticsforrestoWidget(),
    SettingsWidget(),
  ];

  late Future dataFuture;

  final currentRestaurantUser = FirebaseAuth.instance.currentUser;

  // get current restaurant user's ref
  // create reference for the current Restaurant User located in the "users" collection on firebase
  late final restaurantUserRef = FirebaseFirestore.instance
      .collection("users")
      .doc(currentRestaurantUser?.uid);

  late String? userName = "";

  // method to get IDs for restaurant donations,
  // stored under "donations" Collection in firebase
  Future getRestaurantDonationIDs() async {
    // get reference of the current Restaurant User
    final currRestaurantUser = FirebaseAuth.instance.currentUser;

    // create reference for the current Restaurant User located in the "users" collection on firebase
    final restaurantUserRef = FirebaseFirestore.instance
        .collection("users")
        .doc(currRestaurantUser?.uid);

    // get donation IDs of the current Restaurant User from the "donations" Collection
    // and then store them in the "restaurantDonationIDs" List.
    await FirebaseFirestore.instance
        .collection('donations')
        .where("restaurant_ref", isEqualTo: restaurantUserRef)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((element) {
                // add restaurant Donation IDs to the List
                restaurantDonationIDs.add(element.reference.id);
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

    userName = currentRestaurantUser?.displayName;
    dataFuture = getRestaurantDonationIDs();
  }

  late final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
      .collection('donations')
      .where("restaurant_ref",
          isEqualTo: FirebaseFirestore.instance
              .collection("users")
              .doc(currentRestaurantUser?.uid))
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 243, 248, 249),
        appBar: selectedIndex == 0
            ? PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: AppBar(
                  backgroundColor: Color.fromRGBO(38, 189, 104, 1),
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Hello, $userName',
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
                      onPressed: signOutUser,
                      icon: const Icon(Icons.logout_outlined),
                      iconSize: 25,
                    ),
                  ],
                ),
              )
            : null, // don't render AppBar for this page if user navigates to different page
        body: selectedIndex == 0
            ? SafeArea(
                // show Donation Cards if selectedIndex == 0
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder(
                              stream: stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                //Error Handling conditions
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Document does not exist");
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {}

                                // display text if the current
                                // restaurant user has no donations posted.

                                //print();

                                // return Center();
                                return ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((doc) {
                                    Map<String, dynamic> donationsData =
                                        doc.data()! as Map<String, dynamic>;

                                    return DonationCard(
                                        donationsData: donationsData);
                                  }).toList(),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : screens[selectedIndex], // show the page clicked on the Nav-Bar
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
              icon: Icon(Icons.add_box_rounded),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco),
              label: 'Statistics',
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

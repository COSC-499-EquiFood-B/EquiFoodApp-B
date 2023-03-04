// file to render the appropriate Dashboard/Screen based on the user type
// 0 = Admin User, 1 = Individual User, 2 = Restaurant User

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equi_food_app/admin/adminpage.dart';
import 'package:firebase_auth/firebase_auth.dart'; // for auth-related stuff
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import 'package:equi_food_app/indiv_dashboard/indivDashboard.dart'; // Individual Dashboard
import 'package:equi_food_app/restaurant_dashboard/restaurant_dashboard_widget_2.dart'; // Restaurant Dashboard

class RenderDashboardWidget extends StatefulWidget {
  const RenderDashboardWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RenderDashboardWidgetState();
}

class _RenderDashboardWidgetState extends State<RenderDashboardWidget> {
  // function to return code according to current user
  Future getUserType() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    // query the "Users" Collection in Firebase to get the current user's userType
    // get current user snapshot
    final currentUserSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser?.uid)
        .get();

    if (currentUserSnapshot.exists) {
      Map<String, dynamic>? currentUserData = currentUserSnapshot.data();

      // get current user's user_type value to navigate them to the correct screen
      // 0 = Admin User,  1 = Individual User, 2 = Restaurant User
      int userType = currentUserData!['user_type'];

      return userType;
    }

    return -1; // error occurs
  }

  // for FutureBuilder
  // The FutureBuilder waits for this variable to be initialized with the function
  // and then builds the Widget
  late Future userTypeFuture;

  @override
  void initState() {
    super.initState();

    // initialize the future variable
    userTypeFuture = getUserType();
  }

  @override
  Widget build(BuildContext context) {
    // render appropriate Dashboard According to the user-type
    return FutureBuilder(
        future: userTypeFuture,
        builder: ((context, snapshot) {
          // snapshot contains the data returned by our getUserType() function
          if (snapshot.connectionState == ConnectionState.done) {
            Object? userType = snapshot.data; // gets user-type contain
            //print('user type: $userType');

            // render the appropriate Dashboard accoriding to the user-type
            // 0: Admin User, 1: Individual User, 2: Restaurant User
            return userType == 0
                ? AdminpageWidget()
                : userType == 1
                    ? HmepageWidget()
                    : DonationsWidget();
          }

          return Center();
        }));
  }
}

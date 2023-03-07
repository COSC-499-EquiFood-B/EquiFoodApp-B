// page to render the appropriate Dashboard/Screen based on the user type
// 0 = Admin User, 1 = Individual User, 2 = Restaurant User

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equi_food_app/admin/adminpage.dart';
import 'package:equi_food_app/restaurant_dashboard/unapprovedUser.dart';
import 'package:firebase_auth/firebase_auth.dart'; // for auth-related stuff
import 'package:flutter/cupertino.dart';

import 'package:equi_food_app/indiv_dashboard/indivDashboard.dart'; // Individual Dashboard
import 'package:equi_food_app/restaurant_dashboard/restaurant_dashboard_widget_2.dart'; // Restaurant Dashboard

class RenderDashboardWidget extends StatefulWidget {
  const RenderDashboardWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RenderDashboardWidgetState();
}

class _RenderDashboardWidgetState extends State<RenderDashboardWidget> {
  // function to return code according to current user
  Future<List> getUserType() async {
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

      bool isApproved = false;

      // if it's a Restaurant User, also extract the "is_approved" attribute from their document
      if (userType == 2) {
        isApproved = currentUserData['is_approved'];
      }

      // return array containing [userType, isApproved]
      return [userType, isApproved];
    }

    return []; // error occurs
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
            List? userInfo = snapshot.data
                as List?; // gets the list returned from the method
            //print('user type: $userType');

            // extract user_type and is_approved from the list
            int userType = userInfo?[0];
            bool isApproved = userInfo?[1];

            print(userInfo);

            // render the appropriate Dashboard accoriding to the user-type
            // 0: Admin User, 1: Individual User, 2: Restaurant User
            if (userType == 0) {
              // direct to Admin Dashboard
              return AdminpageWidget();
            } else if (userType == 1) {
              // direct to Indiv Dashboard
              return HmepageWidget();
            } else {
              // direct to the Restaurant Dashboard if the user is approved by the admin
              return isApproved ? DonationsWidget() : UnapprovedUserWidget();
            }
          }

          return Center();
        }));
  }
}

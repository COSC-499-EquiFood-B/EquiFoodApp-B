import 'package:equi_food_app/backend/backend.dart';
import 'package:equi_food_app/index.dart';
import 'package:equi_food_app/register/createRestaurantUser.dart';
import 'package:equi_food_app/register/createUser.dart';
import 'package:equi_food_app/utils/displayAlert.dart';
import 'package:equi_food_app/utils/displaySnackbar.dart';

import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart'; // import Firebase package to sign UP users

class SignupAdminWidget extends StatefulWidget {
  const SignupAdminWidget({Key? key}) : super(key: key);

  @override
  _SignupAdminWidgetState createState() => _SignupAdminWidgetState();
}

class _SignupAdminWidgetState extends State<SignupAdminWidget> {
  TextEditingController? nameTextController;
  TextEditingController? emailTextController;
  TextEditingController? passwordTextController;
  TextEditingController? passwordConfirmTextController;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordConfirmTextController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    nameTextController?.dispose();
    emailTextController?.dispose();
    passwordTextController?.dispose();
    super.dispose();
  }

  bool errorcheck() {
    if (nameTextController!.text.isEmpty ||
        emailTextController!.text.isEmpty ||
        passwordTextController!.text.isEmpty) {
      displayAlert(context, "Please fill up text boxes.");
      return false;
    }
    return true;
  }

  // method to sign UP user with email and password
  Future signupAdminUser() async {
    // Sign-UP user only if the password is confirmed
    if (errorcheck() && confirmPassword()) {
      try {
        // Sign-UP user
        // NOTE: the '!' in front of email and password variables is to check if either of these are null
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailTextController!.text.trim(),
                password: passwordTextController!.text.trim())
            .then((value) => {
                  // create user
                  // AKA adding the user details to the "users" Collection in firebase
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(value.user?.uid) // uid = user id
                      .set({
                    "name":
                        nameTextController!.text.toString(), // add user name
                    "email": emailTextController!.text.trim(), // add user email
                    "user_type":
                        0 // user_type field (1 = Individual User, 2 = Restaurant User)
                  })
                });
      } on FirebaseAuthException catch (e) {
        // "e" is basically the error object returned by FirebaseAuthException
        // e.code can be used to find which type of error has occurred.

        // default value of error message
        String errorMsg = "An unknown error occurred. Could not sign up user.";

        // if the user already exists
        if (e.code == 'email-already-in-use') {
          errorMsg = "Email already in use. Please Log in.";
        }
        // if email is invalid
        else if (e.code == "invalid-email") {
          errorMsg = "Invalid email. Please try again.";
        }
        // if password is not strong
        else if (e.code == "weak-password") {
          errorMsg = "Weak Password. Please choose a strong password.";
        }

        // display Snackbar with error message
        displaySnackbar(context, errorMsg);

        return;
      }
      displaySnackbar(context, "Account created successfully");

      _signOut(); // Sign out user
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              LoginWidget())); // redirect user to Login page
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // boolean method to check if the "Password" and "Confirm Password" fields match
  bool confirmPassword() {
    if (passwordTextController!.text.trim() !=
        passwordConfirmTextController!.text.trim()) {
      displayAlert(context, "The password did not match.");
    }
    return passwordTextController!.text.trim() ==
        passwordConfirmTextController!.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () async {
                      context.pop();
                    },
                    child: Image.asset(
                      'assets/images/tempLogo.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginWidget()),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                        ),
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                          child: Text(
                            'Sign In',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 32,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F4F8),
                      ),
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Text(
                          'Sign Up',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF0F1113),
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Get started by creating an account below.',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                // Text Field to enter name
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: TextFormField(
                      controller: nameTextController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
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
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF0F1113),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                // Text Field to enter email
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: TextFormField(
                      controller: emailTextController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
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
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF0F1113),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                // Text Field to enter Password
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: TextFormField(
                      controller: passwordTextController,
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
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
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordVisibility = !passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF57636C),
                            size: 22,
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF0F1113),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                // Text-Field to Confirm Password
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: TextFormField(
                      controller: passwordConfirmTextController,
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
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
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordVisibility = !passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF57636C),
                            size: 22,
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Outfit',
                            color: Color(0xFF0F1113),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                // Sign-up Button
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: signupAdminUser,
                        text: 'Sign up',
                        options: FFButtonOptions(
                          width: 150,
                          height: 50,
                          color: Color(0xFF66BB6A),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: InkWell(
                    child: Text(
                        "Individual user? Register as a individual user",
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Outfit',
                            color: Color.fromARGB(255, 26, 26, 27),
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SignupWidget()))
                        }),
              ),
              // ADD CODE BELOW TO NAVIGATE THE USER TO THE LOGIN PAGE (login_widget)
              // WHEN THEY CLICK THE TEXT BELOW
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                child: InkWell(
                    child: Text.rich(
                        TextSpan(
                          text: "Already a member?",
                          children: <InlineSpan>[
                            TextSpan(
                                text: " Log in",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 17, 154, 233)))
                          ],
                        ),
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Outfit',
                            color: Color.fromARGB(255, 19, 19, 19),
                            fontSize: 16,
                            fontWeight: FontWeight.w300)),
                    onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => LoginWidget()))
                        }),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 50,
                      fillColor: Colors.white,
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xFF0F1113),
                        size: 24,
                      ),
                      onPressed: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        final user = await signInWithGoogle(context);
                        if (user == null) {
                          return;
                        }

                        context.goNamedAuth('setting', mounted);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 50,
                      fillColor: Colors.white,
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                        color: Color(0xFF0F1113),
                        size: 24,
                      ),
                      onPressed: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        final user = await signInWithApple(context);
                        if (user == null) {
                          return;
                        }

                        context.goNamedAuth('setting', mounted);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

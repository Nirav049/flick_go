import 'package:flick_go/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class Auth_screen extends StatelessWidget {
  const Auth_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return SignInScreen();
          }
          else {
            return HomePage();
          }
        });
  }
}

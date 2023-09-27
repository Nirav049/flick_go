import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flick_go/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'pages/homePage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: 'Your client ID here'),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flick_go',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: Auth_screen(),
      //home: HomePage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Auth_screen(),
        // appBar: AppBar(
        // //   title: const Text('Flick Go'),
        // //   backgroundColor: Color.fromRGBO(33, 150, 243, 1),
        // // ),

    );
  }
}


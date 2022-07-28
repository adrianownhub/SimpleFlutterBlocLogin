import 'package:flutter/material.dart';
import 'package:simple_app_bloc/home/home_scaffold.dart';
import 'package:simple_app_bloc/login/login_scaffold.dart';
import 'package:simple_app_bloc/sign_up/sign_up_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Login Form with Bloc',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => LoginScaffold(),
        '/login/signUp': (context) => SignUpScaffold(),
        '/home': (context) => HomeScaffold(),
      },
      initialRoute: '/',
    );
  }
}

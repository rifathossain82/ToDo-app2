import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'constraints/Strings.dart';
import 'pages/Home.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueGrey[900]),
      title: MyString().app_name,
      home: AnimatedSplashScreen(
        splash: Image.asset('imges/todo_icon.png'),
        nextScreen: Home(),
        duration: 2000,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.scaleTransition,
      ),
    );
  }
}

/*

 */
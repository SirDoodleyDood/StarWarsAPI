import 'package:flutter/material.dart';
import 'package:star_wars_api/constants.dart';
import 'package:star_wars_api/pages/tabs_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Wars API',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
      ),
      routes: {
        '/': (context) => TabsPage(),
      },
      initialRoute: '/',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:police/core/injector.dart';

import 'core/routes.dart';
import 'home/home_screen.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.khandTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.route,
      routes: AppRoutes.instance,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:police/core/injector.dart';

import 'core/routes.dart';
import 'core/workers/notification_worker.dart';
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
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
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

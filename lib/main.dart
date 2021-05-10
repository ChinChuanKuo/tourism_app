import 'package:flutter/material.dart';
import 'package:tourism_app/l10n/app_localization.dart';
import 'package:tourism_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tourism',
      localizationsDelegates: AppLocalization.localizationsDelegates,
      supportedLocales: AppLocalization.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFFFEF9EB),
      ),
      initialRoute: Routes.homeRoute,
      onGenerateRoute: RouterGenerator.onGenerateRoute,
    );
  }
}

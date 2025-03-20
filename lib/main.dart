import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realization_project/pages/provider/provider.dart';
import 'information_taxi.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RideProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 16, 70, 96),
        appBarTheme: AppBarTheme(backgroundColor: const Color.fromARGB(255, 16, 70, 96)),
    ),
    
    home: InformationTaxi(),);
  }
}
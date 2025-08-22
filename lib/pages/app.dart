import 'package:flutter/material.dart';
import 'package:podz/pages/games/games.dart';
import 'package:podz/pages/secondScreen/second.dart';
import 'package:podz/pages/shoes/sports.dart';
import 'package:podz/pages/sports/sports.dart';
import 'package:podz/pages/trial_codes.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ShoesPage(),
    );
  }
}

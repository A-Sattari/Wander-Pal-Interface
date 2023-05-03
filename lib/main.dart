import "package:flutter/material.dart";
import "package:wander_pal/presentation/gathering/gathering_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Wander Pal",
        theme: ThemeData(useMaterial3: true),
        home: Container(
          margin: EdgeInsets.only(top: 50),
          child: Scaffold(body: const GatheringPage())));
  }
}
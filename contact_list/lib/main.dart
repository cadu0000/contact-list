import 'package:contact_list/ui/contact_view.dart';
import 'package:contact_list/ui/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => HomeView(),
        ContactView.route : (context) => ContactView()
      },
      initialRoute: "/",
    );
  }
}

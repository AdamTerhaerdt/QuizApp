import 'package:flutter/material.dart';
import 'package:myapp/login/login.dart';
import 'package:myapp/topics/topics.dart';
import 'package:myapp/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Text(
            "Loading.",
            textDirection: TextDirection.ltr,
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            "Something went wrong.",
            textDirection: TextDirection.ltr,
          ));
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

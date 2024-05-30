import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'view/home/home_page.dart';
import 'view/welcome_page.dart';

class MainRoute extends StatelessWidget {
  const MainRoute({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavBar();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}

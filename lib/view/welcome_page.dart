import 'package:flutter/material.dart';

import '../core/configuration/size_config.dart';
import '../core/constant/images/app_images.dart';
import 'auth/login_page.dart';
import 'auth/signup_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isAyahExpanded = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    const Text(
                      "HASSANA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Color.fromARGB(255, 0, 0, 0),
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAyahExpanded = !isAyahExpanded;
                        });
                      },
                      child: Text(
                        isAyahExpanded
                            ? "The example of those who spend their wealth in the way of Allah is like a seed [of grain] that sprouts seven ears; in every ear there are a hundred grains. And Allah multiplies [His reward] for whom He wills."
                            : "The example of those who spend their wealth in the way of Allah...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.logo),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      color: Colors.deepPurple[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

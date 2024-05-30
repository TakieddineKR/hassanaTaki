import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/signup_controller.dart';
import '../../core/functions/validator.dart';
import '../../core/shared/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: signUpController.signUpformstate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text of Create your account
                  const SizedBox(height: 20),

                  const Text(
                    'Create your account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'شكرا على تبرعكم',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Radio buttons for selecting NGO or Restaurant

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: signUpController.radioValue,
                          onChanged: (value) {
                            signUpController.radioValue = value!;
                          },
                        ),
                        const Text(
                          'NGOs',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 50),
                        Radio(
                          value: 2,
                          groupValue: signUpController.radioValue,
                          onChanged: (value) {
                            signUpController.radioValue = value!;
                          },
                        ),
                        const Text(
                          'Resturant',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //username textfield
                  CustomTextField(
                    onSaved: (value) =>
                        signUpController.emailController = value!,
                    hintText: 'Email',
                    validator: (value) => validator(value!, 5, 255, ''),
                    controller: null,
                  ),
                  const SizedBox(height: 10),
                  //User name textfield
                  CustomTextField(
                    onSaved: (value) =>
                        signUpController.usernameController = value!,
                    hintText: 'User Name',
                    validator: (value) => validator(value!, 5, 255, 'username'),
                    controller: null,
                  ),
                  const SizedBox(height: 10),
                  //passsword textfield
                  CustomTextField(
                    onSaved: (value) =>
                        signUpController.passwordController = value!,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) => validator(value!, 5, 255, ''),
                    controller: null,
                  ),
                  const SizedBox(height: 10),
                  //Confirm password textfield
                  CustomTextField(
                    onSaved: (value) =>
                        signUpController.confirmpasswordController = value!,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    validator: (value) => validator(value!, 5, 255, ''),
                    controller: null,
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    onSaved: (value) =>
                        signUpController.adressController = value!,
                    hintText: 'Adress',
                    validator: (value) => validator(value!, 5, 255, ''),
                    controller: null,
                  ),
                  const SizedBox(height: 15),
                  //Phone Number textfield
                  CustomTextField(
                    onSaved: (value) =>
                        signUpController.phoneController = value!,
                    hintText: 'Phone Number',
                    validator: (value) => validator(value!, 5, 255, ''),
                    controller: null,
                  ),

                  const SizedBox(height: 20),
                  //button of create account textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () => signUpController.signUp(),
                        child: const Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // not a member? register now textfield
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a member?  ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        onTap: () => signUpController.navToLogin(),
                        child: const Text(
                          'Log in Now',
                          style: TextStyle(
                            color: Color.fromARGB(255, 10, 131, 197),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
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
      ),
    );
  }
}

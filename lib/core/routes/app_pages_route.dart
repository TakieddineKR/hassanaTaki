import 'package:get/get.dart';

import '../../view/auth/login_page.dart';
import '../../view/auth/signup_page.dart';
import '../../view/home/home_page.dart';
import 'app_routes.dart';

List<GetPage<dynamic>>? getPages = [
  //! ON BOARDING

  // !Auth
  GetPage(name: AppRoute.login, page: () => const LoginPage()),
  GetPage(name: AppRoute.signUp, page: () => const SignUpPage()),

  //! HOME
  GetPage(name: AppRoute.navbar, page: () => const NavBar()),
];

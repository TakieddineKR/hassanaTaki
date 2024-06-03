import 'package:flutter/material.dart';

import 'screens/add_request_screen.dart';
import 'screens/donation_history_screen.dart';
import 'screens/donation_request_page.dart';
import 'screens/settings_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = [
    DonationRequestsPage(),
    const AddRequestScreen(),
    const DonationHistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index], // Display the selected page
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.deepPurple[200],
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index), // Corrected typo here
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.add_outlined,
              ),
              label: 'Request',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.history_edu_outlined,
              ),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

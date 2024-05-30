import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_page_controller.dart';
import '../../../models/order_model.dart';

class HomeDonation extends StatelessWidget {
  const HomeDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation Requests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DonationRequestsPage(),
    );
  }
}

class DonationRequestsPage extends StatefulWidget {
  const DonationRequestsPage({super.key});

  @override
  DonationRequestsPageState createState() => DonationRequestsPageState();
}

class DonationRequestsPageState extends State<DonationRequestsPage> {
  TextEditingController searchController = TextEditingController();
  List<OrderModel> allRequests = [];
  List<OrderModel> filteredRequests = [];

  @override
  void initState() {
    super.initState();
    fetchRequests();
    searchController.addListener(filterList);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void fetchRequests() async {
    HomePageController homePageController = Get.put(HomePageController());

    if (homePageController.userInstance.isNotEmpty) {
      String userType = homePageController.userInstance.first.userType;
      String collectionName =
          userType == 'ngo' ? 'restaurant_requests' : 'ngo_requests';

      FirebaseFirestore.instance
          .collection(collectionName)
          .get()
          .then((querySnapshot) {
        List<OrderModel> requests = querySnapshot.docs.map((doc) {
          return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        setState(() {
          allRequests = requests;
          filteredRequests = requests;
        });
      });
    } else {
      // Handle the case where userInstance is empty
      print('No user data available');
    }
  }

  void filterList() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredRequests = allRequests.where((request) {
        return request.userName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Requests'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search by Organization Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(
                      10), // Add some space around each card
                  color: Colors.lightBlue[50], // Change the color of the list
                  child: ExpansionTile(
                    title: Text(filteredRequests[index].userName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${filteredRequests[index].orderDescription}\n'
                            'Location: ${filteredRequests[index].orderAddress}\n'
                            'Quantity: ${filteredRequests[index].orderAmount}'),
                        Text(
                            'Employee Available: ${filteredRequests[index].hasEmployee ? "Yes" : "No"}'), // Display employee availability
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Implement the accept donation logic
                        print(
                            'Donation accepted for ${filteredRequests[index].userName}');
                      },
                      child: const Text('Accept'),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                'Contact: ${filteredRequests[index].orderPhone}'),
                            Text(
                                'Date: ${filteredRequests[index].orderDate.toString()}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

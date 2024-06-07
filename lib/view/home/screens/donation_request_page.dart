import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hassana/controllers/donations_home_conroller.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationRequestsPage extends StatelessWidget {
  final DonationHomeController donationHomeController =
      Get.put(DonationHomeController());

  DonationRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    donationHomeController.fetchDonationRequests();
    final searchController = donationHomeController.searchController;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Requests'),
        backgroundColor: Colors.deepPurple[200],
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
            child: GetBuilder<DonationHomeController>(builder: (controller) {
              final filteredRequests = controller.filteredRequests;
              if (controller.isLoadingErrorDonation) {
                return const Center(
                  child: Text("Something is wrong, please try later"),
                );
              }
              if (controller.isLoadingDonation) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
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
                              ElevatedButton(
                                onPressed: () async {
                                  final address =
                                      filteredRequests[index].orderAddress;
                                  final url = Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not open the map.';
                                  }
                                },
                                child: const Text('Open in Maps'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

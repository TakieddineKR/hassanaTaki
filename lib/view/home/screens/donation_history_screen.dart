import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/donations_history_conroller.dart';

class DonationHistoryScreen extends StatelessWidget {
  const DonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final donationController = Get.put(DonationHistoryController());
    donationController.fetchDonationRequests();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation History'),
      ),
      body: GetBuilder<DonationHistoryController>(builder: (controller) {
        if (controller.isLoadingErrorDonation) {
          const Center(
            child: Text("Something is wrong, please try later"),
          );
        }
        if (controller.isLoadingDonation) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.donationRequests.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final request = controller.donationRequests[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'NGO: ${request.userName}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        const Text('Phone:'),
                        const Spacer(),
                        Text(request.orderPhone),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        const Text('Quantity:'),
                        const Spacer(),
                        Text('${request.orderAmount}'),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text('Description: ${request.orderDescription}'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        const Text('Date of Pickup:'),
                        const Spacer(),
                        Text(request.orderDate.toString()),
                      ],
                    ),
                    if (request.hasEmployee) ...[
                      const SizedBox(height: 8.0),
                      const Text('Delivery Employee Available'),
                    ],
                    const SizedBox(height: 8.0),
                    Text(
                      'Restaurant: ${request.userName}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Phone: ${request.orderPhone}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement download functionality
                          // This function will be called when the download button is pressed
                        },
                        child: const Text('Download'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

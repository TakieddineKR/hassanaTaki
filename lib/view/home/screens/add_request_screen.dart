import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_request_controller.dart';
import '../../../core/functions/validator.dart';

class AddRequestScreen extends StatelessWidget {
  const AddRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddRequestController addRequestController = Get.put(AddRequestController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Donation Request'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: addRequestController.requestFormKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please enter your request details',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ), // Change text color
                RequestTextField(
                  keyboardType: TextInputType.text,
                  labelText: 'Description',
                  hintText: 'we need chickens and selecto my friends',
                  onChanged: (value) =>
                      addRequestController.description = value,
                  validator: (value) => validator(value!, 5, 255, ''),
                ),
                const SizedBox(height: 20.0),
                RequestTextField(
                  keyboardType: TextInputType.number,
                  labelText: 'Quantity',
                  hintText: '1',
                  onChanged: (value) =>
                      addRequestController.quantity = int.tryParse(value)!,
                  validator: (value) {
                    if (value == null ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Please enter a valid quantity (positive integer).';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RequestTextField(
                  keyboardType: TextInputType.streetAddress,
                  labelText: 'Location',
                  hintText: 'Oran',
                  onChanged: (value) => addRequestController.location = value,
                  validator: (value) => validator(value!, 5, 255, ''),
                ),
                Row(
                  children: [
                    const Text(
                      'Date of Need:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ), // Change text color
                    const Spacer(),
                    TextButton(
                      onPressed: () => showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                        initialEntryMode: DatePickerEntryMode.input,
                        fieldLabelText: 'Select Date',
                        fieldHintText: 'Month/Date/Year',
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          addRequestController.date = selectedDate;
                        }
                      }),
                      child: Text(
                        addRequestController.date.toString().substring(0, 10),
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                RequestTextField(
                  keyboardType: TextInputType.phone,
                  labelText: 'Phone Number',
                  hintText: '0555928275',
                  onChanged: (value) =>
                      addRequestController.phoneNumber = value,
                  validator: (value) => validator(value!, 5, 15, 'phone'),
                ),
                CheckboxListTile(
                  title: const Text(
                    'Delivery Employee Available',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ), // Change text color
                  value: addRequestController.deliveryEmployeeAvailable,
                  onChanged: (newValue) => addRequestController
                      .deliveryEmployeeAvailable = newValue!,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => addRequestController.addRequest(),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Change button color
                  ),
                  child: const Text('Submit Request',
                      style: TextStyle(
                          color: Colors.white)), // Change button text color
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequestTextField extends StatelessWidget {
  const RequestTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.keyboardType,
    required this.validator,
  });

  final String? labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      validator: validator, // Change text color
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ), // Change label text color
        border: OutlineInputBorder(
          // Add border
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Colors.blue), // Change border color
        ),
      ),
      maxLines: null,
      onChanged: onChanged,
    );
  }
}

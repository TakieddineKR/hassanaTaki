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
        backgroundColor: Colors.deepPurple[200],
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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                RequestTextField(
                  keyboardType: TextInputType.text,
                  labelText: 'Description',
                  hintText: 'Please keep your description short and clear',
                  onChanged: (value) =>
                      addRequestController.description = value,
                  validator: (value) => validator(value!, 5, 255, ''),
                ),
                const SizedBox(height: 20.0),
                RequestTextField(
                  keyboardType: TextInputType.number,
                  labelText: 'Quantity',
                  hintText: '100',
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
                const SizedBox(height: 20),
                RequestTextField(
                  keyboardType: TextInputType.streetAddress,
                  labelText: 'Location',
                  hintText: 'Oran',
                  onChanged: (value) => addRequestController.location = value,
                  validator: (value) => validator(value!, 4, 255, ''),
                ),
                Row(
                  children: [
                    const Text(
                      'Date of Need:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RequestTextField(
                  keyboardType: TextInputType.phone,
                  labelText: 'Phone Number',
                  hintText: '0555505050',
                  onChanged: (value) =>
                      addRequestController.phoneNumber = value,
                  validator: (value) => validator(value!, 5, 15, 'phone'),
                ),
                Obx(() => CheckboxListTile(
                      title: const Text(
                        'Delivery Employee Available',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      value:
                          addRequestController.deliveryEmployeeAvailable.value,
                      onChanged: (newValue) {
                        addRequestController.deliveryEmployeeAvailable.value =
                            newValue!;
                      },
                      activeColor: Colors.deepPurple[200],
                      checkColor: Colors.white,
                    )),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => addRequestController.addRequest(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[200],
                  ),
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(color: Colors.white),
                  ),
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
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        labelStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      maxLines: null,
      onChanged: onChanged,
    );
  }
}

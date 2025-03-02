import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nic_controller.dart';

class NICResultScreen extends StatelessWidget {
  final NICController nicController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NIC Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(label: "Format", value: nicController.format.value),
            InfoRow(label: "Date of Birth", value: nicController.birthDate.value),
            InfoRow(label: "Weekday", value: nicController.weekday.value),
            InfoRow(label: "Age", value: nicController.age.value.toString()),
            InfoRow(label: "Gender", value: nicController.gender.value),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: Text("Back"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text("$label:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Expanded(child: Text(value, style: TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}

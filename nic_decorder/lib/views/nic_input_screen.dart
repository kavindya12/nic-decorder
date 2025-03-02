import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nic_controller.dart';
import 'nic_result_screen.dart';

class NICInputScreen extends StatelessWidget {
  final NICController nicController = Get.put(NICController());
  final TextEditingController nicInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NIC Decoder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nicInputController,
              decoration: InputDecoration(
                labelText: "Enter NIC Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10),
            Obx(() => nicController.errorMessage.value.isNotEmpty
                ? Text(
                    nicController.errorMessage.value,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )
                : SizedBox.shrink()), // Error message display
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                nicController.decodeNIC(nicInputController.text);
                if (nicController.errorMessage.value.isEmpty) {
                  Get.to(() => NICResultScreen());
                }
              },
              child: Text("Decode"),
            ),
          ],
        ),
      ),
    );
  }
}

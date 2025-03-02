import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NICController extends GetxController {
  var nicNumber = ''.obs;
  var birthDate = ''.obs;
  var age = 0.obs;
  var gender = ''.obs;
  var weekday = ''.obs;
  var format = ''.obs;
  var errorMessage = ''.obs;  // Added for error handling

  void decodeNIC(String nic) {
    try {
      nic = nic.trim(); // Remove unnecessary spaces
      errorMessage.value = ""; // Clear previous errors

      if (nic.length == 10 && (nic.endsWith('V') || nic.endsWith('X'))) {
        // Old NIC format
        format.value = "Old NIC";
        String year = "19${nic.substring(0, 2)}";
        int dayOfYear = int.tryParse(nic.substring(2, 5)) ?? -1;
        if (dayOfYear < 1 || dayOfYear > 366) {
          errorMessage.value = "Invalid day count in NIC.";
          return;
        }

        gender.value = dayOfYear < 500 ? "Male" : "Female";
        if (dayOfYear > 500) dayOfYear -= 500;

        DateTime dob = DateTime(int.parse(year), 1, 1).add(Duration(days: dayOfYear - 1));
        _updateDetails(dob);
      } else if (nic.length == 12 && nic.isNumericOnly) {
        // New NIC format
        format.value = "New NIC";
        String year = nic.substring(0, 4);
        int dayOfYear = int.tryParse(nic.substring(4, 7)) ?? -1;
        if (dayOfYear < 1 || dayOfYear > 366) {
          errorMessage.value = "Invalid day count in NIC.";
          return;
        }

        gender.value = dayOfYear < 500 ? "Male" : "Female";
        if (dayOfYear > 500) dayOfYear -= 500;

        DateTime dob = DateTime(int.parse(year), 1, 1).add(Duration(days: dayOfYear - 1));
        _updateDetails(dob);
      } else {
        errorMessage.value = "Invalid NIC format.";
      }
    } catch (e) {
      errorMessage.value = "Invalid NIC input.";
    }
  }

  void _updateDetails(DateTime dob) {
    birthDate.value = DateFormat('yyyy-MM-dd').format(dob);
    weekday.value = DateFormat('EEEE').format(dob);
    age.value = DateTime.now().year - dob.year;
  }
}

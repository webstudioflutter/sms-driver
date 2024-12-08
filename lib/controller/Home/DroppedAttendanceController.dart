import 'package:driver_app/Model/AttendanceModel.dart';
import 'package:get/get.dart';

class DroppedAttendanceController extends GetxController {
  var presentStudent = 0.obs;
  var absentStudent = 0.obs;

  // var attendanceStatus = Map<String, bool>().obs; // Map to track student status by ID

  var isLoading = false.obs;
  var attendanceModel = Rx<AttendanceModel?>(null);
  var sortParameter = ''.obs;

  // Updates the counts of present and absent students
  void updateCounts() {
    int present = 0;
    int absent = 0;

    for (var entry in attendanceModel.value?.result ?? []) {
      for (var contact in entry) {
        if (contact['status'] == true) present++;
        if (contact['status'] == false) absent++;
      }
    }
    presentStudent.value = present;
    absentStudent.value = absent;
  }

  // Updates the status of a specific student and adjusts the counts
  void updateStudentStatus(int index, bool isPresent) {
    attendanceModel.value?.result![index].status = isPresent;
    updateCounts();
  }

  void sortAttendance() {
    if (attendanceModel.value?.result == null) return;

    final data = attendanceModel.value!.result!;
    if (sortParameter.value == 'name') {
      data.sort((a, b) => (a.user?.name ?? '').compareTo(b.user?.name ?? ''));
    } else if (sortParameter.value == 'location') {
      data.sort((a, b) => (a.user?.pickDropLocation ?? '')
          .compareTo(b.user?.pickDropLocation ?? ''));
    }

    attendanceModel.refresh(); // Notify UI to update
  }
}

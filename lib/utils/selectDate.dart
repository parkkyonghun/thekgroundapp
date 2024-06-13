import 'package:get/get.dart';

class DateSelectorController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedMonthIndex = (DateTime.now().month - 1).obs;
  var selectedWeekIndex = 0.obs;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectMonth(int index) {
    selectedMonthIndex.value = index;
    selectedWeekIndex.value = 0; // Reset week index on month change
  }

  void selectWeek(int index) {
    selectedWeekIndex.value = index;
  }
}

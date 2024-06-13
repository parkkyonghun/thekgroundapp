import 'package:get/get.dart';

class DateSelectorController extends GetxController {
  var selectedDate = DateTime.now().obs;
  final DateTime startDate = DateTime(2024, 1, 6); // Adjust the start date as needed
  final int currentWeek = ((DateTime(2024, 6, 6).weekday - 1) / 6).ceil();
  int get totalDays {
    final now = DateTime.now();
    print("$now total days : ${now.difference(startDate).inDays + 1}");
    return 1;
  }

  void selectDate(DateTime date) {
    if (date.isBefore(DateTime.now().add(const Duration(days: 1)))) {
      selectedDate.value = date;
    }
  }

  DateTime getDateForPage(int pageIndex) {
    return startDate.add(Duration(days: pageIndex));
  }

  int getPageForDate(DateTime date) {
    return date.difference(startDate).inDays;
  }
  // var selectedDate = DateTime.now().obs;
  // var selectedMonthIndex = DateTime.now().month.obs - 1;
  // var selectedWeekIndex = 0.obs;
  //
  // final int currentYear = DateTime.now().year;
  // final int currentMonth = DateTime.now().month;

  //
  // void selectDate(DateTime date) {
  //   selectedDate.value = date;
  // }
  //
  // void selectMonth(int index) {
  //   print(selectedMonthIndex.value);
  //   selectedMonthIndex.value = index;
  //   selectedWeekIndex.value = 0; // Reset week index on month change
  // }
  //
  // int getWeeksInMonth(int year, int month) {
  //   final dateTime = DateTime(year, month);
  //   final daysInMonth = dateTime.day;
  //
  //   if (DateTime(year, month, daysInMonth).weekday == 6) {
  //     return (daysInMonth / 7).ceil();
  //   } else {
  //     return (daysInMonth / 7).floor();
  //   }
  // }
  //
  // void selectWeek(int index) {
  //   selectedWeekIndex.value = index;
  //
  //   // Calculate the first day of the current month
  //   final firstDay = DateTime(currentYear, selectedMonthIndex.value + 1, 1);
  //
  //   // Calculate the number of weeks in the current month
  //   final weeksInMonth =
  //       ((firstDay.add(const Duration(days: 12 - 1)).weekday == 6)
  //           ? (12 / 7).ceil()
  //           : (12 / 7).floor());
  //
  //   // Handle negative index (scrolling up)
  //   if (index < 0) {
  //     selectedMonthIndex.value--;
  //     selectedWeekIndex.value =
  //         getWeeksInMonth(currentYear, selectedMonthIndex.value + 1) - 1;
  //   } else if (index > weeksInMonth - 1) {
  //     selectedMonthIndex.value++;
  //     selectedWeekIndex.value = 0;
  //   }
  //
  //   // Prevent selecting a future week in the current month
  //   if (selectedMonthIndex.value == currentMonth - 1 &&
  //       selectedWeekIndex.value > currentWeek) {
  //     selectedWeekIndex.value = currentWeek;
  //   }
  // }

// void selectWeek(int index) {
  //   selectedWeekIndex.value = index;
  //
  //   // Adjust month when scrolling through weeks
  //   if (index < 0) {
  //     selectedMonthIndex.value--;
  //     selectedWeekIndex.value = ((DateTime(currentYear, selectedMonthIndex.value + 2, 0).day - 1) / 7).floor();
  //   } else if (index > ((DateTime(currentYear, selectedMonthIndex.value + 2, 0).day - 1) / 7).floor()) {
  //     selectedMonthIndex.value++;
  //     selectedWeekIndex.value = 0;
  //   }
  //
  //   // Prevent scrolling past the current week
  //   if (selectedMonthIndex.value == currentMonth - 1 && selectedWeekIndex.value > currentWeek) {
  //     selectedWeekIndex.value = currentWeek;
  //   }
  // }
}

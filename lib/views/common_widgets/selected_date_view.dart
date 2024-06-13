import 'package:attendance/utils/selectDate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DateSelector extends StatelessWidget {
  final DateSelectorController controller = Get.put(DateSelectorController());

  DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMonthSelector(),
        _buildWeekPageView(),
      ],
    );
  }

  Widget _buildWeekPageView() {
    return Obx(() {
      return SizedBox(
        height: 100, // Adjust height as needed
        child: PageView.builder(
          controller: PageController(initialPage: controller.selectedWeekIndex.value),
          onPageChanged: (index) {
            controller.selectWeek(index);
          },
          itemBuilder: (context, weekIndex) {
            return _buildDateSelector(weekIndex);
          },
        ),
      );
    });
  }

  Widget _buildDateSelector(int weekIndex) {
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, controller.selectedMonthIndex.value + 1, 1);
    DateTime firstDayOfWeek = firstDayOfMonth.add(Duration(days: (weekIndex * 7) - firstDayOfMonth.weekday + 1));
    List<Widget> dateCards = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = firstDayOfWeek.add(Duration(days: i));
      String formattedDate = date.day.toString().padLeft(2, '0');
      String formattedDay = _getDayOfWeek(date.weekday);
      bool isPastOrToday = date.isBefore(DateTime.now().add(const Duration(days: 1)));

      dateCards.add(
        Obx(() => _buildDateCard(
          formattedDate,
          formattedDay,
          selected: date == controller.selectedDate.value,
          date: date,
          isEnabled: isPastOrToday,
        )),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dateCards,
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  Widget _buildDateCard(String dateNum, String day, {bool selected = false, required DateTime date, bool isEnabled = true}) {
   print(selected);
    return GestureDetector(
      onTap: isEnabled ? () => controller.selectDate(date) : null,
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Column(
          children: [
            Text(
              dateNum,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isEnabled ? (selected ? Colors.white : Colors.black) : Colors.grey,
              ),
            ),
            Text(
              day,
              style: TextStyle(
                color: isEnabled ? (selected ? Colors.white : Colors.black54) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    final List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 65, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: monthNames.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final isCurrentMonth = index == controller.selectedMonthIndex.value;
              return GestureDetector(
                onTap: () => controller.selectMonth(index),
                child: _buildMonthCard(monthNames[index], isCurrentMonth),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildMonthCard(String monthName, bool isCurrentMonth) {
    return Container(
      width: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isCurrentMonth ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          if (isCurrentMonth)
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        children: [
          Text(
            monthName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCurrentMonth ? Colors.white : Colors.black,
            ),
          ),
          Text(
            '2024',
            style: TextStyle(
              color: isCurrentMonth ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

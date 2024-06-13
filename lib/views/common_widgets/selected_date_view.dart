import 'package:attendance/core/date_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


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
          controller: PageController(initialPage: controller.getPageForDate(controller.selectedDate.value)),
          onPageChanged: (index) {
            final date = controller.getDateForPage(index);
            controller.selectDate(date);
          },
          itemCount: controller.totalDays,
          itemBuilder: (context, pageIndex) {
            final date = controller.getDateForPage(1);
            return _buildDateSelector(date);
          },
        ),
      );
    });
  }

  Widget _buildDateSelector(DateTime date) {
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, date.month, 1);
    DateTime firstDayOfWeek = firstDayOfMonth.add(Duration(days: (date.weekday * 7) - firstDayOfMonth.weekday + 1));
    List<Widget> dateCards = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = firstDayOfWeek.add(Duration(days: i));
      String formattedDate = DateFormat('dd').format(date);
      String formattedDay = DateFormat('EEE').format(date);
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

  Widget _buildDateCard(String dateName, String day, {bool selected = false, required DateTime date, bool isEnabled = true}) {
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
              dateName,
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
    final List<String> monthNames = DateFormat().dateSymbols.MONTHS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 65, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: monthNames.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final isCurrentMonth = index == controller.selectedDate.value.month - 1;
              return GestureDetector(
                onTap: () {
                    final firstDayOfMonth = DateTime(controller.selectedDate.value.year);
                    controller.selectDate(firstDayOfMonth);
                },
                child: _buildMonthCard(monthNames[index], isCurrentMonth),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildMonthCard(String monthName, bool isCurrentMonth) {
    final firstDayOfMonth = DateTime(controller.selectedDate.value.year);
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
            monthName.substring(0,3),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCurrentMonth ? Colors.white : Colors.black,
            ),
          ),
          Text(
            firstDayOfMonth.year.toString(),
            style: TextStyle(
              color: isCurrentMonth ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

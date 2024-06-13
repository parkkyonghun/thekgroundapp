import 'package:attendance/views/common_widgets/selected_date_view.dart';
import 'package:attendance/views/common_widgets/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const ProfileSection(),
              DateSelector(),
              // _buildProfileSection(),
              // _buildMonthSelector(),
              // _buildDateSelector(),
              const SizedBox(height: 18),
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(100, 215, 215, 215),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(18))
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    const Text(
                      'Today Attendance',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    _buildTodayAttendance(),
                    _buildActivityLog(),
                    _buildSwipeToCheckIn(),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    final List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    int currentMonthIndex = DateTime.now().month - 1; // Initialize with current mont

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 65, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: monthNames.length,
          itemBuilder: (context, index) {
            final isCurrentMonth = index == currentMonthIndex;
            return _buildMonthCard(monthNames[index], isCurrentMonth);
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

  Widget _buildDateSelector() {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateCard('06', 'Thu'),
          _buildDateCard('07', 'Fri'),
          _buildDateCard('08', 'Sat'),
          _buildDateCard('09', 'Sun', selected: true),
          _buildDateCard('10', 'Mon'),
        ],
      ),
    );
  }

  Widget _buildDateCard(String date, String day, {bool selected = false}) {
    return Container(
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
            date,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            day,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayAttendance() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 8.0,
        runAlignment: WrapAlignment.center,
        children: [
          _buildAttendanceCard('Check In', '10:20 am', 'On Time'),
          _buildAttendanceCard('Check Out', '07:00 pm', 'Go Home'),
          _buildAttendanceCard('Break Time', '0:30 min', 'Avg Time 30 min'),
          _buildAttendanceCard('Total Days', '28', 'Working Days'),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(String title, String time, String status) {
    return Container(
      width: 160,
      height: 105,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(100, 224, 233, 245),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Icon(
                      title == 'Check In' ? Icons.login_rounded : title == 'Check Out' ? Icons.logout_rounded
                          : title == 'Break Time'
                          ? Icons.coffee
                          : Icons.calendar_today,
                      color: Colors.blue,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(title, style: const TextStyle(fontSize: 14),)
                ],
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                status,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLog() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Your Activity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          _buildActivityItem('Check In', '10:00 am', 'April 17, 2023'),
          _buildActivityItem('Break In', '12:30 am', 'April 17, 2023'),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(100, 224, 233, 245),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Icon(
                  title == 'Check In' ? Icons.login_rounded : title == 'Check Out' ? Icons.logout_rounded
                      : title == 'Break Time'
                      ? Icons.coffee
                      : Icons.calendar_today,
                  color: Colors.blue,
                  size: 14,
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              )

            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'On time',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeToCheckIn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          // Perform check-in action

        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Text(
              'Swipe to Check In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


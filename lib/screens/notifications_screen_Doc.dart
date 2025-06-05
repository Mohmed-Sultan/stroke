import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/widgets/notification_item.dart';

// Mock data for notifications
class MockNotification {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final Color iconBgColor;
  final bool isUrgent;
  final String category; // "TODAY" or "YESTERDAY"

  MockNotification({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.iconBgColor,
    this.isUrgent = false,
    required this.category,
  });
}

class NotificationsScreendoctor extends StatefulWidget {
  const NotificationsScreendoctor({super.key});

  @override
  State<NotificationsScreendoctor> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreendoctor> {
  bool _hasNotifications = true;
  int _newNotificationCount = 1;

  final List<MockNotification> _notifications = [
    MockNotification(
      title: 'New Patient Test Results',
      subtitle: 'Test results for Ahmed are ready for review',
      timeAgo: '1h',
      icon: Icons.list_alt_rounded,
      iconBgColor: AppColors.lightBlue,
      category: "TODAY",
    ),
    MockNotification(
      title: 'Upcoming Appointment',
      subtitle: 'Your appointment with Ahmed is at 7:00 PM',
      timeAgo: '2h',
      icon: Icons.calendar_today_outlined,
      iconBgColor: AppColors.lightBlue,
      category: "TODAY",
    ),
    MockNotification(
      title: 'Urgent Attention Required',
      subtitle: 'Critical condition for Mohamed. immediate evaluation needed',
      timeAgo: '8h',
      icon: Icons.warning_amber_rounded,
      iconBgColor: Colors.red.shade100,
      isUrgent: true,
      category: "TODAY",
    ),
    MockNotification(
      title: 'New Consultation Request',
      subtitle: 'Patient Ali has requested a consultation',
      timeAgo: '1d',
      icon: Icons.calendar_today_outlined,
      iconBgColor: AppColors.lightBlue,
      category: "YESTERDAY",
    ),
  ];

  void _markAllAsRead(String category) {
    setState(() {
      if (category == "TODAY" || category == "ALL") _newNotificationCount = 0;
      print('Marking $category as read');
    });
  }


  @override
  Widget build(BuildContext context) {
    final todayNotifications = _notifications.where((n) => n.category == "TODAY").toList();
    final yesterdayNotifications = _notifications.where((n) => n.category == "YESTERDAY").toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Notifications', style: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.5,
        actions: _hasNotifications && _newNotificationCount > 0 ? [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Chip(
              label: Text('$_newNotificationCount New', style: const TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.w500)),
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              labelPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide.none
              ),
            ),
          ),
        ] : null,
      ),
      body: _hasNotifications
          ? ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (todayNotifications.isNotEmpty) ...[
            _buildSectionHeader("TODAY", () => _markAllAsRead("TODAY")),
            ...todayNotifications.map((notification) => NotificationItem(
              icon: notification.icon,
              iconBackgroundColor: notification.iconBgColor,
              iconColor: notification.isUrgent ? AppColors.errorColor : AppColors.primaryColor,
              title: notification.title,
              subtitle: notification.subtitle,
              time: notification.timeAgo,
              isUrgent: notification.isUrgent,
            )),
            const SizedBox(height: 20),
          ],
          if (yesterdayNotifications.isNotEmpty) ...[
            _buildSectionHeader("YESTERDAY", () => _markAllAsRead("YESTERDAY")),
            ...yesterdayNotifications.map((notification) => NotificationItem(
              icon: notification.icon,
              iconBackgroundColor: notification.iconBgColor,
              iconColor: notification.isUrgent ? AppColors.errorColor : AppColors.primaryColor,
              title: notification.title,
              subtitle: notification.subtitle,
              time: notification.timeAgo,
              isUrgent: notification.isUrgent,
            )),
          ],
        ],
      )
          : _buildEmptyNotificationsView(),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onMarkAllRead) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700]),
          ),
          TextButton(
            onPressed: onMarkAllRead,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Mark all as read', style: TextStyle(color: AppColors.primaryColor, fontSize: 13)),
          ),
        ],
      ),
    );
  }


  Widget _buildEmptyNotificationsView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/notifications.png',
              height: 180,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.notifications_off_outlined, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'No notifications yet',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Your notification will appear here once you\'ve received them.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
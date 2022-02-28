import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:lawyer/notifications/notification_service.dart';
import 'package:lawyer/providers/case_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/database.dart';

void setAndroidAlarm(SharedPreferences prefs) async {
  dynamic notificationTime;
  var today = DateTime.now();
  var defaultTime = DateTime(today.year, today.month, today.day, 9);

  if (prefs.containsKey('notificationTime')) {
    notificationTime = prefs.getString('notificationTime');
    notificationTime = DateTime(
        today.year,
        today.month,
        today.day,
        int.parse(notificationTime.substring(0, 2)),
        int.parse(notificationTime.substring(3, 5)));
  } else {
    prefs.setString('notificationTime', '0${defaultTime.hour}:00');
  }

  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.cancel(0);
  await AndroidAlarmManager.periodic(
      const Duration(hours: 24), 0, createNotification,
      startAt: calculateWhenToStart(notificationTime ?? defaultTime),
      allowWhileIdle: true,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true);
}

void createNotification() async {
  await NotificationService().init(); //
  NotificationService notificationService = NotificationService();
  var cases = await CaseDao(MyDatabase()).allCaseEntries;

  for (var caseItem in cases) {
    var status = caseItem.getDeadlineStatus();

    if (status == DeadlineStatus.lastDay) {
      notificationService.showNotification(
          caseItem.id,
          'Upozorenje, rok ističe DANAS!',
          'Stranka: ${caseItem.client}\nInterni broj: ${caseItem.internalNumber}');
    } else if (status == DeadlineStatus.penultimateDay) {
      notificationService.showNotification(caseItem.id, 'Rok ističe sutra!',
          'Stranka: ${caseItem.client}\nInterni broj: ${caseItem.internalNumber}');
    } else {
      continue;
    }
  }
}

DateTime calculateWhenToStart(DateTime notificationTime) {
  var now = DateTime.now();

  if (notificationTime.isAfter(now)) {
    return notificationTime;
  } else {
    return notificationTime.add(const Duration(days: 1));
  }
}

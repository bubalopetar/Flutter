import 'package:flutter/cupertino.dart';
import 'package:lawyer/providers/database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum DeadlineStatus {
  lastDay,
  penultimateDay,
  multipleDays,
  passed,
  notYetStarted
}

extension CaseHelper on Case {
  DeadlineStatus getDeadlineStatus() {
    var today = DateTime.now();

    var timeUntilDeadline = deadlineDate.difference(today);
    if (deadlineDate.isBefore(today)) {
      return DeadlineStatus.passed;
    }

    if (attachmentDate.isAfter(today)) {
      return DeadlineStatus.notYetStarted;
    } else {
      switch (timeUntilDeadline.inDays) {
        case 0:
          {
            return DeadlineStatus.lastDay;
          }
        case 1:
          {
            return DeadlineStatus.penultimateDay;
          }
        default:
          {
            return DeadlineStatus.multipleDays;
          }
      }
    }
  }

  String getSubtitleText(
      {required DeadlineStatus status, required BuildContext context}) {
    var localizations = AppLocalizations.of(context)!;

    if (status == DeadlineStatus.lastDay) {
      return localizations.lastDay;
    } else if (status == DeadlineStatus.penultimateDay) {
      return localizations.penultimateDay;
    } else if (status == DeadlineStatus.passed) {
      var date =
          DateFormat('EEE, d.MM.y.', Localizations.localeOf(context).toString())
              .format(deadlineDate);
      return '${localizations.deadlinePassedAt}$date';
    } else if (attachmentDate.isAfter(DateTime.now())) {
      var date =
          DateFormat('EEE, d.MM.y.', Localizations.localeOf(context).toString())
              .format(attachmentDate);
      return "${localizations.deadlineStartsAt} $date";
    } else {
      return howMuchUntilTheDeadline(localizations);
    }
  }

  String howMuchUntilTheDeadline(AppLocalizations localizations) {
    var timeUntilDeadline = deadlineDate.difference(DateTime.now());
    var dayOrDays = timeUntilDeadline.inDays.toString().endsWith('1')
        ? localizations.day
        : localizations.days;

    var hoursLeft = (timeUntilDeadline.inHours % 24).toString();
    var hourOrHours =
        int.parse(hoursLeft) > 4 ? localizations.hour : localizations.hours;
    return '${timeUntilDeadline.inDays} $dayOrDays ${localizations.and} $hoursLeft $hourOrHours ${localizations.untildeadline}';
  }
}

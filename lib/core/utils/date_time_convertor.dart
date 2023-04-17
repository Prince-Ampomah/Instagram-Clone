import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeConvertor {
  static String greetingTime() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning 🌤\n';
    }
    if (hour < 16) {
      return 'Good Afternoon 🌞\n';
    }
    return 'Good Evening 🌒\n';
  }

  static String getDateFromInt(int time) {
    final date = DateTime.fromMillisecondsSinceEpoch(time);
    return DateFormat.E().add_MMM().add_jm().format(date).toString();
  }

  static String getFormattedDate(DateTime time) {
    return DateFormat.E().add_MMM().add_jm().format(time).toString();
  }

  static String getHoursMinsTimeInt(int date) {
    var format = DateFormat('hh:mm a');
    var getDate = DateTime.fromMillisecondsSinceEpoch(date);
    return format.format(getDate);
  }

  static String getFormattedHoursMinTime(DateTime time) {
    var format = DateFormat('hh:mm a'); // MMMM d
    return format.format(time);
  }

  static String getFormattedMonthAndDay(DateTime time) {
    var format = DateFormat('MMMM d'); //Month and Day (July 10)
    return format.format(time);
  }

  static String getFormattedMonthAndDayandHours(DateTime time) {
    var format = DateFormat('d MMM, hh:mm a');
    return format.format(time);
  }

  static String formatAudioTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  static String calcuateTimeDiffernce(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final messageDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, y').format(dateToCheck);
    }
  }

  static String calcuateChatTimeDiffernce(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final messageDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (messageDate == today) {
      return 'Today ${DateFormat('h:mm a').format(dateToCheck)}';
    } else if (messageDate == yesterday) {
      return 'Yesterday ${DateFormat('h:mm a').format(dateToCheck)}';
    } else {
      return DateFormat('MMMM d, h:mm a').format(dateToCheck);
    }
  }

  static String getTimeAgo(DateTime dateToCheck) {
    final now = DateTime.now();
    final difference = now.difference(dateToCheck);
    return timeago.format(now.subtract(difference));
  }
}

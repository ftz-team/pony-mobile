//function returning ebanutuyu stroky django from datetime object
String djangoS(DateTime date) {
  return date.year.toString() +
      "-" +
      date.month.toString() +
      "-" +
      date.day.toString() +
      "T" +
      date.hour.toString() +
      ":" +
      date.minute.toString() +
      ":" +
      date.second.toString() +
      "Z";
}

String normalS(DateTime date) {
  String hour = date.hour.toString();
  String minute = date.minute.toString();
  if (hour.length < 2) {
    hour = "0" + hour;
  }
  if (minute.length < 2) {
    minute = "0" + minute;
  }
  return hour + ":" + minute;
}

String dmy(DateTime date) {
  String day, month, year;
  day = date.day.toString();
  month = date.month.toString();
  year = date.year.toString();
  if (day.length < 2) {
    day = "0" + day;
  }
  if (month.length < 2) {
    month = "0" + month;
  }
  return day + "." + month + "." + year.substring(2);
}

String day(int index) {
  List<String> days = [
    'понедельник',
    'вторник',
    'среда',
    'четверг',
    'пятница',
    'суббота',
    'воскресение'
  ];
  return days[index - 1];
}

String shortDay(int index) {
  List<String> days = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
  return days[index - 1];
}

String month(int index) {
  List<String> months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь'
  ];
  ;
  return months[index - 1];
}

getIntervalString(DateTime dStart, DateTime dEnd) {
  return normalS(dStart) + "-" + normalS(dEnd);
}

getDateTimeFromDjango(String date) {
  var newDate = "";
  bool flag = false;
  for (int j = 0; j < date.length; j++) {
    if (date[j] == ".") {
      newDate = newDate + "Z";
      flag = true;
      break;
    } else {
      if (!flag) {
        newDate = newDate + date[j];
      }
    }
  }
  return DateTime.parse(newDate);
}
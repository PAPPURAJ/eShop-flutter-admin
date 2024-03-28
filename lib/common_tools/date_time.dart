String getDate() {
  final dateTime = DateTime.now();
  int date = dateTime.day;
  int month = dateTime.month;
  return '${date < 10 ? '0$date' : date}/${month < 10 ? '0$month' : month}/${dateTime.year}';
}

String getTime() {
  final dateTime = DateTime.now();
  int min = dateTime.minute;
  int sec = dateTime.second;
  print(dateTime.hour.toString() +
      "-" +
      dateTime.minute.toString() +
      "/" +
      dateTime.second.toString());
  return '${dateTime.hour.toInt() == 12 ? 12 : dateTime.hour % 12}:${min < 10 ? '0$min' : min}:${sec < 10 ? '0$sec' : sec} ${dateTime.hour.toInt() > 11 ? 'PM' : 'AM'}';
}

String getDateTimeString() {
  final dateTime = DateTime.now();
  return '${dateTime.day}${dateTime.month}${dateTime.year}' +
      '${dateTime.hour}${dateTime.minute}${dateTime.second}';
}

String getDateTimeName() {
  final dateTime = DateTime.now();
  return '${dateTime.year}${dateTime.month}${dateTime.day}' +
      '${dateTime.hour}${dateTime.minute}${dateTime.second}';
}

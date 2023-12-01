import 'dart:convert';
import 'dart:developer' as dev;

import 'package:intl/intl.dart';

bool isEmpty(dynamic val) {
  return [
    "",
    " ",
    null,
    'null',
    '{}',
    '[]',
    '0',
    '0.0',
    '-1',
  ].contains(val.toString());
}

bool isNotEmpty(dynamic val) {
  return ![
    "",
    " ",
    null,
    'null',
    '{}',
    '[]',
    '0',
    '0.0',
    '0.00',
    '-1',
  ].contains(val.toString());
}

void logKey([key, content]) {
  String finalLog = '';
  dynamic tempContent = content ?? key;
  if (tempContent is Map || tempContent is List) {
    try {
      finalLog = json.encode(tempContent);
    } catch (e) {
      finalLog = tempContent.toString();
    }
  } else if (tempContent is String) {
    finalLog = tempContent;
  } else {
    finalLog = tempContent.toString();
  }

  if (content != null) {
    dev.log('$key => $finalLog');
  } else {
    dev.log(finalLog);
  }
}

String dateFormater(
  dynamic date, {
  String dateFormat = "EEEE, dd MMMM - HH:mm",
}) {
  if (date is String) {
    return DateFormat(dateFormat, 'id').format(DateTime.parse(date));
  }
  if (date is DateTime) {
    return DateFormat(dateFormat, 'id').format(date);
  }
  return '';
}

int calcAge(DateTime birthDate) {
  final currDate = DateTime.now();
  int age = currDate.year - birthDate.year;

  if (currDate.month < birthDate.month || (currDate.month == birthDate.month && currDate.day < birthDate.day)) {
    age--;
  }
  return age;
}

import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';

bool emailCheckFunction(String apiResponseEmail) {
  return apiResponseEmail == 'false';
}

String? formatDate(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  // Choose any format you need. Here's an example:
  DateFormat formatter = DateFormat('dd MMMM hh:mm');
  return formatter.format(date);
}

String formatDateFor(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  // Choose any format you need. Here's an example:
  DateFormat formatter = DateFormat('d/M/y');
  return formatter.format(date);
}

String getLastMonthName(String? jsonData) {
  if (jsonData == null) {
    return "None";
  }

  List<dynamic> list = jsonDecode(jsonData);
  Map<String, dynamic> lastMonthData = list.last;
  return lastMonthData.keys.first;
}

double calculateTotalSpendings(String jsonData) {
  List<dynamic> list = jsonDecode(jsonData);
  double total = list.fold(0, (sum, item) {
    double value = double.tryParse(item.values.first.toString()) ?? 0.0;
    return sum + value.toDouble();
  });
  return total;
}

String transformDate(DateTime inputDate) {
  // Parse the date time string.
  return inputDate.toIso8601String()+'Z';
}

DateTime stringToDate(String dateStr) {
  return DateTime.parse(dateStr);
}

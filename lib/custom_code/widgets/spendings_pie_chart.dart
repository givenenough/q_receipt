// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the button on the right!

import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class SpendingsPieChart extends StatelessWidget {
  final String? jsonData;
  final double? width;
  final double? height;

  SpendingsPieChart(
      {required this.jsonData, required this.width, required this.height});

  Map<String, double> parseJson(String? jsonStr) {
    if (jsonStr == null || jsonStr.isEmpty) {
      return {};
    }
    Map<String, dynamic> response = jsonDecode(jsonStr);
    Map<String, dynamic> spendingsPerCategory =
        response['spendingsPerCategory'];

    return spendingsPerCategory
        .map((key, value) => MapEntry(key, value.toDouble()));
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData == null || jsonData!.isEmpty) {
      return Text(
        'No recent activity',
        style: TextStyle(
          fontSize: 14, // Set a suitable text size
          color: Colors.black, // You can use any color of your choice
        ),
      );
    }

    Map<String, double> data = parseJson(jsonData);
    if (data.isEmpty) {
      return Text(
        'No recent activity',
        style: TextStyle(
          fontSize: 14, // Set a suitable text size
          color: Colors.black, // You can use any color of your choice
        ),
      );
    }

    double total = data.values.reduce((a, b) => a + b);
    List<PieChartSectionData> sections = data.entries.map((e) {
      double percentage = total == 0.0 ? 0.0 : (e.value / total) * 100;
      return PieChartSectionData(
        color: Colors.primaries[
            data.keys.toList().indexOf(e.key) % Colors.primaries.length],
        value: e.value,
        title: e.key,
        radius: percentage > 20 ? 160 : 150,
      );
    }).toList();

    return Container(
      width: width,
      height: height,
      child: PieChart(
        PieChartData(
          sectionsSpace: 10,
          centerSpaceRadius: 10,
          sections: sections,
        ),
      ),
    );
  }
}

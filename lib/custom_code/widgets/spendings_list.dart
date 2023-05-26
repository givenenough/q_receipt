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

class SpendingsList extends StatelessWidget {
  final String jsonData;
  final double? width;
  final double? height;

  SpendingsList(
      {required this.jsonData, required this.width, required this.height});

  List<dynamic> parseJson(String jsonStr) {
    return jsonDecode(jsonStr);
  }

  String getLastMonthName(List<dynamic> jsonData) {
    Map<String, dynamic> lastMonthData = jsonData.last;
    return lastMonthData.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = parseJson(jsonData);
    String lastMonth = getLastMonthName(data);

    return Container(
      width: width,
      height: height,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: data.map((entry) {
          final month = entry.keys.first;
          final spending = entry.values.first;
          return Center(
            child: Text(
              '$month: ${spending.toInt()} KZT',
              style: TextStyle(
                color: month == lastMonth ? Colors.blue : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

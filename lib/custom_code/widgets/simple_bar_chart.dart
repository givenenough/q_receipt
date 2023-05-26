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

class SimpleBarChart extends StatelessWidget {
  final String? jsonData;
  final String currentMonth;
  final double? width;
  final double? height;

  SimpleBarChart({
    required this.jsonData,
    required this.currentMonth,
    required this.width,
    required this.height,
  });

  List<Map<String, double>> parseJson(String? jsonStr) {
    if (jsonStr == null || jsonStr.isEmpty) {
      return [];
    }
    List<dynamic> list = jsonDecode(jsonStr);
    return list.map((item) {
      String key = item.keys.first;
      double value = double.tryParse(item.values.first.toString()) ?? 0.0;
      return {key: value};
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData == null || jsonData!.isEmpty) {
      return Container(
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            'No recent activity',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    List<Map<String, double>> data = parseJson(jsonData);
    double maxVal = data
        .map((entry) => entry.values.first)
        .reduce((value, element) => value > element ? value : element);

    return Container(
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: data.map((entry) {
                final month = entry.keys.first;
                final spending = entry.values.first;
                final isCurrentMonth = month == currentMonth;
                final barHeight = maxVal == 0.0
                    ? 0.0
                    : (spending / maxVal) * (height! - 50); // subtract estimated heights
                // subtract estimated heights

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${spending.toInt()} KZT', // add the Euro symbol
                      style: TextStyle(
                        fontSize: 10, // smaller text size
                        color: isCurrentMonth
                            ? const Color(0xFF577DC4)
                            : const Color(0xFFC2C2C7), // highlight text
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      width: width! / data.length * 0.6,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: isCurrentMonth
                            ? const Color(0xFF577DC4)
                            : const Color(0xFFC2C2C7),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(0)),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      month.substring(0, 3),
                      style: TextStyle(
                        fontSize: 14, // smaller text size
                        color: isCurrentMonth
                            ? const Color(0xFF577DC4)
                            : const Color(0xFFC2C2C7), // highlight text
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

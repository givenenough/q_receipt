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

class SpendingsGridView extends StatelessWidget {
  final String jsonData;
  final double? width;
  final double? height;

  SpendingsGridView(
      {required this.jsonData, required this.width, required this.height});

  Map<String, double> parseJson(String jsonStr) {
    Map<String, dynamic> response = jsonDecode(jsonStr);
    Map<String, dynamic> spendingsPerCategory =
        response['spendingsPerCategory'];

    return spendingsPerCategory
        .map((key, value) => MapEntry(key, value.toDouble()));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> data = parseJson(jsonData);
    return Container(
      width: width,
      height: height,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: data.entries.map((entry) {
          return Center(
            child: Text(
              '${entry.key}: ${entry.value.toInt()} KZT',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final subject;
  var value;
  ActivityTile(this.subject, this.value);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          subject + ':',
          style: TextStyle(color: secondaryText),
        ),
        SizedBox(
          width: padding,
        ),
        Text(
          value,
          style: TextStyle(color: primaryText),
        ),
      ],
    );
  }
}

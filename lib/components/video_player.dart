import 'package:ccextractor/components/sub_components/custom_divider.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height;
    var availableWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: border, width: 1),
      ),
      color: foreground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Process files from device storage',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: primaryText),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'CLEAR LIST',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: red),
                  ),
                ),
              ),
            ],
          ),
          CustomDivider(),
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Drag & Drop files here...',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              SizedBox(
                width: padding / 4,
              ),
              Container(
                child: Text(
                  'Add only known video formats (filter out unknown extensions',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: primaryText),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

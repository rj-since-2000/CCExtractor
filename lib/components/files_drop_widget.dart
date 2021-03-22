import 'package:ccextractor/components/sub_components/custom_divider.dart';
import 'package:ccextractor/providers/settings.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilesDropWidget extends StatelessWidget {
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
      child: Consumer<Settings>(
        builder: (context, settings, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        'Process files from device storage',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: primaryText),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
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
              CustomDivider(),
              Row(
                children: [
                  Checkbox(
                    value: settings.addOnlyKnownVideoFormats,
                    activeColor: blue,
                    onChanged: (value) {
                      settings.updateAddOnlyKnownVideoFormats(value ?? false);
                    },
                  ),
                  SizedBox(
                    width: padding / 4,
                  ),
                  Expanded(
                    child: Text(
                      'Add only known video formats (filter out unknown extensions)',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: primaryText),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: padding / 2),
                      child: Text(
                        'Browse',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: primaryText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Edit video processing...',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

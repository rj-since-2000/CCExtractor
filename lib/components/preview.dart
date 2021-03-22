import 'package:ccextractor/components/sub_components/custom_divider.dart';
import 'package:ccextractor/providers/activity_provider.dart';
import 'package:ccextractor/providers/settings.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Preview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height;
    var availableWidth = MediaQuery.of(context).size.width;
    final ScrollController _controller = ScrollController();

    return SizedBox(
      height: availableHeight * 0.75 - 97,
      child: Card(
        color: black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: border, width: 1),
        ),
        child: Consumer<ActivityProvider>(
          builder: (context, activity, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<Settings>(
                  builder: (context, settings, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Text(
                                  'Preview',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: primaryText),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  width: padding,
                                ),
                                Text(
                                  settings.encodings[settings.encoding.index],
                                  style: TextStyle(color: secondaryText),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                settings.outputTypes[settings.outputType.index],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: TextStyle(color: secondaryText),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                CustomDivider(),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Scrollbar(
                      controller: _controller,
                      isAlwaysShown: true,
                      thickness: 4,
                      child: SingleChildScrollView(
                        controller: _controller,
                        reverse: true,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: SelectableText(
                                activity.previewSubtitles,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

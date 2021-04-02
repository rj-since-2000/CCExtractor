import 'package:ccextractor/components/sub_components/activity_tile.dart';
import 'package:ccextractor/components/sub_components/custom_divider.dart';
import 'package:ccextractor/providers/activity_provider.dart';
import 'package:ccextractor/providers/settings.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height;
    var availableWidth = MediaQuery.of(context).size.width;
    var activityProvider = Provider.of<ActivityProvider>(context);
    return Container(
      color: foreground,
      height: availableHeight * 0.25,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: availableWidth * 0.17,
              ),
              Text(
                'Command Line',
                style: TextStyle(color: primaryText),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: black,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: border, width: 1)),
                  padding:
                      EdgeInsets.symmetric(horizontal: padding, vertical: 8),
                  margin: EdgeInsets.only(top: 2, bottom: 2, right: padding),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<Settings>(
                      builder: (context, settings, child) => SelectableText(
                        settings.commandLine,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: availableWidth,
                height: 30,
                decoration: BoxDecoration(
                    color: background,
                    border: Border.all(color: border, width: 1)),
                alignment: Alignment.center,
                child: Center(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: padding,
                      ),
                      ActivityTile('CCExtractor', '0.88'),
                      SizedBox(
                        width: padding,
                      ),
                      ActivityTile(
                        'Status',
                        activityProvider
                                .statuses[activityProvider.status.index] +
                            '(PID ' +
                            activityProvider.pid.toString() +
                            ')',
                      ),
                      SizedBox(
                        width: padding,
                      ),
                      ActivityTile(
                        'Last message',
                        activityProvider.lastMessage,
                      ),
                      SizedBox(
                        width: padding,
                      ),
                      ActivityTile(
                        'Now processing',
                        activityProvider.nowProcessing,
                      ),
                      SizedBox(
                        width: padding,
                      ),
                      ActivityTile(
                        'Resolution',
                        activityProvider.resolution,
                      ),
                      SizedBox(
                        width: padding,
                      ),
                      ActivityTile(
                        'Aspect Ratio',
                        activityProvider.aspectRatio,
                      ),
                      SizedBox(
                        width: padding,
                      ),
                      ActivityTile(
                        'Framerate',
                        activityProvider.framerate,
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: border, width: 1)),
                    child: Row(
                      children: [
                        Material(
                          elevation: 5,
                          child: Container(
                            height: 18,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [blue, lightGreen])),
                            width: (availableWidth - 2) *
                                activityProvider.progress /
                                100,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 18,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Progress:   ',
                              style: TextStyle(color: primaryText),
                            ),
                            Text(activityProvider.progress.toString() + '%'),
                          ],
                        ),
                        SizedBox(
                          width: padding,
                        ),
                        Row(
                          children: [
                            Text(
                              'Position:   ',
                              style: TextStyle(color: primaryText),
                            ),
                            Text(activityProvider.position.toString()),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: availableWidth / 2,
                height: availableHeight * 0.25 - 88,
                color: black,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: padding, vertical: 2),
                      child: Text(
                        'Activity',
                        style: TextStyle(color: primaryText),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomDivider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      height: availableHeight * 0.25 - 109,
                      width: double.infinity,
                      child: SingleChildScrollView(
                          reverse: true,
                          child: SelectableText(activityProvider.activity)),
                    ),
                  ],
                ),
              ),
              Container(
                width: availableWidth / 2,
                height: availableHeight * 0.25 - 88,
                color: foreground,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: padding, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            'Exported files',
                            style: TextStyle(color: primaryText),
                            textAlign: TextAlign.start,
                          ),
                          Spacer(),
                          Text(
                            'Users/df/desktop',
                            style: TextStyle(color: secondaryText),
                            textAlign: TextAlign.start,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    CustomDivider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      height: availableHeight * 0.25 - 109,
                      alignment: Alignment.topLeft,
                      child: ListView.builder(
                        itemCount: activityProvider.exportedFiles.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: padding, vertical: 2),
                                child: Text(
                                  activityProvider.exportedFiles[index],
                                  style: TextStyle(color: secondaryText),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              CustomDivider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

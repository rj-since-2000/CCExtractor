import 'package:ccextractor/components/dropdown_widget.dart';
import 'package:ccextractor/components/files_drop_widget.dart';
import 'package:ccextractor/components/preview.dart';
import 'package:ccextractor/models/settings_property.dart';
import 'package:ccextractor/providers/activity_provider.dart';
import 'package:ccextractor/providers/settings.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<Settings>(context, listen: false);
    var availableHeight = MediaQuery.of(context).size.height;
    var availableWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(padding),
      width: availableWidth * 0.83,
      height: availableHeight * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: DropdownWidget(
                  Property.Port,
                  'Process input via UTP',
                  settingsProvider.port,
                  [1235, 1236, 1237, 1238, 1239, 1240],
                ),
              ),
              Expanded(
                flex: 2,
                child: DropdownWidget(
                  Property.InputType,
                  'Input type',
                  settingsProvider.inputType,
                  InputType.values,
                ),
              ),
              Expanded(
                flex: 2,
                child: DropdownWidget(
                  Property.OutputType,
                  'Output type',
                  settingsProvider.outputType,
                  OutputType.values,
                ),
              ),
              Expanded(
                flex: 2,
                child: DropdownWidget(
                  Property.SplitType,
                  'Split type',
                  settingsProvider.splitType,
                  SplitType.values,
                ),
              ),
              Expanded(
                flex: 1,
                child: ExtractButton(),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: (availableWidth * 0.83 - 32) / 2,
                height: availableHeight * 0.75 - 97,
                child: FilesDropWidget(),
              ),
              Container(
                width: (availableWidth * 0.83 - 32) / 2,
                child: Preview(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExtractButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, activity, child) => Container(
        height: 55,
        margin: EdgeInsets.only(left: 8, right: 4),
        child: ElevatedButton(
          onPressed: activity.status == Status.Starting ||
                  activity.status == Status.Running
              ? null
              : () => activity.extract(),
          child: const Text(
            'EXTRACT',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

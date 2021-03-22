import 'package:ccextractor/components/sub_components/custom_divider.dart';
import 'package:ccextractor/models/settingsProperty.dart';
import 'package:ccextractor/providers/settings.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownWidget extends StatefulWidget {
  Property property;
  final String label;
  dynamic value;
  final List<dynamic> values;

  DropdownWidget(this.property, this.label, this.value, this.values);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

String getValue(dynamic value, Property property, BuildContext context) {
  final _settingsProvider = Provider.of<Settings>(context, listen: false);
  switch (property) {
    case Property.Port:
      return value.toString();
    case Property.InputType:
      return _settingsProvider.inputTypes[value.index];
    case Property.OutputType:
      return _settingsProvider.outputTypes[value.index];
    case Property.SplitType:
      return _settingsProvider.splitTypes[value.index];
    case Property.Mode:
      return _settingsProvider.modes[value.index];
    default:
      return '';
  }
}

class _DropdownWidgetState extends State<DropdownWidget> {
  updateSettings(Property property, BuildContext context, dynamic newValue) {
    final _settingsProvider = Provider.of<Settings>(context, listen: false);
    switch (property) {
      case Property.Port:
        _settingsProvider.updatePort(newValue);
        break;
      case Property.InputType:
        _settingsProvider.inputType = newValue;
        break;
      case Property.OutputType:
        _settingsProvider.outputType = newValue;
        break;
      case Property.SplitType:
        _settingsProvider.splitType = newValue;
        break;
      case Property.Mode:
        _settingsProvider.mode = newValue;
        break;
      // case Property.AddOnlyKnownVideoFormats:
      //   _settingsProvider.addOnlyKnownVideoFormats = newValue;
      //   break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: border, width: 1),
      ),
      color: foreground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              widget.label.toString(),
              textAlign: TextAlign.start,
              style: TextStyle(color: primaryText),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: DropdownButton(
              dropdownColor: foreground,
              isDense: true,
              isExpanded: true,
              style: TextStyle(fontSize: 12),
              underline: Container(
                height: 0,
              ),
              value: widget.value,
              onChanged: (newValue) {
                updateSettings(widget.property, context, newValue);
                setState(() {
                  widget.value = newValue;
                });
              },
              items: widget.values.map((value) {
                return DropdownMenuItem(
                  child: Text(
                    getValue(value, widget.property, context),
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: value,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

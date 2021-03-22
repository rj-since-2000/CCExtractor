import 'package:ccextractor/components/bottom_interface.dart';
import 'package:ccextractor/components/menu_bar.dart';
import 'package:ccextractor/pages/advanced_input_option.dart';
import 'package:ccextractor/pages/advanced_output_option.dart';
import 'package:ccextractor/pages/dashboard.dart';
import 'package:ccextractor/pages/decoders.dart';
import 'package:ccextractor/pages/default.dart';
import 'package:ccextractor/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final String title;
  MainScreen({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              MenuBar(),
              Consumer<MenuProvider>(
                builder: (context, menuProvider, child) {
                  int id = menuProvider.currentMenuId;
                  switch (id) {
                    case 1:
                      return Dashboard();
                    case 2:
                      return AdvancedInputOption();
                    case 3:
                      return Decoders();
                    case 4:
                      return AdvancedOutputOption();
                    default:
                      return Default();
                  }
                },
              ),
            ],
          ),
          BottomInterface(),
        ],
      ),
    );
  }
}

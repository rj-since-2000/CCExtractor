import 'dart:io';

import 'package:ccextractor/providers/activity_provider.dart';
import 'package:ccextractor/providers/menu_provider.dart';
import 'package:ccextractor/providers/settings.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:ccextractor/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    setWindowTitle('CCExtractor GUI');
    setWindowMinSize(const Size(700, 500));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuProvider>(
            create: (context) => MenuProvider()),
        ChangeNotifierProvider<Settings>(
          create: (context) => Settings(),
        ),
        ChangeNotifierProxyProvider<Settings, ActivityProvider>(
          create: (context) => ActivityProvider(Settings()),
          update: (context, settings, previousActivity) =>
              ActivityProvider(settings),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CCExtractor GUI',
        theme: ThemeData.dark().copyWith(
            backgroundColor: background,
            scaffoldBackgroundColor: background,
            appBarTheme: AppBarTheme(
              color: foreground,
            )),
        home: MainScreen(title: 'CCExtractor GUI'),
      ),
    );
  }
}

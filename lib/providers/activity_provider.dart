import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ccextractor/providers/settings.dart';
import 'package:flutter/material.dart';

enum Status {
  None,
  Starting,
  Running,
  Done,
  Error,
}

class ActivityProvider extends ChangeNotifier {
  Settings settings;
  ActivityProvider(this.settings);

  Status _status = Status.None;
  var pid = 380;
  var lastMessage = '-';
  var nowProcessing = 'Users/df/desktop/VH1.ts';
  var resolution = '528*480';
  var aspectRatio = '4:3';
  var framerate = '29.97';
  double _progress = 0;
  Duration position = Duration(milliseconds: 0);

  var statuses = [
    '-',
    'Starting',
    'Running',
    'Done',
    'Error',
  ];
  String testActivity =
      "\nCCExtractor 0.88, Carlos Fernandez Sanz, Volker Quetschke.\nTeletext portions taken from Petr Kutalek's telxcc\n--------------------------------------------------------------------------\nInput: C:\Users\RJ\Downloads\VH1.ts\n[Extract: 1] [Stream mode: Autodetect]\n[Program : Auto ] [Hauppage mode: No] [Use MythTV code: Auto]\n[Timing mode: Auto] [Debug: No] [Buffer input: Yes]\n[Use pic_order_cnt_lsb for H.264: No] [Print CC decoder traces: No]\n[Target format: .srt] [Encoding: Latin-1] [Delay: 0] [Trim lines: No]\n[Add font color data: Yes] [Add font typesetting: Yes]\n[Convert case: No] [Video-edit join: No]\n[Extraction start time: not set (from start)]\n[Extraction end time: not set (to end)]\n[Live stream: No] [Clock frequency: 90000]";
  String _activity = '';
  var exportedFiles = [
    'VH1.srt',
    'VH2.srt',
  ];
  // var testPreviewSubtitles = [
  //   "00:04  00:09  WE-WE-WE'VE BEEN OUT HERE FOR FOUR HOURS EASILY.",
  //   "00:09  00:12  THERE'S NO WAY WE'RE GOING TO CROSS THAT RIVER.",
  //   "00:12  00:15  OH! I'M FREEZING!",
  //   "00:15  00:17  YEAH, ME, TOO.",
  //   "00:17  00:20  YOU GUYS SOUND FRAIL, FEMININE, LIKE HOTTIES.",
  //   "00:21  00:23  IT'S NOT THAT COLD OUT HERE.",
  //   "00:23  00:28  HOWEVER, MY AREOLAS ARE GETTING TIGHT.",
  //   "00:29  00:32  I-I THINK WE SHOULD GO BACK.",
  //   "00:34  00:37  WAIT A MINUTE. WAIT A MINUTE. WAIT A MINUTE.",
  //   "00:37  00:38  THERE'S SOME FOOTPRINTS.",
  //   "00:38  00:40  WAIT A MINUTE. THOSE AREN'T HUMAN...",
  //   "00:40  00:42  UNLESS SHAQ IS RUNNING AROUND HERE.",
  //   "00:43  00:45  [ GROWLING ]",
  //   "00:48  00:50  THAT DOESN'T SOUND LIKE SHAQ.",
  //   "00:50  00:52  THAT SOUNDS LIKE A BEAR.",
  //   "00:53  00:55  COME ON, MAN.",
  //   "00:55  00:57  THAT DON'T SOUND LIKE NO BEAR.",
  //   "00:57  00:59  THAT'S JUST THE GAS I HAD EARLIER.",
  //   "00:59  01:00  [ GROWLING ]",
  //   "01:04  01:08  WHA--WHAT'S THAT SOUND LIKE TO YOU, BROHAM?",
  //   "01:11  01:13  Both: AAH!",
  //   "01:46  01:47  (SFX: TIC TAC PACK SHAKES)",
  //   "01:47  01:52  (SFX: TEETH CHATTERING)",
  //   "01:52  01:56  (SFX: CRASHING)",
  //   "01:56  01:57  Tic Tac Orange.",
  //   "01:57  01:59  An irresistible burst of flavor.",
  //   "01:59  02:00  Tic Tac.",
  //   "02:00  02:01  Go little.",
  //   "02:08  02:10  Just fifteen minutes and a little imagination",
  // ];
  String _previewSubtitles = '\n';

  get status {
    return _status;
  }

  get activity {
    return _activity;
  }

  get previewSubtitles {
    return _previewSubtitles;
  }

  get progress {
    return _progress;
  }

  updateStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  updatePreviewSubtitles(String subtitle) {
    _previewSubtitles = _previewSubtitles + subtitle;
    notifyListeners();
  }

  updateProgress(double progress) {
    _progress = progress;
    notifyListeners();
  }

  Future<void> startActivity() async {
    updateStatus(Status.Starting);
    int s = 0;
    String output = '';
    for (int i = s; i < testActivity.length; i++) {
      if (testActivity[i] == '\n') {
        output = testActivity.substring(s, i);
        await Future.delayed(Duration(milliseconds: 200));
        _activity = _activity + '\n' + output;
        notifyListeners();
        s = i + 1;
      }
    }
  }

  Future<void> extract() async {
    await startActivity();
    updateStatus(Status.Running);
    start();
  }

  final controller1 = StreamController<Process>();
  final controller2 = StreamController();
  final outputController = TextEditingController(text: '0');
  String version = '';
  String file = '';

  void start() {
    try {
      var process = Process.start('ccextractor', settings.arguments,
          mode: ProcessStartMode.normal);
      controller1.addStream(process.asStream());
      controller1.stream.listen((process) {
        controller2.addStream(process.stderr.transform(Utf8Decoder()));
        controller2.stream.listen((data) {
          List<String> outputs = data.toString().split('\n').toList();
          String finalOutput;
          outputs.forEach((output) {
            if (output.contains('###PROGRESS#')) {
              int index = output.indexOf('###PROGRESS#');
              String progress = output.substring(index + 12, index + 15);
              if (num.tryParse(progress) != null) {
                finalOutput = progress;
              } else if (num.tryParse(progress.substring(0, 2)) != null) {
                finalOutput = progress.substring(0, 2);
              } else {
                finalOutput = progress.substring(0, 1);
              }
              updateProgress(double.parse(finalOutput));
              if (finalOutput == '100') {
                updateStatus(Status.Done);
                //controller1.close();
              }
            } else if (output.contains('###SUBTITLE#')) {
              int index = output.indexOf('###SUBTITLE#');

              if (num.tryParse(output.substring(index + 12, index + 14)) !=
                  null) {
                String time1 = output.substring(index + 12, index + 17);
                String time2 = output.substring(index + 18, index + 23);
                //int newlineIndex = output.
                String sub = output.substring(index + 24);
                updatePreviewSubtitles('\n$time1 $time2 : $sub');
              } else {
                String sub = output.substring(index + 14);
                updatePreviewSubtitles('$sub');
              }
            }
          });
        });
      }).onDone(() {
        //updateStatus(Status.Done);
        //print(controller1.isClosed);
      });
    } catch (e) {
      print(e.toString());
      updateStatus(Status.Error);
    }
  }
}

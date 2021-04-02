import 'package:flutter/material.dart';

enum InputType {
  Autodetect_the_correct_format,
  Program_streams,
  DVR_MS,
  Bin_CCExtractors,
  MFX_Material_Exchange_Format,
  Transport_Stream,
  Elementry_Stream,
  Raw_McPoodles,
  MP4,
  Hexadecimal_Dump,
  Microsoft_WTV,
  M2TS,
  MKV,
}

enum OutputType {
  Srt_SubRip,
  Raw_CC_data_in_McPoodles_broadcast_format,
  Sami_Microsoft_Synchronized_Accesible_Media_Interchange,
  Dvdram_CC_data_in_McPoodles_DVD_format,
  Txt_Transcript_no_timing,
}

enum SplitType {
  These_are_individual_unrelated_files_Produce_an_output_subtitle_file_for_each_input_file,
  These_files_are_part_of_the_same_video_They_were_cut_with_a_video_tool,
  These_files_are_part_of_the_same_video_They_were_cut_by_a_generic_tool,
}

enum Mode {
  This_is_a_complete_recording,
  This_is_live,
}

enum Encoding {
  Latin_1,
  UTF_8,
  Unicode,
}

class Settings extends ChangeNotifier {
  bool _processViaUTP = false;
  bool _processViaDeviceStorage = true;
  int _port = 1235;
  int _liveModeWaitingTime = 0;
  bool _addOnlyKnownVideoFormats = false;
  InputType _inputType = InputType.Autodetect_the_correct_format;
  OutputType _outputType = OutputType.Srt_SubRip;
  SplitType _splitType = SplitType
      .These_are_individual_unrelated_files_Produce_an_output_subtitle_file_for_each_input_file;
  Mode mode = Mode.This_is_a_complete_recording;
  Encoding _encoding = Encoding.Latin_1;
  var _commandLine = 'ccextractor';
  final inputTypes = [
    'Autodetect the correct format',
    'Program streams',
    'DVR-MS',
    ".bin (CCExtractor's)",
    'MFX (Material Exchange Format',
    'Transport Stream',
    'Elementry Stream',
    ".raw (McPoodle's)",
    'MP4',
    'Hexadecimal Dump',
    'Microsoft WTV',
    'M2TS',
    'MKV',
  ];
  final inputFormats = [
    '',
    'ps',
    'asf',
    'bin',
    'mxf',
    'ts',
    'es',
    'raw',
    'mp4',
    '',
    'wtv',
    'm2ts',
    'mkv',
  ];
  final outputTypes = [
    '.srt (SubRip)',
    ".raw (CC data in McPoodle's broadcast format",
    '.sami (Microsoft Synchronized Accesible Media Interchange',
    ".dvdram (CC data in McPoodle's DVD format",
    '.txt (Transcript, no timing',
  ];
  final outputFormats = [
    'srt',
    'raw',
    'sami',
    'dvdram',
    'txt',
  ];
  final splitTypes = [
    'These are individual, unrelated files. Produce an output subtitle file for each input file.',
    'These files are part of the same video. They were cut with a video tool.',
    'These files are part of the same video. They were cut by a generic tool.',
  ];
  final splitFormats = [
    '',
    've',
    '',
  ];
  final modes = [
    'This is a complete recording',
    'This is live.',
  ];
  final modeFormat = [
    '',
    's',
  ];
  final encodings = [
    'Latin-1',
    'UTF-8',
    'Unicode',
  ];

  List<String> arguments = [
    '--gui_mode_reports',
  ];

  List<String> _filePaths = [];

  get port {
    return _port;
  }

  get addOnlyKnownVideoFormats {
    return _addOnlyKnownVideoFormats;
  }

  get inputType {
    return _inputType;
  }

  get outputType {
    return _outputType;
  }

  get splitType {
    return _splitType;
  }

  get encoding {
    return _encoding;
  }

  String get commandLine {
    return _commandLine;
  }

  List<String> get files {
    return _filePaths;
  }

  updateAddOnlyKnownVideoFormats(bool value) {
    _addOnlyKnownVideoFormats = value;
    notifyListeners();
  }

  updatePort(int newPort) {
    _port = newPort;
    print(newPort);
    notifyListeners();
    updateCommandLine();
  }

  updateInputType(InputType inputType) {
    _inputType = inputType;
    updateCommandLine();
  }

  updateOutputType(OutputType outputType) {
    _outputType = outputType;
    updateCommandLine();
  }

  updateSplitType(SplitType splitType) {
    _splitType = splitType;
    updateCommandLine();
  }

  updateInputFiles(String path) {
    _filePaths.add(path);
    updateCommandLine();
  }

  resetInputFiles() {
    _filePaths.clear();
    updateCommandLine();
  }

  updateCommandLine() {
    arguments = [
      '--gui_mode_reports',
      ...settings,
      ..._filePaths,
    ];
    _commandLine = 'ccextractor ' + arguments.join(' ');
    notifyListeners();
  }

  List<String> get settings {
    String inputFormat = inputFormats[_inputType.index].isEmpty
        ? ''
        : '-in=' + inputFormats[_inputType.index];
    String outputFormat = outputFormats[_outputType.index].isEmpty
        ? ''
        : '-out=' + outputFormats[_outputType.index];
    String splitFormat = splitFormats[_splitType.index].isEmpty
        ? ''
        : '-' + splitFormats[_splitType.index];
    return [inputFormat, outputFormat, splitFormat];
  }

  List<String> get commandLineArguments {
    updateCommandLine();
    return arguments;
  }
}

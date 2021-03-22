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
  bool processViaUTP = false;
  bool processViaDeviceStorage = true;
  int _port = 1235;
  int liveModeWaitingTime = 0;
  bool _addOnlyKnownVideoFormats = false;
  InputType inputType = InputType.Autodetect_the_correct_format;
  OutputType outputType = OutputType.Srt_SubRip;
  SplitType splitType = SplitType
      .These_are_individual_unrelated_files_Produce_an_output_subtitle_file_for_each_input_file;
  Mode mode = Mode.This_is_a_complete_recording;
  Encoding encoding = Encoding.Latin_1;
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
  final outputTypes = [
    '.srt (SubRip)',
    ".raw (CC data in McPoodle's broadcast format",
    '.sami (Microsoft Synchronized Accesible Media Interchange',
    ".dvdram (CC data in McPoodle's DVD format",
    '.txt (Transcript, no timing',
  ];
  final splitTypes = [
    'These are individual, unrelated files. Produce an output subtitle file for each input file.',
    'These files are part of the same video. They were cut with a video tool.',
    'These files are part of the same video. They were cut by a generic tool.',
  ];
  final modes = [
    'This is a complete recording',
    'This is live.',
  ];
  final encodings = [
    'Latin-1',
    'UTF-8',
    'Unicode',
  ];

  get port {
    return _port;
  }

  get addOnlyKnownVideoFormats {
    return _addOnlyKnownVideoFormats;
  }

  updateAddOnlyKnownVideoFormats(bool value) {
    _addOnlyKnownVideoFormats = value;
    notifyListeners();
  }

  updatePort(int newPort) {
    _port = newPort;
    print(newPort);
    notifyListeners();
  }
}

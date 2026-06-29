const String appName = 'ChaBox';
const String appRepo = 'https://github.com/huanguan1978/chacrypt';

enum LangEnum { en, zh, hk, de, ja, ru, es, pt, fr, ko }

enum CleanupEnum { keep, delete, wipelow, wipemedium, wipehigh }

const String anyFileExtName = '**';
const String chaFileExtName = '.cha';
const String chaNoteExtName = '.md.cha';
const String txtNoteExtName = '.md';

/// Note Auto Save
enum NoteAutoSave {
  s00(0),
  s05(5),
  s10(10),
  s20(20),
  s30(30);

  final int s;
  const NoteAutoSave(this.s);

  String get label => switch (this) {
    NoteAutoSave.s00 => 'Closed',
    NoteAutoSave.s05 => 'After  5 secs',
    NoteAutoSave.s10 => 'After 10 secs',
    NoteAutoSave.s20 => 'After 20 secs',
    NoteAutoSave.s30 => 'After 30 secs',
  };

  @override
  String toString() => name;
}

/// Auto Clipboard Clear Delay
enum ClipDelay {
  s00(0),
  s10(10),
  s30(30),
  s60(60);

  final int s;
  const ClipDelay(this.s);

  String get label => switch (this) {
    ClipDelay.s00 => 'Disabled',
    ClipDelay.s10 => 'After 10 secs',
    ClipDelay.s30 => 'After 30 secs',
    ClipDelay.s60 => 'After 60 secs',
  };

  @override
  String toString() => name;
}

/*
final class Constant {
  static const String appName = 'FileShows';
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1280;
  static const String networkLookup = 'webpath.iche2.com';
  static const int payAppId = 2;
}

const allowMimeType = [
  'text/plain',
  'application/pdf',
  'application/yaml',
  'application/x-yaml',
  'image/jpeg',
  'image/png',
  'audio/aac',
  'audio/flac',
  'audio/mp3',
  'audio/m4a',
  'audio/mpeg',
  'audio/mpga',
  'audio/mp4',
  'audio/opus',
  'audio/pcm',
  'audio/wav',
  'audio/webm',
  'video/x-flv',
  'video/mov',
  'video/mpeg',
  'video/mpegps',
  'video/mpg',
  'video/mp4',
  'video/webm',
  'video/wmv',
  'video/3gpp',
];

const allowFileExt = {
  'txt': ['*.txt', '*.text'],
  'pdf': ['*.pdf'],
  'yaml': ['*.yml', '*.yaml'],
  'image': ['.jpeg', '.jpg', '.jpe', '.jfif', 'png'],
  'audio': [
    '.aac',
    '.flac',
    '.mp3',
    '.m4a',
    '.mp3',
    '.mpga',
    '.mp4',
    '.opus',
    '.pcm',
    '.wav',
    '.webm'
  ],
  'video': [
    '.aac',
    '.flac',
    '.mp3',
    '.m4a',
    '.mp3',
    '.mpga',
    '.mp4',
    '.opus',
    '.pcm',
    '.wav',
    '.webm'
  ]
};

*/

import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

extension FileExtension on File {
  String get name {
    return path.basename(this.path);
  }

  String get extension {
    return path.extension(this.path);
  }
}

import 'dart:io';

import 'package:refactoring/has_match.dart';

Iterable<File> readDirecory({
  Directory dir,
  includes: const ['**.dart'],
  excludes: const <String>[],
}) {
  if (dir == null) {
    dir = Directory.current;
  }

  return dir.listSync(recursive: true).where(_isFile).cast<File>().where(
      (File file) {
        return hasMatch(file, includes) && !hasMatch(file, excludes);
      });
}

bool _isFile(entity) => entity is File;

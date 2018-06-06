import 'dart:io';

import 'package:glob/glob.dart';

bool hasMatch(File file, Iterable<Glob> globs) =>
    globs.takeWhile((Glob glob) => glob.matches(file.path)).length > 0;
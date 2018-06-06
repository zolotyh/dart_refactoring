import 'dart:io';

import 'package:glob/glob.dart';

bool hasMatch(File file, Iterable<String> patterns) =>
    patterns
        .where((String pattern) => new Glob(pattern).matches(file.path))
        .length > 0;

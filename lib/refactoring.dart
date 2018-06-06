import 'dart:async';

import 'dart:io';
import 'package:glob/glob.dart';
import 'package:refactoring/has_match.dart';

class RefactoringTool {
  final RefactoringConfig config;

  RefactoringTool(this.config);

  Future<void> doStuff() async {
    for (RefactoringStep step in config.steps) {
      await step.apply();
    }
  }
}

class RefactoringConfig {
  final Iterable<RefactoringStep> steps;

  RefactoringConfig(this.steps);
}

class RefactoringStep {
  Future<void> apply() async {}
}

class DirecoryReader {
  Iterable<Glob> _globs;
  Iterable<Glob> get globs => _globs;

  Iterable<Glob> _excludes;
  Iterable<Glob> get excludes => _excludes;

  DirecoryReader(
      {Iterable<String> globs: const ['lib/**/*.dart'],
      Iterable<String> excludes: const []}) {
    _globs = globs.map<Glob>((i) => new Glob(i));
    _excludes = excludes.map<Glob>((i) => new Glob(i));
  }

  Iterable<File> read() {
    Directory dir = _getCurrentDirectory();
    return dir
        .listSync(recursive: true)
        .where(_isFile)
        .cast<File>()
        .where((File file) => hasMatch(file, globs) && !hasMatch(file, excludes));
  }

  bool _isFile(entity) => entity is File;

  Directory _getCurrentDirectory() {
    final dir = new Directory('.');
    return dir;
  }
}



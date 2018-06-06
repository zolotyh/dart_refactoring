import 'dart:io';

import 'package:glob/glob.dart';
import 'package:refactoring/has_match.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('hasMatch test', () {
    test('when glob is a *.dart and filepath is a lib/test/test.dart, then should return true', () {

      final file = new FileMock();
      when(file.path).thenReturn('lib/test/test.dart');

      final globs = [new Glob('*.dart')];

      expect(hasMatch(file, globs), true);
    });

    test('when glob is a lib/**/*.dart and filepath is a lib/test/test.dart, then should return true', () {

      final file = new FileMock();
      when(file.path).thenReturn('lib/test/test.dart');

      final globs = [new Glob('lib/**/*.dart')];

      expect(hasMatch(file, globs), true);
    });
  });
}

class FileMock extends Mock implements File { }

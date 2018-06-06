import 'dart:io';

import 'package:glob/glob.dart';
import 'package:refactoring/has_match.dart';
import 'package:refactoring/read_directory.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('hasMatch test', () {
    test(
        'when glob is a lib/test/*.dart and filepath is a lib/test/test.dart, then should return true',
        () {
      final file = new FileMock();
      when(file.path).thenReturn('lib/test/test.dart');

      final patterns = ['lib/test/*.dart'];

      expect(hasMatch(file, patterns), true);
    });

    test(
        'when glob is a lib/**/*.dart and web/**.dart and filepath is a lib/test/test.dart, then should return true',
        () {
      final file = new FileMock();
      when(file.path).thenReturn('lib/test/test.dart');

      final patterns = ['lib/**/*.dart', 'web/**.dart'];

      expect(hasMatch(file, patterns), true);
    });

    group('readDirectory tests', () {
      test('Smoke test', () {
        final exludePatterns = ['lib/**/test.dart'];
        final includePatterns = ['lib/**/*.dart', 'web/**.dart'];

        final dir = new DirectoryMock();

        File getFile(String path) {
          final file = new FileMock();
          when(file.path).thenReturn(path);
          return file;
        }
        final fileList = [
          getFile('lib/test/test.dart'),
          getFile('lib/test/main.dart'),
          getFile('web/test/test.dart'),
        ];

        when(dir.listSync(recursive: true)).thenReturn(fileList);

        final files = readDirecory(
          dir: dir,
          excludes: exludePatterns,
          includes: includePatterns,
        );

        expect(files.length, 2);
      });
    });
  });
}

class FileMock extends Mock implements File {}

class DirectoryMock extends Mock implements Directory {}

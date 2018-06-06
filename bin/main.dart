import 'dart:async';

import 'package:glob/glob.dart';
import 'dart:io';
import 'package:refactoring/refactoring.dart' as refactoring;

main(List<String> arguments) async {

  print(new Glob('lib/**.dart').matches('lib/test/test.dart'));

  final a = new refactoring.DirecoryReader();
  print(a.read());

  final steps = <refactoring.RefactoringStep>[];
  final config = new refactoring.RefactoringConfig(steps);
  final tool = new refactoring.RefactoringTool(config);
  await tool.doStuff();

}

const _help = ''''
  refactoring
''';

class EmptyStep implements refactoring.RefactoringStep{
  @override
  Future<void> apply() async {
    print('emptyStep');
  }
}
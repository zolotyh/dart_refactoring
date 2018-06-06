import 'dart:async';

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





# Feature Testing

resource: https://docs.flutter.dev/testing

**Continuous integration testing**

- **Unit testing**: Testing in code phase, make sure there is no error. 
  - Flutter test library & github action workflow

- **widget test** :  testing UI components; 
  - Fluttertest library, Riverpod
  
- **integration test** : Testing big chuck of app which developed in user’s perspective.
  - Flutter test library, GitHub Actions

**Regression testing** : ensure that new coding does not cause any bugs from old code.
  - Flutter
    - golden_toolkit package,  reset-all
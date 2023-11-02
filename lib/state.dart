//Define the state which should be immutable.
class AppState {
  final int counter;

  AppState({this.counter = 0});

  AppState copyWith({int? counter}) {
    return AppState(
      counter: counter ?? this.counter,
    );
  }
}

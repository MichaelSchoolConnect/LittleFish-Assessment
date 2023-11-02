//Defines how the state changes in response to actions.
import 'actions.dart';
import 'state.dart';

AppState counterReducer(AppState state, dynamic action) {
  if (action is IncrementAction) {
    return state.copyWith(counter: state.counter + 1);
  } else if (action is DecrementAction) {
    return state.copyWith(counter: state.counter - 1);
  }
  return state;
}

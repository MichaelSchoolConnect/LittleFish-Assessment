// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'reducer.dart';
import 'state.dart';

/**
 *  Middleware:
    For this simple app, we might not need any middleware.
    However, if we want to perform side effects or asynchronous operations,
    this is where they would be defined.

    Store:
    Create the store that holds the state tree of your app. Which is this
    main.dart classA
 * */

void main() {
  final store = Store<AppState>(
    counterReducer,
    initialState: AppState(),
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter App using Redux')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            StoreConnector<AppState, String>(
              converter: (store) => store.state.counter.toString(),
              builder: (context, counter) {
                return Text(
                  counter,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(IncrementAction());
                  },
                  builder: (context, callback) {
                    return ElevatedButton(
                      onPressed: callback,
                      child: Text('+'),
                    );
                  },
                ),
                StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(DecrementAction());
                  },
                  builder: (context, callback) {
                    return ElevatedButton(
                      onPressed: callback,
                      child: Text('-'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

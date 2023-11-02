import 'package:flutter/material.dart';
import 'package:project_3/repositories/character_repository.dart';
import 'package:provider/provider.dart';

import 'pages/character_list_page.dart';
import 'services/rick_and_morty_repository.dart';

//Dependency Injection
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<CharacterRepository>(
      create: (_) => RickAndMortyRepository(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CharacterListPage(),
      ),
    );
  }
}

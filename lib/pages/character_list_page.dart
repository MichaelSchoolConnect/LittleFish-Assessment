// pages/character_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/character_bloc.dart';
import '../model/character_model.dart';
import '../repositories/character_repository.dart';

class CharacterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
      ),
      body: BlocProvider(
        create: (context) =>
            CharacterBloc(RepositoryProvider.of<CharacterRepository>(context))
              ..add(FetchCharacters(1)),
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharactersLoaded) {
              return ListView.builder(
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final character = state.characters[index];
                  return ListTile(
                    leading: Image.network(character.image),
                    title: Text(character.name),
                    subtitle:
                        Text('${character.species} - ${character.status}'),
                    onTap: () => _showCharacterDetail(context, character),
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load characters'));
            }
          },
        ),
      ),
    );
  }

  void _showCharacterDetail(BuildContext context, CharacterModel character) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(character.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'character_image_${character.id}',
                child: Image.network(character.image, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "Status: ${character.status}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Species: ${character.species}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Type: ${character.type.isEmpty ? 'N/A' : character.type}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Gender: ${character.gender}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Episodes",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ...character.episode.map((e) => Text(e)).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}

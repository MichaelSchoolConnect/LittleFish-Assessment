// bloc/character_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/character_model.dart';
import '../repositories/character_repository.dart';

abstract class CharacterEvent {}

class FetchCharacters extends CharacterEvent {
  final int page;
  FetchCharacters(this.page);
}

abstract class CharacterState {}

class CharactersLoading extends CharacterState {}

class CharactersLoaded extends CharacterState {
  final List<CharacterModel> characters;
  CharactersLoaded(this.characters);
}

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;

  CharacterBloc(this.repository) : super(CharactersLoading()) {
    on<FetchCharacters>((event, emit) async {
      try {
        final characters = await repository.fetchCharacters(event.page);
        emit(CharactersLoaded(characters));
      } catch (e) {
        print(e);
      }
    });
  }
}

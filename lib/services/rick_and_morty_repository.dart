// services/rick_and_morty_repository.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/character_model.dart';
import '../repositories/character_repository.dart';

class RickAndMortyRepository implements CharacterRepository {
  final String baseUrl = 'https://rickandmortyapi.com/api/character/';

  @override
  Future<List<CharacterModel>> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results
          .map((rawCharacter) => CharacterModel.fromJson(rawCharacter))
          .toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Future<CharacterModel> getCharacterDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 200) {
      return CharacterModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load character detail');
    }
  }
}

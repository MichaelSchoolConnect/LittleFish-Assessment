import '../model/character_model.dart';

//an abstract repository class to define the contract:
abstract class CharacterRepository {
  //fetches characters
  Future<List<CharacterModel>> fetchCharacters(int page);
  //extracts more detail from chosen character
  Future<CharacterModel> getCharacterDetail(int id);
}

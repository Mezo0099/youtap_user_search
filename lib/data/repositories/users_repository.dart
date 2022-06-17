import 'package:user_search_test/data/dtos/user_dto.dart';

abstract class UsersRepository {
  Future<List<UserDto>> searchByName({required String keyword});

  Future<List<UserDto>> searchById({required int id});
}

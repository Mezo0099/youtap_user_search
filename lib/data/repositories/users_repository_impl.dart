import 'dart:io';

import 'package:user_search_test/core/error_handler/error_handler.dart';
import 'package:user_search_test/core/network/cache.dart';
import 'package:user_search_test/core/network/http.dart';
import 'package:user_search_test/core/startup.dart';
import 'package:user_search_test/data/dtos/user_dto.dart';

import 'users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  // Privately Injected Dependencies
  final Http _client = sl();
  final Cache<List<UserDto>> _userListCache = sl();

  @override
  Future<List<UserDto>> searchByName({required String keyword}) async =>
      await _getAllUsers(
          cacheKey: keyword,
          filter: (users) => keyword.isEmpty
              ? users
              : users
                  .where(
                      (e) => e.username.toLowerCase() == keyword.toLowerCase())
                  .toList());

  @override
  Future<List<UserDto>> searchById({required int id}) async =>
      await _getAllUsers(
          cacheKey: id.toString(),
          filter: (users) => id.toString().isEmpty
              ? users
              : users.where((e) => e.id == id).toList());

  Future<List<UserDto>> _getAllUsers({
    required String cacheKey,
    required List<UserDto> Function(List<UserDto> users) filter,
  }) async {
    // to avoid making unnecessary api calls
    if (_userListCache.contains(cacheKey)) {
      return _userListCache.get(cacheKey)!;
    }
    var result = await _client.get(url: "");
    if (result.statusCode != HttpStatus.ok) {
      throw ErrorHandler.httpResponseException(result);
    } else {
      var users = UserListDto.fromRawJson(result.body);
      var filteredUsers = filter.call(users.users);
      if (cacheKey.isNotEmpty && filteredUsers.isNotEmpty) {
        _userListCache.set(cacheKey, filteredUsers);
      }
      return filteredUsers;
    }
  }
}

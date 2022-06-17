import 'package:get_it/get_it.dart';
import 'package:user_search_test/core/network/cache.dart';
import 'package:user_search_test/data/dtos/user_dto.dart';
import 'package:user_search_test/data/repositories/users_repository.dart';
import 'package:user_search_test/data/repositories/users_repository_impl.dart';

class RepositoryRegistrar {
  static void init(GetIt sl) {
    sl.registerFactory<UsersRepository>(() => UsersRepositoryImpl());
    sl.registerLazySingleton<Cache<List<UserDto>>>(
        () => Cache<List<UserDto>>());
  }
}

import 'package:get_it/get_it.dart';
import 'package:user_search_test/core/network/cache.dart';
import 'package:user_search_test/data/dtos/user_dto.dart';
import 'package:user_search_test/presentation/features/users/domain/service/users_service_impl.dart';
import 'package:user_search_test/presentation/features/users/presentation/manager/users_bloc.dart';

import '../../features/users/domain/service/users_service.dart';

void userDependencies(GetIt sl) {
  sl.registerFactory<UserService>(() => UserServiceImpl());

  sl.registerLazySingleton<Cache<UserListDto>>(() => Cache<UserListDto>());

  sl.registerSingleton<UsersBloc>(UsersBloc());
}

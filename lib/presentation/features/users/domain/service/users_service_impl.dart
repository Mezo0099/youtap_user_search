import 'package:dartz/dartz.dart';
import 'package:user_search_test/core/error_handler/error_handler.dart';
import 'package:user_search_test/core/error_handler/errors.dart';
import 'package:user_search_test/core/startup.dart';
import 'package:user_search_test/data/repositories/users_repository.dart';

import '../models/user_model.dart';
import 'users_service.dart';

class UserServiceImpl implements UserService {
  // Privately Injected Dependencies
  final UsersRepository _usersRepository = sl();

  @override
  Future<Either<Failure, List<UserModel>>> searchUsersById(String value) =>
      ErrorHandler.handleFuture<List<UserModel>>(
        () async {
          var id = int.tryParse(value);
          if (id == null) {
            return Left(Failure(
              message: "ID should be an integer",
              failureAction: FailureActions.workAround,
            ));
          }
          var movies = await _usersRepository.searchById(id: id);
          return Right(movies
              .map(
                (e) => UserModel.fromDto(e),
              )
              .toList());
        },
      );

  @override
  Future<Either<Failure, List<UserModel>>> searchUsersByName(String value) =>
      ErrorHandler.handleFuture<List<UserModel>>(
        () async {
          var movies = await _usersRepository.searchByName(keyword: value);
          return Right(movies
              .map(
                (e) => UserModel.fromDto(e),
              )
              .toList());
        },
      );
}

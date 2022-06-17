import 'package:dartz/dartz.dart';
import 'package:user_search_test/core/error_handler/errors.dart';

import '../models/user_model.dart';

/// Responsible for handling UI events, requests and data from the `USERS` feature.
///
/// Should only return models and be called by its respective feature.
abstract class UserService {
  Future<Either<Failure, List<UserModel>>> searchUsersById(String value);

  Future<Either<Failure, List<UserModel>>> searchUsersByName(String value);
}

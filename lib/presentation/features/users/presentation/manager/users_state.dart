part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class HomeInitial extends UsersState {}

class Error extends UsersState {
  Error({required this.message});

  final String message;
}

class Loading extends UsersState {}

class ShowUserList extends UsersState {
  final List<UserModel> info;

  ShowUserList({required this.info});
}

class InvalidId extends UsersState {
  final String message;

  InvalidId(this.message);
}

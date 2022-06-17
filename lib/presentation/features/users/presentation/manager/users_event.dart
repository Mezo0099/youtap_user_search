part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class SearchUsersEvent extends UsersEvent {
  final String keyword;
  final bool isById;

  SearchUsersEvent({
    this.keyword = "",
    this.isById = false,
  });
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_search_test/core/error_handler/errors.dart';
import 'package:user_search_test/core/startup.dart';
import 'package:user_search_test/presentation/features/users/domain/models/user_model.dart';

import '../../domain/service/users_service.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserService _homeService = sl();

  UsersBloc() : super(HomeInitial()) {
    on<SearchUsersEvent>(
      (event, emit) => _searchMovies(emit, event),
    );
  }

  List<UserModel> previouslySearchedUsers = [];

  void _searchMovies(Emitter emit, SearchUsersEvent event) async {
    emit(Loading());
    var result = event.isById
        ? await _homeService.searchUsersById(event.keyword)
        : await _homeService.searchUsersByName(event.keyword);
    result.fold(
      (l) {
        if (l.failureAction == FailureActions.workAround) {
          emit(InvalidId(l.message));
          emit(ShowUserList(info: previouslySearchedUsers));
        } else {
          emit(Error(message: l.message));
        }
      },
      (r) {
        previouslySearchedUsers = r;
        emit(ShowUserList(info: r));
      },
    );
  }
}

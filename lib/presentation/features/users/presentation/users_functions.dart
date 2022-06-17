
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_search_test/core/common/widgets/app_snack_bar.dart';
import 'package:user_search_test/presentation/features/users/presentation/manager/users_bloc.dart';

// Ideally in a bigger app we have this mixin and a folder for all the screens

// allowing them all to use it so that all events are originated here
///helper functions mixin for all functions in the `Users` Feature
mixin UsersFunctionsMixin {
  void buildListener(BuildContext context, UsersState state) {
    if (state is InvalidId) {
      AppSnackBar.error(
        context,
        message: state.message,
      );
    }
  }

  /// Adds an event with the [controller]'s text
  ///
  /// If [isById] is null it searches for everything
  void searchUsersWithOneField(
    BuildContext context, {
    required TextEditingController controller,
    required bool isById,
  }) {
    BlocProvider.of<UsersBloc>(context).add(SearchUsersEvent(
      keyword: controller.text,
      isById: isById,
    ));
    controller.clear();
  }

  /// Adds an event with the [nameController]'s text
  ///
  /// If [isById] is null it searches for everything
  void searchUsersWithTwoFields(
    BuildContext context, {
    required TextEditingController nameController,
    required TextEditingController idController,
  }) {
    if (idController.text.isNotEmpty && nameController.text.isEmpty) {
      BlocProvider.of<UsersBloc>(context).add(SearchUsersEvent(
        keyword: idController.text,
        isById: true,
      ));
    } else if (nameController.text.isNotEmpty && idController.text.isEmpty) {
      BlocProvider.of<UsersBloc>(context).add(SearchUsersEvent(
        keyword: nameController.text,
      ));
    } else {
      BlocProvider.of<UsersBloc>(context).add(SearchUsersEvent());
    }

    idController.clear();
    nameController.clear();
  }
}

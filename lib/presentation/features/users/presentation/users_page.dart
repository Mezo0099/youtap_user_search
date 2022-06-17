import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_search_test/presentation/features/users/domain/models/user_model.dart';
import 'package:user_search_test/presentation/features/users/presentation/users_functions.dart';

import 'manager/users_bloc.dart';

// here am following a convention that i learned from the Flutter Gallery app from the Flutter team
// `separate a screen into small widgets (improves performance) but keep them in a single file (strongly coherent)`

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> with UsersFunctionsMixin {
  final List<TextEditingController> _controllers =
      List.generate(2, (index) => TextEditingController());

  @override
  void initState() {
    BlocProvider.of<UsersBloc>(context).add(SearchUsersEvent(isById: false));
    super.initState();
  }

  @override
  void dispose() {
    for (var e in _controllers) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _SearchActionButton(controllers: _controllers),
      body: SafeArea(
        child: BlocConsumer<UsersBloc, UsersState>(
          listener: (c, s) => buildListener(c, s),
          builder: (context, state) {
            return Column(
              children: <Widget>[
                _SearchBar(
                  title: "Search by ID",
                  controller: _controllers[0],
                  submit: () => searchUsersWithOneField(
                    context,
                    controller: _controllers[0],
                    isById: true,
                  ),
                ),
                _SearchBar(
                  controller: _controllers[1],
                  title: "Search by username",
                  submit: () => searchUsersWithOneField(
                    context,
                    controller: _controllers[1],
                    isById: false,
                  ),
                ),
                if (state is Loading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (state is Error)
                  Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                if (state is ShowUserList)
                  Expanded(child: UsersList(users: state.info)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SearchActionButton extends StatelessWidget with UsersFunctionsMixin {
  const _SearchActionButton({
    Key? key,
    required List<TextEditingController> controllers,
  })  : _controllers = controllers,
        super(key: key);

  final List<TextEditingController> _controllers;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => searchUsersWithTwoFields(
        context,
        idController: _controllers[0],
        nameController: _controllers[1],
      ),
      child: const Icon(Icons.person_search),
    );
  }
}

class _SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final VoidCallback submit;

  const _SearchBar({
    Key? key,
    required this.controller,
    required this.title,
    required this.submit,
  }) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xFFD7D7D7),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xE81967A4),
              blurRadius: 3,
              offset: Offset(1, 2),
            )
          ]),
      child: TextField(
        controller: widget.controller,
        onChanged: (v) => setState(() {}),
        onSubmitted: (value) => widget.submit.call(),
        decoration: InputDecoration(
          suffixIcon: widget.controller.text.isNotEmpty
              ? InkWell(
                  child: const Icon(Icons.highlight_remove,
                      color: Colors.redAccent),
                  onTap: () => setState(() => widget.controller.clear()),
                )
              : null,
          hintText: widget.title,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  final List<UserModel> users;

  const UsersList({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return users.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (_, __) => const Divider(thickness: 2),
            itemCount: users.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index].phone),
                minVerticalPadding: 0,
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(users[index].email),
                    Text("ID: ${users[index].id}"),
                  ],
                ),
              );
            },
          )
        : const Center(
            child: Text("User Not Found"),
          );
  }
}

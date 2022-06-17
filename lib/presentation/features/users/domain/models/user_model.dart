import 'package:user_search_test/data/dtos/user_dto.dart';

/// Provides the User Interface with only the needed data
class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  factory UserModel.fromDto(UserDto dto) => UserModel(
        id: dto.id,
        name: dto.name,
        username: dto.username,
        email: dto.email,
        phone: dto.phone,
        website: dto.website,
      );
}

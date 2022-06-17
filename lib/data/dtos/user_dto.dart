import 'dart:convert';

import 'company_dto.dart';

class UserListDto {
  UserListDto({
    required this.users,
  });

  final List<UserDto> users;

  factory UserListDto.fromRawJson(String str) =>
      UserListDto.fromJson(json.decode(str));

  factory UserListDto.fromJson(List<dynamic> json) => UserListDto(
        users: List<UserDto>.from(json.map((x) => UserDto.fromJson(x))),
      );
}

/// Onetime Generated Class
///
/// Manual additions:
///
/// Providing default value if a field is null (helps in minimizing null errors)
class UserDto {
  UserDto({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.company,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final CompanyDto company;

  factory UserDto.fromRawJson(String str) => UserDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        website: json["website"] ?? "",
        company: CompanyDto.fromJson(json["company"]),
      );


  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "website": website,
        "company": company.toJson(),
      };
}

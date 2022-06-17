import 'dart:convert';

/// Onetime Generated Class
///
/// Manual additions:
///
/// Providing default value if a field is null (helps in minimizing null errors)
class CompanyDto {
  CompanyDto({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  final String name;
  final String catchPhrase;
  final String bs;

  factory CompanyDto.fromRawJson(String str) =>
      CompanyDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDto.fromJson(Map<String, dynamic> json) => CompanyDto(
        name: json["name"] ?? "",
        catchPhrase: json["catchPhrase"] ?? "",
        bs: json["bs"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class ListUser {
  ListUser({
    required this.page,
    required this.data,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });
  @HiveField(0)
  int page;

  @HiveField(1)
  int perPage;

  @HiveField(2)
  int total;

  @HiveField(3)
  int totalPages;

  @HiveField(4)
  List<User> data;

  factory ListUser.fromJson(Map<String, dynamic> json) => ListUser(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );
}

@HiveType(typeId: 2)
class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        avatar: json["avatar"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );
}

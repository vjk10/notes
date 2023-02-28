import 'package:isar/isar.dart';
part 'user_schema.g.dart';

@collection
class UserLocal {
  UserLocal(
      {required this.displayname,
      required this.dob,
      required this.phonenumber,
      required this.email,
      required this.username});
  Id id = 1;

  final String displayname;

  final String dob;

  final String phonenumber;

  final String email;

  final String username;
}

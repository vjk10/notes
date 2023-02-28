import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createFieldMap: true,
  createToJson: true,
  createPerFieldToJson: true,
  createFactory: true,
)
@Collection<UserModel>('users')
class UserModel {
  UserModel({
    required this.id,
    required this.displayname,
    required this.dob,
    required this.phonenumber,
    required this.email,
    required this.username,
  });

  final String id;
  final String displayname;
  final String dob;
  final String phonenumber;
  final String email;
  final String username;
}

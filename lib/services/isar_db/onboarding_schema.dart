import 'package:isar/isar.dart';

part 'onboarding_schema.g.dart';

@collection
class Onboarding {
  Id id = Isar.autoIncrement;
  String? onboarding;
}

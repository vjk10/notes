import 'package:isar/isar.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/services/isar_db/onboarding_schema.dart';
import 'package:notes/services/isar_db/user_schema.dart';

class IsarDB {
  instantiate() async {
    return Isar.open(
      [
        UserLocalSchema,
        OnboardingSchema,
        BoardsLocalSchema,
        NotesLocalSchema,
      ],
      inspector: true,
    );
  }
}

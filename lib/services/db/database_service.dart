import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scientisst_db/scientisst_db.dart';
import 'package:notes/services/imports.dart';

class DatabaseService {
  backUpSingleNote(String uid, String noteId, String title, String body,
      String creationDate, bool pinned) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(noteId)
        .set(
      {
        "noteId": noteId,
        "title": title,
        "body": body,
        "creationDate": creationDate,
        "pinned": pinned
      },
    ).whenComplete(() {
      HapticFeedback.heavyImpact();
      Get.showSnackbar(
        GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: c.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.cloud_done_rounded,
            color: c.primary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            title + " backed up",
            style: t.textTheme.caption?.copyWith(color: c.onSurface),
          ),
        ),
      );
    });
  }

  importNotes(String uid) async {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: c.surface,
      title: Text(
        "Cloud Backup",
        style: t.textTheme.headline6?.copyWith(
          color: c.onSurface,
        ),
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NotesLoadingAndroid(),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Importing notes",
            style: t.textTheme.button?.copyWith(color: c.onSurface),
          )
        ],
      ),
    ));
    var importSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("notes")
        .get();

    if (importSnapshot.docs.isNotEmpty) {
      for (var element in importSnapshot.docs) {
        if (kDebugMode) {
          print("Note Title: " + element.get("title"));
        }
        var note = Note(
          body: element.get("body").toString(),
          creationTime: element.get("creationDate"),
          title: element.get("title").toString(),
          pinned: element.get("pinned"),
          isList: element.get("isList"),
          isExpense: element.get("isExpense"),
          totalItems: element.get("totalItems"),
        );
        await ScientISSTdb.instance
            .collection("notes")
            .document(element.get("noteId"))
            .set({
          "title": note.title,
          "body": note.body,
          "creationTime": note.creationTime,
          "pinned": note.pinned,
          "isList": note.isList
        });
      }
      Get.back();
      Get.showSnackbar(
        GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: c.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.cloud_download,
            color: c.primary,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "All notes imported successfully!",
            style: t.textTheme.caption?.copyWith(color: c.onSurface),
          ),
        ),
      );
    }
  }
}

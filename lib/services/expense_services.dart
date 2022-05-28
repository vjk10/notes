import 'dart:io';
import 'package:excel/excel.dart';
import 'package:notes/services/imports.dart';
// import 'package:open_document/open_document.dart';
import 'package:permission_handler/permission_handler.dart';

class ExpenseServices {
  List<String> headers = ["Row", "Type", "Amount", "Description"];

  Future<bool> checkStoragePermission() async {
    // ignore: no_leading_underscores_for_local_identifiers
    var _storageAllowed = await Permission.storage.isGranted;
    if (_storageAllowed) {
      return true;
    } else {
      Permission.storage.request().then((value) {
        if (value.isGranted) {
          return true;
        } else {
          return false;
        }
      });
    }
    return false;
  }

  checkDirectory() async {
    // CHECKING AND CREATING DIRECTORY
    var appDirectory = Directory(excelFilePath);
    bool directoryExists = appDirectory.existsSync();
    if (!directoryExists) {
      appDirectory.createSync(recursive: true);
      return true;
    } else {
      return true;
    }
  }

  downloadExcel(String sheetName, List<ExpenseModel> expenses) async {
    if (sheetName.isNotEmpty) {
      final excel = Excel.createExcel();
      final sheet = excel[excel.getDefaultSheet()!];
      if (kDebugMode) {
        print("Default Sheet: $sheet");
      }
      // Adding Header
      for (var header = 0; header < headers.length; header++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: header, rowIndex: 0))
            .value = headers[header];
      }
      // Adding Records
      for (var expense = 0; expense < expenses.length; expense++) {
        sheet
            .cell(CellIndex.indexByColumnRow(
                columnIndex: 0, rowIndex: expense + 1))
            .value = expenses[expense].index;
        sheet
            .cell(CellIndex.indexByColumnRow(
                columnIndex: 1, rowIndex: expense + 1))
            .value = expenses[expense].type;
        sheet
            .cell(CellIndex.indexByColumnRow(
                columnIndex: 2, rowIndex: expense + 1))
            .value = expenses[expense].amount;
        sheet
            .cell(CellIndex.indexByColumnRow(
                columnIndex: 3, rowIndex: expense + 1))
            .value = expenses[expense].description;
      }
      var fileBytes = excel.save();
      try {
        var file = File(join("$excelFilePath/$sheetName.xlsx"))
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);
        if (file.path.isNotEmpty) {
          Get.showSnackbar(GetSnackBar(
            shouldIconPulse: false,
            backgroundColor: c.surface,
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            borderRadius: 10,
            icon: Icon(
              Icons.file_download_done_outlined,
              color: c.primary,
            ),
            duration: const Duration(seconds: 2),
            titleText: Text(
              "$sheetName downloaded successfully",
              style: t.textTheme.caption?.copyWith(color: c.onSurface),
            ),
            messageText: Text(
              "$excelFilePath/$sheetName.xlsx",
              style: t.textTheme.bodySmall,
            ),
            // mainButton: TextButton(
            //   child: const Text("Open File"),
            //   onPressed: () async {
            //     if (kDebugMode) {
            //       print("$excelFilePath/$sheetName.xlsx");
            //     }
            //     // try {
            //     //   await OpenDocument.openDocument(
            //     //       filePath: "$excelFilePath/$sheetName.xlsx");
            //     // } on OpenDocumentException catch (e) {
            //     //   Get.showSnackbar(GetSnackBar(
            //     //     shouldIconPulse: false,
            //     //     backgroundColor: c.surface,
            //     //     margin: const EdgeInsets.symmetric(
            //     //         vertical: 16, horizontal: 16),
            //     //     borderRadius: 10,
            //     //     icon: Icon(
            //     //       Icons.error,
            //     //       color: c.error,
            //     //     ),
            //     //     duration: const Duration(seconds: 2),
            //     //     messageText: Text(
            //     //       e.errorMessage,
            //     //       style: t.textTheme.caption?.copyWith(color: c.onSurface),
            //     //     ),
            //     //   ));
            //     // }
            //   },
            // ),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            shouldIconPulse: false,
            backgroundColor: c.surface,
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            borderRadius: 10,
            icon: Icon(
              Icons.file_download_off_outlined,
              color: c.error,
            ),
            duration: const Duration(seconds: 2),
            messageText: Text(
              "Error downloading $sheetName",
              style: t.textTheme.caption?.copyWith(color: c.onSurface),
            ),
          ));
        }
      } on FileSystemException catch (e) {
        Get.showSnackbar(GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: c.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.error,
            color: c.error,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            e.message,
            style: t.textTheme.caption?.copyWith(color: c.onSurface),
          ),
          mainButton: TextButton(
            child: const Text("Open Settings"),
            onPressed: () {
              openAppSettings();
            },
          ),
        ));
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        shouldIconPulse: false,
        backgroundColor: c.surface,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        borderRadius: 10,
        icon: Icon(
          Icons.error,
          color: c.error,
        ),
        duration: const Duration(seconds: 2),
        messageText: Text(
          "Sheetname is empty!",
          style: t.textTheme.caption?.copyWith(color: c.onSurface),
        ),
      ));
    }
  }
}

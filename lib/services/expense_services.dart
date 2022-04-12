import 'dart:io';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:notes/services/imports.dart';

class ExpenseServices {
  List<String> headers = ["Row", "Type", "Amount", "Description"];

  downloadExcel(String sheetName, List<ExpenseModel> expenses) async {
    var status = await permission_handler.Permission.storage.status;
    if (status.isDenied) {
      await permission_handler.Permission.storage.request();
    } else {
      final excel = Excel.createExcel();
      final sheet = excel[excel.getDefaultSheet()!];
      if (kDebugMode) {
        print("Default Sheet: " + sheet.toString());
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

      /// Get Android [downloads] top-level shared folder
      /// You can also create a reference to a custom directory as: `EnvironmentDirectory.custom('Custom Folder')`
      final sharedDirectory = await getExternalStoragePublicDirectory(
          EnvironmentDirectory.downloads);

      if (kDebugMode) {
        print(sharedDirectory!.path);
      }

      /// `/storage/emulated/0/Download`
      var filePathDownload = sharedDirectory!.path.toString();

      var file = File(join("$filePathDownload/$sheetName.xlsx"))
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
          messageText: Text(
            "$sheetName downloaded successfully",
            style: t.textTheme.caption?.copyWith(color: c.onSurface),
          ),
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
    }
  }
}

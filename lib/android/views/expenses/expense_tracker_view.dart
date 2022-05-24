import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/android/data/data.dart';
import 'package:notes/android/widgets/double_dialog.dart';
import 'package:notes/android/widgets/text_dialog.dart';
import 'package:notes/services/data_table_services.dart';
import 'package:notes/services/db/database_notes.dart';
import 'package:notes/services/db/note_expense_model.dart';
import 'package:notes/services/expense_services.dart';
import 'package:notes/services/notifier.dart';
import 'package:notes/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:scientisst_db/scientisst_db.dart';

class ExpenseTrackerView extends StatefulWidget {
  final String noteId;
  const ExpenseTrackerView({Key? key, required this.noteId}) : super(key: key);

  @override
  State<ExpenseTrackerView> createState() => _ExpenseTrackerViewState();
}

class _ExpenseTrackerViewState extends State<ExpenseTrackerView> {
  List<DataRow> rows = [];
  List<ExpenseModel> expenses = [];
  int currentIndex = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  List<DataColumn> columns = [];
  late String title, body;

  bool pinned = false;
  int totalItems = 0;
  late DocumentSnapshot noteSnapshot;
  List<DocumentSnapshot> listSnapshot = [];
  List<CollectionReference> collectionSnapshot = [];

  @override
  void initState() {
    refreshNote();
    columns = DataTableServices().initColumns(c, t, columns);
    super.initState();
  }

  refreshNote() async {
    if (kDebugMode) {
      print("NOTE ID: ${widget.noteId}");
    }
    noteSnapshot = await ScientISSTdb.instance
        .collection("notes")
        .document(widget.noteId)
        .get();
    setState(() {
      titleController.text = noteSnapshot.data["title"].toString();
      bodyController.text = noteSnapshot.data["body"].toString();
      totalItems = noteSnapshot.data["totalItems"];
      pinned = noteSnapshot.data["pinned"] as bool;
    });
    for (var c = 0; c < totalItems; c++) {
      DocumentSnapshot collectionSnapshot = await ScientISSTdb.instance
          .collection("notes")
          .document(widget.noteId)
          .collection(c.toString())
          .document(c.toString())
          .get();
      if (kDebugMode) {
        print(collectionSnapshot.data["text"].toString());
      }
      setState(() {
        // rows.add(currentIndex);
        // checked.add(false);
        ExpenseModel item = ExpenseModel(
          type: collectionSnapshot.data["type"],
          index: collectionSnapshot.data["index"],
          amount: collectionSnapshot.data["amount"],
          description: collectionSnapshot.data["description"],
        );
        expenses.add(item);
        currentIndex = currentIndex + 1;
      });
    }
  }

  addRow(int index) {
    ExpenseModel expense =
        ExpenseModel(index: index, type: '', description: " ", amount: 0.00);
    setState(() {
      expenses.insert(index, expense);
    });
    currentIndex = index + 1;
  }

  List<DataRow> getRows(List<ExpenseModel> expenses) =>
      expenses.map((ExpenseModel expense) {
        final cells = [
          // expense.index,
          expense.type,
          expense.amount,
          expense.description,
        ];
        return DataRow(
          color: expense.index.isEven
              ? MaterialStateProperty.all(c.secondaryContainer)
              : MaterialStateProperty.all(c.tertiaryContainer),
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(
              Text(
                index == 1 ? '$currency$cell' : '$cell',
                style: t.textTheme.bodySmall?.copyWith(
                  color: expense.index.isEven
                      ? c.onSecondaryContainer
                      : c.onTertiaryContainer,
                ),
              ),
              onLongPress: () {
                switch (index) {
                  case 0:
                    setState(() {
                      var deleteIndex = expenses.indexWhere(
                          ((element) => element.index == expense.index));
                      if (kDebugMode) {
                        print(deleteIndex);
                      }
                      setState(() {
                        expenses.removeAt(deleteIndex);
                        currentIndex = expenses.length;
                      });
                    });
                    break;
                  default:
                }
              },
              onTap: () {
                switch (index) {
                  case 0:
                    editType(expense, index);
                    break;
                  case 1:
                    editAmount(expense, index);
                    break;
                  case 2:
                    editDescription(expense, index);
                    break;
                }
              },
            );
          }),
        );
      }).toList();

  Future editType(ExpenseModel editExpense, int index) async {
    final type = await showTextDialog(
      context,
      t: t,
      c: c,
      title: 'Label',
      value: editExpense.type,
    );
    setState(() => expenses = expenses.map((expense) {
          final isEditedType = expense.index == editExpense.index;

          if (isEditedType) {
            return expense.copy(type: type, index: editExpense.index);
          } else {
            return expense;
          }
        }).toList());
  }

  Future editDescription(ExpenseModel editExpense, int index) async {
    final description = await showTextDialog(
      context,
      t: t,
      c: c,
      title: 'Description',
      value: editExpense.description,
    );
    setState(() => expenses = expenses.map((expense) {
          final isEditedDescription = expense.index == editExpense.index;

          if (isEditedDescription) {
            return expense.copy(
                description: description, index: editExpense.index);
          } else {
            return expense;
          }
        }).toList());
  }

  Future editAmount(ExpenseModel editExpense, int index) async {
    final amount = await showDoubleDialog(
      context,
      t: t,
      c: c,
      title: 'Amount',
      value: '',
    );
    setState(() => expenses = expenses.map((expense) {
          final isEditedAmount = expense.index == editExpense.index;

          if (isEditedAmount) {
            double amount1 = double.parse(amount);
            if (!amount1.isNaN) {
              return expense.copy(amount: amount1, index: editExpense.index);
            } else {
              return expense;
            }
          } else {
            return expense;
          }
        }).toList());
  }

  @override
  void didChangeDependencies() {
    t = Theme.of(context);
    c = t.colorScheme;
    columns = DataTableServices().initColumns(c, t, columns);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, notifier, child) {
      return WillPopScope(
        onWillPop: () async {
          bool autosave = await NotesDatabase().checkAutoSave();
          if (autosave) {
            NotesDatabase().updateExpenseSheet(
              titleController,
              bodyController,
              pinned,
              expenses,
              widget.noteId,
            );
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: c.background,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: c.onBackground),
            backgroundColor: c.secondaryContainer.withAlpha(50),
            title: Text(
              "expense",
              style: t.textTheme.headline5,
            ),
            leading: IconButton(
              onPressed: () async {
                bool autosave = await NotesDatabase().checkAutoSave();
                if (autosave) {
                  NotesDatabase().updateExpenseSheet(
                    titleController,
                    bodyController,
                    false,
                    expenses,
                    widget.noteId,
                  );
                  // Get.offAllNamed('/mainScreen');
                  Get.back();
                } else {
                  Get.back();
                }
              },
              icon: Icon(
                Icons.arrow_back,
                color: c.onBackground,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: () async {
                    NotesDatabase().updateExpenseSheet(
                      titleController,
                      bodyController,
                      pinned,
                      expenses,
                      widget.noteId,
                    );
                  },
                  icon: Icon(
                    Icons.save_outlined,
                    color: c.primary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print("DOC ID: ${noteSnapshot.id}");
                  }
                  NotesDatabase().deleteNote(noteSnapshot.id);
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: c.error,
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size(Get.width, 100),
              child: bottomTextFields(),
            ),
            toolbarHeight: 80,
          ),
          bottomNavigationBar: expenseBottomBar(),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: Get.width,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(c.inversePrimary),
                  decoration: BoxDecoration(
                    color: c.surface,
                  ),
                  dividerThickness: 0,
                  dataTextStyle: t.textTheme.bodyMedium,
                  border: TableBorder(
                    verticalInside: BorderSide(color: c.outline, width: 1),
                    horizontalInside: BorderSide(color: c.outline, width: 1),
                  ),
                  showBottomBorder: true,
                  columns: columns,
                  rows: getRows(expenses),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Visibility expenseBottomBar() {
    return Visibility(
      visible: true,
      child: SizedBox(
        height: 65,
        child: Consumer<ThemeNotifier>(builder: (context, notifier, child) {
          return BottomAppBar(
            elevation: 0,
            color: notifier.material3
                ? c.secondaryContainer.withAlpha(50)
                : c.secondaryContainer,
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.none,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    addRow(currentIndex);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.post_add_outlined,
                        color: c.onSecondaryContainer,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Add Row",
                        style: t.textTheme.bodySmall?.copyWith(
                          color: c.onSecondaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      expenses.clear();
                      currentIndex = 0;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_sweep_outlined,
                        color: c.onSecondaryContainer,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Delete Rows",
                        style: t.textTheme.bodySmall?.copyWith(
                          color: c.onSecondaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ExpenseServices()
                        .downloadExcel(titleController.text, expenses);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        color: c.onSecondaryContainer,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Export",
                        style: t.textTheme.bodySmall?.copyWith(
                          color: c.onSecondaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Column bottomTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          controller: titleController,
          style: t.textTheme.headline4,
          onChanged: (value) {
            setState(() {
              title = value.toString();
            });
          },
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15.0,
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "sheet name",
            hintStyle: t.textTheme.headline4,
          ),
        ),
        TextFormField(
          controller: bodyController,
          style: t.textTheme.bodySmall?.copyWith(color: c.onBackground),
          onChanged: (value) {
            setState(() {
              body = value.toString();
            });
          },
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15.0,
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "description",
            hintStyle: t.textTheme.bodySmall?.copyWith(color: c.onBackground),
          ),
        ),
      ],
    );
  }
}

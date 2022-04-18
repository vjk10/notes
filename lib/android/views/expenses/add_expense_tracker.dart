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
import 'package:notes/services/utils.dart';

class AddExpenseTrackerView extends StatefulWidget {
  const AddExpenseTrackerView({Key? key}) : super(key: key);

  @override
  State<AddExpenseTrackerView> createState() => _AddExpenseTrackerViewState();
}

class _AddExpenseTrackerViewState extends State<AddExpenseTrackerView> {
  List<DataRow> rows = [];
  List<ExpenseModel> expenses = [];
  int currentIndex = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  List<DataColumn> columns = [];
  late String title, body;

  @override
  void initState() {
    if (rows.isEmpty) {
      addRow(0);
    }
    columns = DataTableServices().initColumns(c, t, columns);
    super.initState();
  }

  addRow(int index) {
    ExpenseModel expense = ExpenseModel(
        index: index, type: 'Select Type...', description: " ", amount: 0.00);
    setState(() {
      expenses.insert(index, expense);
    });
    currentIndex = index + 1;
  }

  List<DataRow> getRows(List<ExpenseModel> expenses) =>
      expenses.map((ExpenseModel expense) {
        final cells = [
          expense.index,
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
                index == 2 ? '$currency$cell' : '$cell',
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
                      var _deleteIndex = expenses.indexWhere(
                          ((element) => element.index == expense.index));
                      if (kDebugMode) {
                        print(_deleteIndex);
                      }
                      setState(() {
                        expenses.removeAt(_deleteIndex);
                        currentIndex = expenses.length;
                      });
                    });
                    break;
                  default:
                }
              },
              onTap: () {
                switch (index) {
                  case 1:
                    editType(expense, index);
                    break;
                  case 2:
                    editAmount(expense, index);
                    break;
                  case 3:
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
      title: 'Change Type',
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
      title: 'Change Description',
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
      title: 'Change Description',
      value: editExpense.amount.toString(),
    );
    setState(() => expenses = expenses.map((expense) {
          final isEditedAmount = expense.index == editExpense.index;

          if (isEditedAmount) {
            double _amount = double.parse(amount);
            if (!_amount.isNaN) {
              return expense.copy(amount: _amount, index: editExpense.index);
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
    return WillPopScope(
      onWillPop: () async {
        if (expenses.isNotEmpty && titleController.text.isNotEmpty) {
          bool _autosave = await NotesDatabase().checkAutoSave();
          if (_autosave) {
            await NotesDatabase().saveExpenseSheet(
                titleController, bodyController, false, expenses);
          }
        }
        Get.offAllNamed('/mainScreen');
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
              if (expenses.isNotEmpty && titleController.text.isNotEmpty) {
                bool _autosave = await NotesDatabase().checkAutoSave();
                if (_autosave) {
                  NotesDatabase().saveExpenseSheet(
                      titleController, bodyController, false, expenses);
                }
              } else {
                Get.offAllNamed('/mainScreen');
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
                  if (expenses.isNotEmpty && titleController.text.isNotEmpty) {
                    await NotesDatabase()
                        .saveExpenseSheet(
                            titleController, bodyController, false, expenses)
                        .whenComplete(() {
                      Get.offAllNamed('/mainScreen');
                    });
                  }
                },
                icon: Icon(
                  Icons.save_outlined,
                  color: c.primary,
                ),
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
    );
  }

  Visibility expenseBottomBar() {
    return Visibility(
      visible: true,
      child: SizedBox(
        height: 65,
        child: BottomAppBar(
          elevation: 0,
          color: c.secondaryContainer.withAlpha(50),
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
                onTap: () async {
                  await ExpenseServices().checkStoragePermission().then(
                    (value) async {
                      if (value == true) {
                        bool directoryStatus =
                            await ExpenseServices().checkDirectory();
                        if (directoryStatus) {
                          ExpenseServices()
                              .downloadExcel(titleController.text, expenses);
                        }
                      }
                    },
                  );
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
        ),
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
            hintText: "Sheet Name",
            hintStyle: t.textTheme.headline4,
          ),
        ),
        TextFormField(
          controller: bodyController,
          style: t.textTheme.bodySmall,
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
            hintText: "Description",
            hintStyle: t.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

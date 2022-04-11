class ExpenseModel {
  int index;
  String type;
  String description;
  double amount;

  ExpenseModel({
    required this.index,
    required this.type,
    required this.description,
    required this.amount,
  });

  ExpenseModel copy({
    String? type,
    String? description,
    double? amount,
    int? index,
  }) =>
      ExpenseModel(
        type: type ?? this.type,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        index: index ?? this.index,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          description == other.description &&
          amount == other.amount;

  @override
  int get hashCode => type.hashCode ^ description.hashCode ^ amount.hashCode;
}

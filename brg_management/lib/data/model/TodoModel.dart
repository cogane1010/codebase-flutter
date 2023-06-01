class TodoModel {
  TodoModel(
      {this.tittle,
      this.amount,
      this.toDoListType,
      this.moduleName,
      this.color});

  TodoModel.fromJson(dynamic json) {
    tittle = json['Tittle'];
    amount = json['Amount'];
    toDoListType = json['ToDoListType'];
    moduleName = json['ModuleName'];
    color = json['Color'];
  }
  String? tittle;
  String? amount;
  String? toDoListType;
  String? moduleName;
  String? color;
}

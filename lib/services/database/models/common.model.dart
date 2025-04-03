Map<String, String> commonColumns = {'id': 'INTEGER PRIMARY KEY'};

abstract class CommonModel {
  int? id;

  String get tableName => 'common_table';
  Map<String, String> get columns => commonColumns;

  CommonModel({this.id});

  Map<String, dynamic> toMap() {
    return {};
  }

  CommonModel fromMap(Map<String, dynamic> map);
}

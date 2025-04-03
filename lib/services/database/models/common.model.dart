enum Status { DELETED, AVAILABLE, UNAVAILABLE }

extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.DELETED:
        return 'deleted';
      case Status.AVAILABLE:
        return 'available';
      case Status.UNAVAILABLE:
        return 'unavailable';
    }
  }
}

Map<String, String> commonColumns = {
  'id': 'TEXT PRIMARY KEY',
  'created_date': 'DATETIME',
  'modified_date': 'DATETIME',
  'status': 'TEXT',
};

abstract class CommonModel {
  String get tableName => 'common_table';
  Map<String, String> get columns => commonColumns;

  String get id;
  DateTime get createdDate;
  DateTime get modifiedDate;
  Status get status;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_date': createdDate.toIso8601String(),
      'modified_date': modifiedDate.toIso8601String(),
      'status': status.value,
    };
  }
}

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

class CommonModel {
  final String id;
  final DateTime createdDate;
  final DateTime modifiedDate;
  final Status status;

  CommonModel({
    required this.id,
    required this.createdDate,
    required this.modifiedDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdDate': createdDate.toIso8601String(),
      'modifiedDate': modifiedDate.toIso8601String(),
      'status': status.value,
    };
  }

  factory CommonModel.fromMap(Map<String, dynamic> map) {
    return CommonModel(
      id: map['id'] as String,
      createdDate: DateTime.parse(map['createdDate'] as String),
      modifiedDate: DateTime.parse(map['modifiedDate'] as String),
      status: Status.values.firstWhere(
        (e) => e.value == map['status'] as String,
      ),
    );
  }
}

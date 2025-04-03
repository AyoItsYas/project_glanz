import 'common.model.dart';

class ItemType extends CommonModel {
  @override
  final String tableName = 'item_type';
  @override
  final Map<String, String> columns = {...commonColumns, 'label': 'TEXT'};

  @override
  final String id;
  @override
  final DateTime createdDate;
  @override
  final DateTime modifiedDate;
  @override
  final Status status;

  final String label;

  ItemType({
    required this.id,
    required this.createdDate,
    required this.modifiedDate,
    required this.status,
    required this.label,
  });

  @override
  Map<String, dynamic> toMap() {
    return {...super.toMap(), 'label': label};
  }
}

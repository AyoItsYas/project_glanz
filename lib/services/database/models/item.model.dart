import 'common.model.dart';

class ItemModel extends CommonModel {
  @override
  final String tableName = 'item';
  @override
  final Map<String, String> columns = {
    ...commonColumns,
    'label': 'TEXT',
    'type_id': 'INTEGER',
    'color': 'TEXT',
    'material': 'TEXT',
    'image_path': 'TEXT',
  };

  @override
  final String id;
  @override
  final DateTime createdDate;
  @override
  final DateTime modifiedDate;
  @override
  final Status status;

  final String label;
  final int typeId;
  final String color;
  final String material;
  final String imagePath;

  ItemModel({
    required this.id,
    required this.createdDate,
    required this.modifiedDate,
    required this.status,
    required this.label,
    required this.typeId,
    required this.color,
    required this.material,
    required this.imagePath,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'label': label,
      'type_id': typeId,
      'color': color,
      'material': material,
      'image_path': imagePath,
    };
  }
}

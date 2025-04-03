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

  final String label;
  final int typeId;
  final String color;
  final String material;
  final String imagePath;

  ItemModel({
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

  @override
  ItemModel fromMap(Map<String, dynamic> map) {
    return ItemModel(
      label: map['label'],
      typeId: map['type_id'],
      color: map['color'],
      material: map['material'],
      imagePath: map['image_path'],
    );
  }
}

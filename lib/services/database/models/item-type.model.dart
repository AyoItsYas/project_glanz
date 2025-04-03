import 'common.model.dart';

class ItemTypeModel extends CommonModel {
  @override
  final String tableName = 'item_type';
  @override
  final Map<String, String> columns = {...commonColumns, 'label': 'TEXT'};

  final String label;

  ItemTypeModel({required this.label});

  @override
  Map<String, dynamic> toMap() {
    return {...super.toMap(), 'label': label};
  }

  @override
  ItemTypeModel fromMap(Map<String, dynamic> map) {
    return ItemTypeModel(label: map['label']);
  }
}

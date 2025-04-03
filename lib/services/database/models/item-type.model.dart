import 'common.model.dart';

class ItemTypeModel extends CommonModel {
  @override
  final String tableName = 'item_type';
  @override
  final Map<String, String> columns = {...commonColumns, 'label': 'TEXT'};

  final String label;

  ItemTypeModel({int? id, required this.label}) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return {...super.toMap(), 'label': label};
  }

  @override
  ItemTypeModel fromMap(Map<String, dynamic> map) {
    print('ItemTypeModel fromMap: $map');
    return ItemTypeModel(id: map['id'], label: map['label']);
  }
}

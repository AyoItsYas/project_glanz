import 'common.model.dart';

class ItemModel extends CommonModel {
  final String label;
  final int typeId;
  final String color;
  final String material;

  ItemModel({
    required String id,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required Status status,
    required this.label,
    required this.typeId,
    required this.color,
    required this.material,
  }) : super(
         id: id,
         createdDate: createdDate,
         modifiedDate: modifiedDate,
         status: status,
       );
}

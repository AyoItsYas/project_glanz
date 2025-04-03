import 'common.model.dart';

class ItemType extends CommonModel {
  final String label;

  ItemType({
    required String id,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required Status status,
    required this.label,
  }) : super(
         id: id,
         createdDate: createdDate,
         modifiedDate: modifiedDate,
         status: status,
       );
}

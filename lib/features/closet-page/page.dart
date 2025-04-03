import 'package:flutter/material.dart';
import 'package:project_glanz/services/database/database.service.dart';
import 'package:project_glanz/services/database/models/item.model.dart';
import 'package:project_glanz/services/database/models/item-type.model.dart';

import "./create_closet_item.dart" as create_closet_item;

class ClosetView extends StatefulWidget {
  const ClosetView({super.key});

  @override
  State<ClosetView> createState() => _ClosetViewState();
}

class _ClosetViewState extends State<ClosetView> {
  final PageController _pageController = PageController();
  late Future<List<ItemModel>> _itemsFuture;
  late Future<List<ItemTypeModel>> _itemTypesFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = DatabaseService().fetchAll<ItemModel>(
      ItemModel(color: "", typeId: 0, label: "", material: "", imagePath: ""),
    );

    _itemTypesFuture = DatabaseService().fetchAll<ItemTypeModel>(
      ItemTypeModel(label: ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Closet')),
      body: FutureBuilder<List<ItemModel>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items available.'));
          }

          final itemTypes = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ...itemTypes.map((itemType) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(itemType.id.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(itemType.label),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => create_closet_item.CreateClosetItemPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

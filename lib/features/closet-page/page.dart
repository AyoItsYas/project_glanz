import 'package:flutter/material.dart';
import 'package:project_glanz/components/cool-button.dart';
import 'package:project_glanz/components/cool-card.dart';
import 'package:project_glanz/services/database/database.service.dart';
import 'package:project_glanz/services/database/models/item.model.dart';
import 'package:project_glanz/services/database/models/item-type.model.dart';
import 'package:project_glanz/components/pill.dart';

import "./create_closet_item.dart" as create_closet_item;

class ClosetView extends StatefulWidget {
  const ClosetView({super.key});

  @override
  State<ClosetView> createState() => _ClosetViewState();
}

class _ClosetViewState extends State<ClosetView> {
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
      body: FutureBuilder<List<ItemModel>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CoolCard(
                    imagePath: 'lib/assets/warning.svg',
                    bottomText: 'Such an Empty Closet',
                    bottomSubtext: 'Add some items to Continue!',
                    hideBottomBar: false,
                    height: 340,
                    width: 340,
                  ),
                  SizedBox(height: 20),
                  CoolButton(
                    text: "Add Item",
                    width: 340.0,
                    height: 50.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  create_closet_item.CreateClosetItemPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          final itemTypes = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          2, // You can adjust the number of items per row
                      crossAxisSpacing:
                          16.0, // Horizontal space between grid items
                      mainAxisSpacing:
                          16.0, // Vertical space between grid items
                      childAspectRatio:
                          0.75, // Adjust the aspect ratio of items in the grid
                    ),
                    itemCount: itemTypes.length,
                    itemBuilder: (context, index) {
                      final itemType = itemTypes[index];
                      return CoolCard(
                        imagePath: 'lib/assets/demo.png',
                        bottomText: itemType.label,
                        progressValues: [0.5],
                        progressTexts: ["Condition"],
                        hideBottomBar: false,
                        width: 340.0,
                        height: 400.0,
                        alignment: MainAxisAlignment.start,
                      );
                    },
                  ),
                ),
                CoolButton(
                  text: 'Add More Items',
                  width: 340.0,
                  height: 50.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                create_closet_item.CreateClosetItemPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:project_glanz/features/closet-page/create_item_type.dart';
import 'package:project_glanz/services/database/database.service.dart';
import 'package:project_glanz/services/database/models/item.model.dart';
import 'package:project_glanz/services/database/models/item-type.model.dart';

class CreateClosetItemPage extends StatefulWidget {
  @override
  _CreateClosetItemPageState createState() => _CreateClosetItemPageState();
}

class _CreateClosetItemPageState extends State<CreateClosetItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _typeIdController = TextEditingController();
  final _colorController = TextEditingController();
  final _materialController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late Future<List<ItemTypeModel>> _itemTypesFuture;

  @override
  void initState() {
    super.initState();
    _itemTypesFuture = DatabaseService().fetchAll<ItemTypeModel>(
      ItemTypeModel(label: ""),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveItem() {
    print(_labelController.text);
    print(_typeIdController.text);
    print(_colorController.text);
    print(_materialController.text);
    print(_imageFile?.path);

    if (_formKey.currentState!.validate()) {
      final newItem = ItemModel(
        label: _labelController.text,
        typeId: int.parse(_typeIdController.text),
        color: _colorController.text,
        material: _materialController.text,
        imagePath: _imageFile?.path ?? '',
      );

      DatabaseService()
          .insert<ItemModel>(newItem)
          .then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('ItemModel created successfully!')),
            );
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error creating ItemModel: $error')),
            );
          });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ItemModel created successfully!')),
      );

      Navigator.pop(context);
    } else {
      if (_imageFile == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please pick an image')));
      }
      if (_labelController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a label')));
      }
      if (_typeIdController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please select an item type')));
      }
      if (_colorController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a color')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Closet Item')),
      body: FutureBuilder<List<ItemTypeModel>>(
        future: _itemTypesFuture,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return Center(child: Text('Error: ${snapshot.error}'));
          // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //   return Center(child: Text('No items available.'));
          // }

          final itemTypes = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _labelController,
                    decoration: InputDecoration(labelText: 'Label'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a label';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<ItemTypeModel>(
                          items:
                              itemTypes.isEmpty
                                  ? [
                                    DropdownMenuItem<ItemTypeModel>(
                                      value: ItemTypeModel(
                                        label: 'No items available.',
                                      ),
                                      child: Text(
                                        'Please Create an Item Type first',
                                      ),
                                    ),
                                  ]
                                  : itemTypes.map((itemType) {
                                    return DropdownMenuItem<ItemTypeModel>(
                                      value: itemType,
                                      child: Text(itemType.label),
                                    );
                                  }).toList(),
                          onChanged: (value) {
                            if (value != null &&
                                value.label != 'No items available.') {
                              print(value.id);
                              print(value.label);
                              _typeIdController.text = value.id.toString();
                            }
                          },
                          decoration: InputDecoration(labelText: 'Item Type'),
                          validator: (value) {
                            if (value == null ||
                                value.label == 'No items available.') {
                              return 'Please select an item type';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateItemTypePage(),
                            ),
                          ).then((_) {
                            setState(() {
                              _itemTypesFuture = DatabaseService()
                                  .fetchAll<ItemTypeModel>(
                                    ItemTypeModel(label: ""),
                                  );
                            });
                          });
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _colorController,
                    decoration: InputDecoration(labelText: 'Color'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a color';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _materialController,
                    decoration: InputDecoration(labelText: 'Material'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a material';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text('Save Item'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateClosetItemPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

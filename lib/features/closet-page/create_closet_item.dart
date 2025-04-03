import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:project_glanz/services/database/database.service.dart';
import 'package:project_glanz/services/database/models/item.model.dart';
import 'package:project_glanz/services/database/models/common.model.dart';

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
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newItem = ItemModel(
        id: DateTime.now().toString(),
        label: _labelController.text,
        typeId: int.parse(_typeIdController.text),
        color: _colorController.text,
        material: _materialController.text,
        imagePath: _image?.path ?? '',
        createdDate: DateTime.now(),
        modifiedDate: DateTime.now(),
        status: Status.AVAILABLE,
      );

      DatabaseService()
          .insert(newItem)
          .then((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Item added successfully!')));
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add item: $error')),
            );
          });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Item added successfully!')));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Closet Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
              TextFormField(
                controller: _typeIdController,
                decoration: InputDecoration(labelText: 'Type ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
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
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!, height: 150),
              ElevatedButton(onPressed: _pickImage, child: Text('Pick Image')),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _labelController.dispose();
    _typeIdController.dispose();
    _colorController.dispose();
    _materialController.dispose();
    super.dispose();
  }
}

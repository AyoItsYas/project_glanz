import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:project_glanz/services/database/database.service.dart';
import 'package:project_glanz/services/database/models/item.model.dart';

class CreateClosetItemPage extends StatefulWidget {
  @override
  _CreateClosetItemPageState createState() => _CreateClosetItemPageState();
}

class _CreateClosetItemPageState extends State<CreateClosetItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _image = pickedImage;
    });
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}');
      print('Description: ${_descriptionController.text}');
      print('Image: ${_image?.path}');
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
              GestureDetector(
                onTap: _pickImage,
                child:
                    _image == null
                        ? Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: Icon(Icons.camera_alt, size: 50),
                        )
                        : Image.file(
                          File(_image!.path),
                          height: 200,
                          fit: BoxFit.cover,
                        ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _saveItem, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}

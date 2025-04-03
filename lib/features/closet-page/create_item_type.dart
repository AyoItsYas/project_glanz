import 'package:flutter/material.dart';

import 'package:project_glanz/services/database/database.service.dart';
import 'package:project_glanz/services/database/models/item-type.model.dart';

class CreateItemTypePage extends StatefulWidget {
  @override
  _CreateItemTypePageState createState() => _CreateItemTypePageState();
}

class _CreateItemTypePageState extends State<CreateItemTypePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newItem = ItemTypeModel(label: _labelController.text);

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

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Item Type')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}

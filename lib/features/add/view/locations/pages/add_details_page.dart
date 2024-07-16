import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin_/features/add/controller/place_provider.dart';

class AddPlacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: placeProvider.nameController,
                decoration: InputDecoration(labelText: 'Place Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a place name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: placeProvider.descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: placeProvider.activitiesController,
                decoration: InputDecoration(labelText: 'Activities'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter activities';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              placeProvider.images.isEmpty
                  ? Text('No images selected.')
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemCount: placeProvider.images.length,
                      itemBuilder: (context, index) {
                        return Image.file(placeProvider.images[index]);
                      },
                    ),
              TextButton(
                onPressed: placeProvider.pickImages,
                child: Text('Pick Images'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await placeProvider.submitForm();
                  Navigator.pop(context); // Go back to the previous page
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

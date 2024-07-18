import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin_/features/add/controller/place_provider.dart';

class AddDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: placeProvider.formKey,
          child: SingleChildScrollView(
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
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Country'),
                  value: placeProvider.selectedCountry,
                  items: placeProvider.countries.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) {
                    placeProvider.selectedCountry = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a country';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Continent'),
                  value: placeProvider.selectedContinent,
                  items: placeProvider.continents.map((continent) {
                    return DropdownMenuItem(
                      value: continent,
                      child: Text(continent),
                    );
                  }).toList(),
                  onChanged: (value) {
                    placeProvider.selectedContinent = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a continent';
                    }
                    return null;
                  },
                ),
                Wrap(
                  spacing: 8.0,
                  children: placeProvider.availableActivities.map((activity) {
                    return ChoiceChip(
                      label: Text(activity),
                      selected: placeProvider.selectedActivities.contains(activity),
                      onSelected: (selected) {
                        placeProvider.toggleActivity(activity);
                      },
                    );
                  }).toList(),
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
                    if (placeProvider.formKey.currentState?.validate() ?? false) {
                      await placeProvider.submitForm();
                      Navigator.pop(context); // Go back to the previous page
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

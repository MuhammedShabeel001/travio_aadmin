import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin_/features/add/controller/place_provider.dart';

class AddDetailsPage extends StatelessWidget {
  const AddDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
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
                  decoration: const InputDecoration(labelText: 'Place Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: placeProvider.descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Country'),
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
                  decoration: const InputDecoration(labelText: 'Continent'),
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
                const SizedBox(height: 16.0),
                placeProvider.images.isEmpty
                    ? const Text('No images selected.')
                    : GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemCount: placeProvider.images.length,
                        itemBuilder: (context, index) {
                          return Image.file(placeProvider.images[index]);
                        },
                      ),
                TextButton(
                  onPressed: placeProvider.pickImages,
                  child: const Text('Pick Images'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (placeProvider.formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Row(
                            children:  [
                              CircularProgressIndicator(),
                              SizedBox(width: 16.0),
                              Text("Submitting..."),
                            ],
                          ),
                        ),
                      );

                      await placeProvider.submitForm(context);

                      // Check if submission was successful before navigating back
                      if (placeProvider.submissionSuccessful) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Successfully added!'),
                          ),
                        );
                        Navigator.pop(context); // Go back to the previous page
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to add place. Please try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all required fields and select photos.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

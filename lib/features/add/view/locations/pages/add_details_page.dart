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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: placeProvider.nameController,
                  decoration: InputDecoration(
                    labelText: 'Place Name',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: placeProvider.descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Country',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Continent',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
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
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(placeProvider.images.length, (index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8.0),
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: FileImage(placeProvider.images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4.0,
                                  right: 4.0,
                                  child: InkWell(
                                    onTap: () {
                                      placeProvider.removeImage(index);
                                    },
                                    child: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
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
                            children: [
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

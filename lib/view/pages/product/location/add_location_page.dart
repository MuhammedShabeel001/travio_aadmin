import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../controller/place_provider.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // Unfocus keyboard on tap
          child: Form(
            key: placeProvider.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    context,
                    controller: placeProvider.nameController,
                    label: 'Place Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a place name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                    context,
                    controller: placeProvider.descriptionController,
                    label: 'Description',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        labelText: 'Country',
                        filled: true,
                        fillColor: Colors.orange[50], // Light orange background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        labelStyle: TextStyle(color: Colors.orange[700]), // Darker orange label
                      ),
                      controller: TextEditingController(text: placeProvider.selectedCountry),
                    ),
                    suggestionsCallback: (pattern) {
                      return placeProvider.countries.where((country) =>
                          country.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      placeProvider.selectedCountry = suggestion;
                      placeProvider.notifyListeners();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a country';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        labelText: 'Continent',
                        filled: true,
                        fillColor: Colors.orange[50], // Light orange background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        labelStyle: TextStyle(color: Colors.orange[700]), // Darker orange label
                      ),
                      controller: TextEditingController(text: placeProvider.selectedContinent),
                    ),
                    suggestionsCallback: (pattern) {
                      return placeProvider.continents.where((continent) =>
                          continent.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      placeProvider.selectedContinent = suggestion;
                      placeProvider.notifyListeners();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a continent';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Activities',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: placeProvider.availableActivities.map((activity) {
                      return ChoiceChip(
                        label: Text(activity),
                        selected: placeProvider.selectedActivities.contains(activity),
                        onSelected: (selected) {
                          placeProvider.toggleActivity(activity);
                        },
                        selectedColor: Colors.orangeAccent,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: placeProvider.newActivityController,
                          decoration: InputDecoration(
                            labelText: 'Add New Activity',
                            filled: true,
                            fillColor: Colors.orange[50], // Light orange background
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: TextStyle(color: Colors.orange[700]), // Darker orange label
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          final newActivity = placeProvider.newActivityController.text.trim();
                          if (newActivity.isNotEmpty) {
                            placeProvider.addActivity(newActivity);
                            placeProvider.newActivityController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (placeProvider.formKey.currentState!.validate()) {
                        placeProvider.submitForm(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.orange[50], // Light orange background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Colors.orange[700]), // Darker orange label
      ),
      validator: validator,
    );
  }
}

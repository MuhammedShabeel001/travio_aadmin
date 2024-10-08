import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:travio_admin/view/widgets/global/custom_loading.dart';
import '../../../../controller/place_provider.dart';
import '../../../../utils/consts/constants.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Form(
                  key: placeProvider.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        buildTextField(
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
                        buildTextField(
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
                              fillColor: Colors.orange[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              labelStyle: TextStyle(color: Colors.orange[700]),
                            ),
                            controller: placeProvider.countryController,
                          ),
                          suggestionsCallback: (pattern) {
                            return countries.where((country) => country
                                .toLowerCase()
                                .contains(pattern.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            placeProvider.countryController.text = suggestion;
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
                              fillColor: Colors.orange[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              labelStyle: TextStyle(color: Colors.orange[700]),
                            ),
                            controller: placeProvider.continentController,
                          ),
                          suggestionsCallback: (pattern) {
                            return continents.where((continent) => continent
                                .toLowerCase()
                                .contains(pattern.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            placeProvider.continentController.text = suggestion;
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
                          children:
                              placeProvider.availableActivities.map((activity) {
                            return ChoiceChip(
                              label: Text(activity),
                              selected: placeProvider.selectedActivities
                                  .contains(activity),
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
                                  fillColor: Colors.orange[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  labelStyle:
                                      TextStyle(color: Colors.orange[700]),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                final newActivity = placeProvider
                                    .newActivityController.text
                                    .trim();
                                if (newActivity.isNotEmpty) {
                                  placeProvider.addActivity(newActivity);
                                  placeProvider.newActivityController.clear();
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Images',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...placeProvider.images
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final image = entry.value;
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Image.file(
                                          image,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: -5,
                                        top: -10,
                                        child: IconButton(
                                          icon: const Icon(Icons.remove_circle,
                                              color: Colors.red),
                                          onPressed: () {
                                            placeProvider.removeImage(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(style: BorderStyle.solid)),
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.add_a_photo),
                                      onPressed: () async {
                                        await placeProvider.pickImages();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (placeProvider.formKey.currentState?.validate() ?? false) {
                  if (placeProvider.selectedActivities.isEmpty) {
                    BotToast.showText(
                        text: 'Please select at least one activity.');

                    return;
                  }

                  if (placeProvider.images.isEmpty) {
                    BotToast.showText(text: 'Please select at least one image');

                    return;
                  }

                  placeProvider.submitForm();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: placeProvider.isSubmitting
                  ? const CustomLoading()
                  : const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.orange[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Colors.orange[700]),
      ),
      validator: validator,
    );
  }
}

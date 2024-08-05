import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/controller/package_provider.dart';
import 'package:file_picker/file_picker.dart';

class AddTripPackagePage extends StatelessWidget {
  const AddTripPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip Package'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: tripPackageProvider.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: tripPackageProvider.nameController,
                    decoration: InputDecoration(
                      labelText: 'Package Name',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the package name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
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
                        labelText: 'Initial Location',
                        filled: true,
                        fillColor: Colors.orange[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        labelStyle: TextStyle(color: Colors.orange[700]),
                      ),
                      controller: tripPackageProvider.sourceLocationController,
                    ),
                    suggestionsCallback: (pattern) async {
                      return await tripPackageProvider.getSuggestions(pattern, 'initial');
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      tripPackageProvider.sourceLocationController.text = suggestion;
                      tripPackageProvider.notifyListeners();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an initial location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        labelText: 'Final Location',
                        filled: true,
                        fillColor: Colors.orange[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        labelStyle: TextStyle(color: Colors.orange[700]),
                      ),
                      controller: tripPackageProvider.destinationLocationController,
                    ),
                    suggestionsCallback: (pattern) async {
                      return await tripPackageProvider.getSuggestions(pattern, 'final');
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      tripPackageProvider.destinationLocationController.text = suggestion;
                      tripPackageProvider.notifyListeners();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a final location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.startDateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: tripPackageProvider.selectedStartDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null && selectedDate != tripPackageProvider.selectedStartDate) {
                        tripPackageProvider.selectedStartDate = selectedDate;
                        tripPackageProvider.startDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                        tripPackageProvider.notifyListeners();
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.endDateController,
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: tripPackageProvider.selectedEndDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null && selectedDate != tripPackageProvider.selectedEndDate) {
                        tripPackageProvider.selectedEndDate = selectedDate;
                        tripPackageProvider.endDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                        tripPackageProvider.notifyListeners();
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.daysController,
                    decoration: InputDecoration(
                      labelText: 'Number of Days',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of days';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.nightsController,
                    decoration: InputDecoration(
                      labelText: 'Number of Nights',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of nights';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.morningsController,
                    decoration: InputDecoration(
                      labelText: 'Number of Mornings',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of mornings';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.realPriceController,
                    decoration: InputDecoration(
                      labelText: 'Real Price',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the real price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: tripPackageProvider.offerPriceController,
                    decoration: InputDecoration(
                      labelText: 'Offer Price',
                      filled: true,
                      fillColor: Colors.orange[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.orange[700]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the offer price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Image Upload Fields
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
                          ...tripPackageProvider.images.asMap().entries.map((entry) {
                            final index = entry.key;
                            final image = entry.value;
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Image.file(
                                    image,
                                    width: 100, // Fixed width for images
                                    height: 100, // Fixed height for images
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: -5,
                                  top: -10 ,
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                                    onPressed: () {
                                     tripPackageProvider.removeImage(index);
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                style: BorderStyle.solid
                              )
                            ),
                            height: 100,
                            width: 100,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add_a_photo),
                                onPressed: () async {
                                  await tripPackageProvider.pickImages();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  Text('Activities:'),
                  Wrap(
                    spacing: 8.0,
                    children: ['Activity1', 'Activity2', 'Activity3'].map((activity) {
                      return ChoiceChip(
                        label: Text(activity),
                        selected: tripPackageProvider.selectedActivities.contains(activity),
                        onSelected: (selected) {
                          tripPackageProvider.toggleActivity(activity);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),

                  ElevatedButton(
                    onPressed: tripPackageProvider.isLoading ? null : () async {
                      await tripPackageProvider.addTripPackage(context);
                      if (!tripPackageProvider.isLoading) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Package added successfully!')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: tripPackageProvider.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Add Package'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

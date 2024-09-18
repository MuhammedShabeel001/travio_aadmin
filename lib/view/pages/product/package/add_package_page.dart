import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/view/pages/product/package/planning_trip_page.dart';
import 'package:travio_admin/view/widgets/global/text_field.dart';
import '../../../../controller/package_provider.dart';

class TripPackageDetailsPage extends StatelessWidget {
  const TripPackageDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        title: const Text('Add Package Details'),
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
                  key: tripPackageProvider.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextForm(
                          tripPackageProvider: tripPackageProvider,
                          controller: tripPackageProvider.nameController,
                          label: 'Package Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a package name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextForm(
                          tripPackageProvider: tripPackageProvider,
                          controller: tripPackageProvider.descriptionController,
                          label: 'Description',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                          minLines: 1,
                          maxLines: 5,
                        ),
                        const SizedBox(height: 16),
                        TypeAheadFormField<String>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: tripPackageProvider.countryController,
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
                          ),
                          suggestionsCallback: (pattern) {
                            return tripPackageProvider.availableCountries.where(
                              (country) => country
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()),
                            );
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            tripPackageProvider
                                .toggleCountrySelection(suggestion);
                            tripPackageProvider.countryController.clear();
                          },
                          hideOnEmpty: true,
                          noItemsFoundBuilder: (context) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No Countries Found',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: tripPackageProvider.selectedCountries
                              .map((country) {
                            return Chip(
                              label: Text(country),
                              onDeleted: () => tripPackageProvider
                                  .toggleCountrySelection(country),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        CustomTextForm(
                          tripPackageProvider: tripPackageProvider,
                          controller: tripPackageProvider.totalDaysController,
                          label: 'Total days',
                          inputType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              tripPackageProvider
                                  .updateTotalDays(int.parse(value));
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the total number of days';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Flexible(
                              child: CustomTextForm(
                                tripPackageProvider: tripPackageProvider,
                                controller: tripPackageProvider.daysController,
                                label: 'Days',
                                inputType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  int days = int.parse(value);
                                  int totalDays = int.tryParse(
                                          tripPackageProvider
                                              .totalDaysController.text) ??
                                      0;
                                  if (days > totalDays) {
                                    return 'Days cannot be greater than total days';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: CustomTextForm(
                                tripPackageProvider: tripPackageProvider,
                                controller:
                                    tripPackageProvider.nightsController,
                                label: 'Nights',
                                inputType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  int nights = int.parse(value);
                                  int totalDays = int.tryParse(
                                          tripPackageProvider
                                              .totalDaysController.text) ??
                                      0;
                                  if (nights > totalDays) {
                                    return 'Nights cannot be greater than total days';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Activities',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                                child: CustomTextForm(
                              tripPackageProvider: tripPackageProvider,
                              controller:
                                  tripPackageProvider.newActivityController,
                              label: 'Add New Activity',
                            )),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                final newActivity = tripPackageProvider
                                    .newActivityController.text
                                    .trim();
                                if (newActivity.isNotEmpty) {
                                  tripPackageProvider.addActivity(newActivity);
                                  tripPackageProvider.newActivityController
                                      .clear();
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Wrap(
                          spacing: 8.0,
                          children: tripPackageProvider.availableActivities
                              .map((activity) {
                            return ChoiceChip(
                              label: Text(activity),
                              selected: tripPackageProvider.selectedActivities
                                  .contains(activity),
                              onSelected: (selected) {
                                tripPackageProvider.toggleActivity(activity);
                              },
                              selectedColor: Colors.orangeAccent,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Transport Options',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: tripPackageProvider.transportOptions
                              .map((transport) {
                            return ChoiceChip(
                              label: Text(transport),
                              selected: tripPackageProvider
                                  .selectedTransportOptions
                                  .contains(transport),
                              onSelected: (selected) {
                                tripPackageProvider.toggleTransport(transport);
                              },
                              selectedColor: Colors.orangeAccent,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Flexible(
                                child: CustomTextForm(
                              tripPackageProvider: tripPackageProvider,
                              controller:
                                  tripPackageProvider.realPriceController,
                              label: 'Real Price',
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            )),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                                child: CustomTextForm(
                              tripPackageProvider: tripPackageProvider,
                              controller:
                                  tripPackageProvider.offerPriceController,
                              label: 'Offer Price',
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            )),
                          ],
                        ),
                        const SizedBox(height: 16.0),
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
                if (tripPackageProvider.formKey.currentState?.validate() ??
                    false) {
                  if (tripPackageProvider.selectedActivities.isEmpty) {
                    BotToast.showText(
                        text: 'Please select at least one activity.');

                    return;
                  }

                  if (tripPackageProvider.selectedTransportOptions.isEmpty) {
                    BotToast.showText(
                        text: 'Please select at least  one transport option.');

                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TripPackagePlanningPage()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

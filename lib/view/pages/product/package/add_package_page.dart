import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/view/pages/product/package/planning_trip_page.dart';
import 'package:travio_admin/view/widgets/global/text_field.dart';
import '../../../../controller/package_provider.dart';

class TripPackageDetailsPage extends StatelessWidget {
  const TripPackageDetailsPage({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return Scaffold(
      appBar: AppBar(
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
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                                child: CustomTextForm(
                              tripPackageProvider: tripPackageProvider,
                              controller: tripPackageProvider.nightsController,
                              label: 'Nights',
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
                // Validate the form first
                if (tripPackageProvider.formKey.currentState?.validate() ??
                    false) {
                  // Check if at least one activity is selected
                  if (tripPackageProvider.selectedActivities.isEmpty) {
                    _showSnackBar(context, 'Please select at least one activity.');
                    return;
                  }

                  // Check if at least one transport option is selected
                  if (tripPackageProvider.selectedTransportOptions.isEmpty) {
                    _showSnackBar(context, 'Please select at least one transport option.');
                    return;
                  }

                  // If all validations pass, navigate to the next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TripPackagePlanningPage()),
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

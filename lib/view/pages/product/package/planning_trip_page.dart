import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/package_provider.dart';

class TripPackagePlanningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning package'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              ...tripPackageProvider.images
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
                                        width: 100, // Fixed width for images
                                        height: 100, // Fixed height for images
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
                                          tripPackageProvider
                                              .removeImage(index);
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
                      const Text(
                        'Plan for',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Increased spacing after images
                      for (int i = 0;
                          i < tripPackageProvider.totalDays;
                          i++) ...[
                        TextFormField(
                          controller:
                              tripPackageProvider.dailyPlanningControllers[i],
                          decoration: InputDecoration(
                            labelText: ' Day ${i + 1}',
                            filled: true,
                            fillColor:
                                Colors.orange[50], // Light orange background
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.orange[700], // Darker orange label
                            ),
                          ),
                          minLines:
                              1, // Allows the text field to start with 1 line
                          maxLines: null, // Makes the text field expandable
                        ),
                        const SizedBox(
                            height: 10), // Increased spacing between fields
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Padding(padding: padding)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: tripPackageProvider.isSubmitting
                  ? null
                  : () {
                      tripPackageProvider.submitForm(context);
                    },
              child: tripPackageProvider.isSubmitting
                  ? CircularProgressIndicator()
                  : Text('Submit',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
        ],
      ),
    );
  }
}

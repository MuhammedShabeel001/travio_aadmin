import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/view/widgets/global/text_field.dart';
import '../../../../controller/package_provider.dart';
import '../../../widgets/global/custom_loading.dart';

class TripPackagePlanningPage extends StatelessWidget {
  const TripPackagePlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        title: const Text('Planning package'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        CustomTextForm(
                          tripPackageProvider: tripPackageProvider,
                          controller:
                              tripPackageProvider.dailyPlanningControllers[i],
                          label: 'Day ${i + 1}',
                          minLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                          // maxLines: ,
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
              onPressed:() {
if (tripPackageProvider.formKey.currentState?.validate() ?? false) {
   if (tripPackageProvider.images.isEmpty){
                    BotToast.showText(text: 'Please select at least one image');

                    return;
                  }
}

                      tripPackageProvider.submitForm(context);
                      // Navigator.pop(context);
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: tripPackageProvider.isSubmitting
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
}


//if (tripPackageProvider.images.isEmpty){
               //     BotToast.showText(text: 'Please select at least one image');
                //  }
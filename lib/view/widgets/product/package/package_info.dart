import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio_admin/controller/package_provider.dart';
import 'package:travio_admin/model/package_model.dart';

import '../../../../controller/edit_provider.dart';
// import 'package:travio_admin/providers/edit_package_provider.dart';

class PackageInfoWidget extends StatelessWidget {
  final TripPackageModel tripPackage;

  const PackageInfoWidget({Key? key, required this.tripPackage}) : super(key: key);

  Widget _buildEditableText(BuildContext context, String field, TextStyle style) {
    return Consumer<TripPackageProvider>(
      builder: (context, provider, child) {
        String text = provider.currentPackage?.getFieldValue(field)?.toString() ?? '';
        return GestureDetector(
          onLongPress: () async {
            await provider.showEditDialog(context, field);
            // No need to call setState or notifyListeners here, as the provider will handle that
          },
          child: Text(text, style: style),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set the current package when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripPackageProvider>(context, listen: false).setCurrentPackage(tripPackage);
    });

    return Consumer<TripPackageProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEditableText(
              context,
              'name',
              const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            _buildEditableText(
              context,
              'description',
          const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEditableText(
                context,
                'real_price',
                const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              _buildEditableText(
                context,
                'offer_price',
                const TextStyle(
                  fontSize: 28,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Daily Plan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        Consumer<TripPackageProvider>(
          builder: (context, editProvider, child) {
            Map<int, String> dailyPlan = editProvider.currentPackage?.dailyPlan ?? {};
            return Column(
              children: dailyPlan.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Day ${entry.key + 1}: ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: _buildEditableText(
                          context,
                          'daily_plan.${entry.key}',
                          const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Activities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        _buildEditableText(
          context,
          'activities',
          const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Transport Options',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Divider(),
        _buildEditableText(
          context,
          'transport_options',
          const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
 }
    );}
}
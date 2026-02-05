import 'package:boiler_error_codes/models/boiler_brand.dart';
import 'package:boiler_error_codes/views/errors_view.dart';
import 'package:boiler_error_codes/views/main_layout.dart';
import 'package:boiler_error_codes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ModelsView extends StatelessWidget {
  final BoilerBrand brand;

  const ModelsView({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: CustomAppbar(title: "${brand.name} Modelleri"),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: brand.models.length,
        itemBuilder: (context, index) {
          final model = brand.models[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  model.name.substring(0, 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              title: Text(
                model.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text("${model.errors.length} Hata Kodu"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ErrorsView(model: model),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:boiler_error_codes/models/boiler_model.dart';
import 'package:boiler_error_codes/views/main_layout.dart';
import 'package:boiler_error_codes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ErrorsView extends StatelessWidget {
  final BoilerModel model;

  const ErrorsView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: CustomAppbar(title: "${model.name} Hataları"),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: model.errors.length,
        itemBuilder: (context, index) {
          final error = model.errors[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  error.code,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                  ),
                ),
              ),
              title: Text(
                error.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "NEDEN:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(error.description),
                      const SizedBox(height: 12),
                      const Text(
                        "ÇÖZÜM:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        error.solution,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      TextButton.icon(
                        icon: const Icon(Icons.share, color: Colors.blue),
                        label: const Text("Paylaş"),
                        onPressed: () {
                          // Paylaşılacak Metin
                          final String shareText =
                              """🔧 *${error.brandName} - ${error.modelName} Arızası*\n⚠️ *Hata Kodu:* ${error.code}\n📄 *Sorun:* ${error.title} - ${error.description}\n✅ *Çözüm:* ${error.solution}""";

                          // Paylaşma penceresini aç
                          SharePlus.instance.share(
                            ShareParams(text: shareText),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:boiler_error_codes/models/boiler_brand.dart';
import 'package:boiler_error_codes/viewmodels/home_viewmodel.dart';
import 'package:boiler_error_codes/views/errors_view.dart';
import 'package:boiler_error_codes/views/main_layout.dart';
import 'package:boiler_error_codes/views/model_view.dart';
import 'package:boiler_error_codes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = HomeViewModel();
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _viewModel.initialize();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: CustomAppbar(
        // String title yerine titleWidget kullanıyoruz:
        titleWidget: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => _viewModel.search(value),
            decoration: InputDecoration(
              hintText: "Marka, model veya hata kodu ara...",
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 7,
              ), // Metni ortalar
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                        _viewModel.clearSearch();
                        setState(
                          () {},
                        ); // Çarpıya basınca ikonu güncellemek için
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } // ARAMA MODU
          if (_viewModel.isSearching) {
            return _buildSearchResults();
          } // NORMAL ANA SAYFA
          if (_viewModel.brands.isEmpty) {
            return const Center(child: Text("Veri bulunamadı"));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: _viewModel.brands.length,
            itemBuilder: (context, index) {
              final brand = _viewModel.brands[index];
              return _buildBrandCard(brand);
            },
          );
        },
      ),
    );
  } // Marka Kartı Tasarımı

  Widget _buildBrandCard(BoilerBrand brand) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ModelsView(brand: brand)),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_fire_department,
              size: 40,
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            Text(
              brand.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              "${brand.models.length} Model",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  } // Arama Sonuçları Listesi

  Widget _buildSearchResults() {
    if (_viewModel.foundBrands.isEmpty &&
        _viewModel.foundModels.isEmpty &&
        _viewModel.foundErrors.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.grey),
            SizedBox(height: 10),
            Text("Sonuç bulunamadı.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        // --- MARKALAR ---
        if (_viewModel.foundBrands.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              "Markalar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.orange,
              ),
            ),
          ),
          ..._viewModel.foundBrands.map(
            (brand) => Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.apartment, color: Colors.orange),
                ),
                title: Text(
                  brand.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModelsView(brand: brand),
                  ),
                ),
              ),
            ),
          ),
        ],

        // --- MODELLER (Artık Hangi Markaya Ait Olduğu Yazıyor) ---
        if (_viewModel.foundModels.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              "Modeller",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
          ..._viewModel.foundModels.map(
            (model) => Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.device_thermostat,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  model.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // BURASI YENİ: Marka ismini gösteriyoruz
                subtitle: Text(
                  "Marka: ${model.brandName}",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ErrorsView(model: model),
                  ),
                ),
              ),
            ),
          ),
        ],

        // --- HATA KODLARI (Artık Hangi Marka ve Modele Ait Olduğu Yazıyor) ---
        if (_viewModel.foundErrors.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              "Hata Kodları",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ),
          ..._viewModel.foundErrors.map(
            (error) => Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8),
              color: Colors.red.shade50,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 24,
                  child: Text(
                    error.code,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Text(
                  error.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // BURASI YENİ: Marka ve Model ismini gösteriyoruz
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      error.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Text(
                        "${error.brandName} > ${error.modelName}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Row(
                        children: [
                          const Icon(Icons.warning_amber, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text("${error.code} - ${error.title}"),
                          ),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Text(
                              "Cihaz: ${error.brandName} ${error.modelName}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const Divider(),
                            const Text(
                              "NEDEN:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(error.description),
                            const SizedBox(height: 15),
                            const Text(
                              "ÇÖZÜM:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(error.solution),
                          ],
                        ),
                      ),
                      actions: [
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
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text("Kapat"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}

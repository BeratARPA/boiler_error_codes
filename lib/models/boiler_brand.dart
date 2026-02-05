import 'boiler_model.dart';

class BoilerBrand {
  final String name;
  final List<BoilerModel> models;

  BoilerBrand({required this.name, required this.models});

  factory BoilerBrand.fromJson(Map<String, dynamic> json) {
    String currentBrandName = json['Name'] ?? "";

    return BoilerBrand(
      name: currentBrandName,
      // BoilerModel üretirken marka ismini aşağı gönderiyoruz
      models: (json['Models'] as List)
          .map((x) => BoilerModel.fromJson(x, currentBrandName))
          .toList(),
    );
  }
}

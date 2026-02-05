import 'error_item.dart';

class BoilerModel {
  final String name;
  final List<ErrorItem> errors;
  final String? brandName;

  BoilerModel({required this.name, required this.errors, this.brandName});

  // brandName parametresini buraya ekledik
  factory BoilerModel.fromJson(Map<String, dynamic> json, String brand) {
    String currentModelName = json['Name'] ?? "";

    return BoilerModel(
      name: currentModelName,
      brandName: brand,
      // ErrorItem üretirken marka ve model bilgisini aşağı gönderiyoruz
      errors: (json['Errors'] as List)
          .map((x) => ErrorItem.fromJson(x, brand, currentModelName))
          .toList(),
    );
  }
}

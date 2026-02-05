class ErrorItem {
  final String code;
  final String title;
  final String description;
  final String solution;
  final String? brandName;
  final String? modelName;

  ErrorItem({
    required this.code,
    required this.title,
    required this.description,
    required this.solution,
    this.brandName,
    this.modelName,
  });

  // brandName ve modelName parametrelerini buraya ekledik
  factory ErrorItem.fromJson(
    Map<String, dynamic> json,
    String brand,
    String model,
  ) {
    return ErrorItem(
      code: json['Code'] ?? "",
      title: json['Title'] ?? "",
      description: json['Description'] ?? "",
      solution: json['Solution'] ?? "",
      brandName: brand,
      modelName: model,
    );
  }
}

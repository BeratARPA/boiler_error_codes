import 'error_item.dart';

class SearchResult {
  final String brandName;
  final String modelName;
  final ErrorItem error;

  SearchResult({
    required this.brandName,
    required this.modelName,
    required this.error,
  });
}
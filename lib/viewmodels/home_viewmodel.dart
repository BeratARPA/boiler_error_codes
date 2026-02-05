import 'package:boiler_error_codes/models/boiler_brand.dart';
import 'package:boiler_error_codes/models/boiler_model.dart';
import 'package:boiler_error_codes/models/error_item.dart';
import 'package:boiler_error_codes/services/boiler_data_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final BoilerDataService _dataService = BoilerDataService();

  // Ana Liste
  List<BoilerBrand> _brands = [];
  bool _isLoading = true;

  // Arama Sonuç Listeleri
  List<BoilerBrand> _foundBrands = [];
  List<BoilerModel> _foundModels = [];
  List<ErrorItem> _foundErrors = [];
  bool _isSearching = false;

  // Getterlar
  List<BoilerBrand> get brands => _brands;
  bool get isLoading => _isLoading;

  // Arama Getterlar
  bool get isSearching => _isSearching;
  List<BoilerBrand> get foundBrands => _foundBrands;
  List<BoilerModel> get foundModels => _foundModels;
  List<ErrorItem> get foundErrors => _foundErrors;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    _brands = await _dataService.getAllBrands();
    _isLoading = false;
    notifyListeners();
  }

  // Arama Fonksiyonu
  void search(String query) async {
    if (query.isEmpty) {
      _isSearching = false;
      _foundBrands.clear();
      _foundModels.clear();
      _foundErrors.clear();
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners(); // UI'ı arama moduna geçir

    // Servisteki metodları kullanarak paralel arama yap
    final results = await Future.wait([
      _dataService.searchBrands(query),
      _dataService.searchModelsGlobal(query),
      _dataService.searchErrorsGlobal(query),
    ]);

    _foundBrands = results[0] as List<BoilerBrand>;
    _foundModels = results[1] as List<BoilerModel>;
    _foundErrors = results[2] as List<ErrorItem>;

    notifyListeners();
  }

  // Aramayı temizle
  void clearSearch() {
    _isSearching = false;
    _foundBrands.clear();
    _foundModels.clear();
    _foundErrors.clear();
    notifyListeners();
  }
}

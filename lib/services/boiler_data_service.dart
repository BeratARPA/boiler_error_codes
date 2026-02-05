import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:boiler_error_codes/models/boiler_brand.dart';
import 'package:boiler_error_codes/models/boiler_model.dart';
import 'package:boiler_error_codes/models/error_item.dart';

class BoilerDataService {
  // Singleton Pattern: Servisin uygulama genelinde tek bir örneği olsun.
  static final BoilerDataService _instance = BoilerDataService._internal();
  factory BoilerDataService() => _instance;
  BoilerDataService._internal();

  static const String _jsonPath = 'assets/datas.json';

  // Veriyi hafızada tutacağımız liste (Cache)
  List<BoilerBrand>? _cachedBrands;

  /// -------------------------------------------------------------------------
  /// 1. BAŞLATMA VE YÜKLEME METOTLARI
  /// -------------------------------------------------------------------------

  /// Veriyi JSON'dan okur ve hafızaya yazar.
  /// Eğer veri zaten yüklenmişse tekrar okuma yapmaz (Performans için).
  Future<void> initializeData() async {
    if (_cachedBrands != null && _cachedBrands!.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString(_jsonPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedBrands = jsonList.map((e) => BoilerBrand.fromJson(e)).toList();
    } catch (e) {
      print("Veri yükleme hatası: $e");
      _cachedBrands = [];
    }
  }

  /// Tüm markaları getirir. (Veri yüklenmemişse önce yükler)
  Future<List<BoilerBrand>> getAllBrands() async {
    await initializeData();
    return _cachedBrands ?? [];
  }

  /// -------------------------------------------------------------------------
  /// 2. TEKİL VERİ GETİRME (GET BY ID/NAME)
  /// -------------------------------------------------------------------------

  /// İsme göre spesifik bir marka getirir. (Örn: "DemirDöküm")
  Future<BoilerBrand?> getBrandByName(String brandName) async {
    await initializeData();
    try {
      return _cachedBrands?.firstWhere(
        (brand) => brand.name.toLowerCase() == brandName.toLowerCase(),
      );
    } catch (e) {
      return null; // Bulunamazsa null döner
    }
  }

  /// Bir markanın içindeki spesifik bir modeli getirir. (Örn: DemirDöküm -> Nitromix)
  Future<BoilerModel?> getModelByName(
    String brandName,
    String modelName,
  ) async {
    final brand = await getBrandByName(brandName);
    if (brand == null) return null;

    try {
      return brand.models.firstWhere(
        (model) => model.name.toLowerCase() == modelName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Spesifik bir hatayı bulur. (Örn: Nitromix -> F28)
  Future<ErrorItem?> getErrorByCode(
    String brandName,
    String modelName,
    String errorCode,
  ) async {
    final model = await getModelByName(brandName, modelName);
    if (model == null) return null;

    try {
      return model.errors.firstWhere(
        (error) => error.code.toLowerCase() == errorCode.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// -------------------------------------------------------------------------
  /// 3. LİSTELEME METOTLARI (ALT KATEGORİLER)
  /// -------------------------------------------------------------------------

  /// Bir markaya ait tüm modelleri getirir.
  Future<List<BoilerModel>> getModelsByBrand(String brandName) async {
    final brand = await getBrandByName(brandName);
    return brand?.models ?? [];
  }

  /// Bir modele ait tüm hataları getirir.
  Future<List<ErrorItem>> getErrorsByModel(
    String brandName,
    String modelName,
  ) async {
    final model = await getModelByName(brandName, modelName);
    return model?.errors ?? [];
  }

  /// -------------------------------------------------------------------------
  /// 4. ARAMA (SEARCH) METOTLARI
  /// -------------------------------------------------------------------------

  /// Markalar içinde arama yapar.
  /// Örn: "Demir" yazınca "DemirDöküm" gelir.
  Future<List<BoilerBrand>> searchBrands(String query) async {
    await initializeData();
    if (query.isEmpty) return _cachedBrands ?? [];

    return _cachedBrands!
        .where(
          (brand) => brand.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  /// Modeller içinde arama yapar.
  /// Örn: "Nitro" yazınca tüm markalardaki "Nitromix", "Nitron" modelleri gelir.
  Future<List<BoilerModel>> searchModelsGlobal(String query) async {
    await initializeData();
    List<BoilerModel> results = [];
    if (query.isEmpty) return [];

    for (var brand in _cachedBrands!) {
      var matches = brand.models.where(
        (model) => model.name.toLowerCase().contains(query.toLowerCase()),
      );
      results.addAll(matches);
    }
    return results;
  }

  /// Hata kodlarında veya açıklamalarında arama yapar.
  /// Örn: "F4" veya "Ateşleme" yazınca eşleşen hataları getirir.
  /// Not: Hatanın hangi modele ait olduğunu bilmek için UI tarafında düzenleme gerekebilir.
  Future<List<ErrorItem>> searchErrorsGlobal(String query) async {
    await initializeData();
    List<ErrorItem> results = [];
    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase();

    for (var brand in _cachedBrands!) {
      for (var model in brand.models) {
        var matches = model.errors.where((error) {
          return error.code.toLowerCase().contains(
                lowerQuery,
              ) || // Koda göre ara (F28)
              error.title.toLowerCase().contains(
                lowerQuery,
              ) || // Başlığa göre ara (Ateşleme)
              error.description.toLowerCase().contains(
                lowerQuery,
              ); // Açıklamaya göre ara
        });
        results.addAll(matches);
      }
    }
    return results;
  }
}

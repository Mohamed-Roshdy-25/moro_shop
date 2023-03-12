import 'package:moro_shop/data/network/error_handler.dart';
import 'package:moro_shop/data/responses/responses.dart';

const cacheCategoriesKey = "Cache_Categories_Key";
const cacheCategoryProductsKey = "Cache_Category_Products_Key";
const cacheProfileKey = "Cache_Profile_Key";
const cacheHomeInterval = 60 * 1000;

abstract class LocalDataSource {
  Future<CategoriesResponse> getCategoriesResponse();
  Future<void> saveCategoriesToCache(CategoriesResponse categoriesResponse);

  Future<CategoryAllDataResponse> getCategoryProductsResponse(int categoryId);
  Future<void> saveCategoryProductsToCache(
      CategoryAllDataResponse categoryAllDataResponse,int categoryId);

  Future<ProfileResponse> getProfileResponse();
  Future<void> saveProfileToCache(ProfileResponse profileResponse);

  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<CategoriesResponse> getCategoriesResponse() async {
    CachedItem? cachedData = cacheMap[cacheCategoriesKey];

    if (cachedData != null && cachedData.isValid(cacheHomeInterval)) {
      return cachedData.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveCategoriesToCache(
      CategoriesResponse categoriesResponse) async {
    cacheMap[cacheCategoriesKey] = CachedItem(categoriesResponse);
  }

  @override
  Future<CategoryAllDataResponse> getCategoryProductsResponse(int categoryId) async {
    CachedItem? cachedData = cacheMap['$categoryId'];
    if (cachedData != null && cachedData.isValid(cacheHomeInterval)) {
      return cachedData.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveCategoryProductsToCache(
      CategoryAllDataResponse categoryAllDataResponse,int categoryId) async {
    cacheMap['$categoryId'] = CachedItem(categoryAllDataResponse);
  }

  @override
  Future<ProfileResponse> getProfileResponse() async {
    CachedItem? cachedData = cacheMap[cacheProfileKey];

    if (cachedData != null && cachedData.isValid(cacheHomeInterval)) {
      return cachedData.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveProfileToCache(
      ProfileResponse profileResponse) async {
    cacheMap[cacheProfileKey] = CachedItem(profileResponse);
  }


  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;

  int cachedTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTime - cachedTime <= expirationTime;

    return isValid;
  }
}

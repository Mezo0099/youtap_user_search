import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_search_test/core/network/http.dart';
import 'package:user_search_test/data/registrar.dart';
import 'package:user_search_test/presentation/registrar/feature_registrar.dart';

final sl = GetIt.instance;

class Dependencies {
  static Future<void> init() async {
    //#region Common Dependencies

    sl.registerLazySingleton<Connectivity>(() => Connectivity());

    var sharedPreferences = await SharedPreferences.getInstance();

    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerFactory<Http>(() => HttpImpl());

    RepositoryRegistrar.init(sl);

    FeatureRegistrar.init(sl);
    //#endregion
  }
}

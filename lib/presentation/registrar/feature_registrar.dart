import 'package:get_it/get_it.dart';

import 'feature_dependencies/home_dep.dart';

class FeatureRegistrar {
  static void init(GetIt sl) {
    userDependencies(sl);
  }
}

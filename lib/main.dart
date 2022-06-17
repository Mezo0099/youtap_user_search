import 'package:flutter/material.dart';
import 'package:user_search_test/core/app.dart';

import 'core/startup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies.init();

  runApp(const MyApp());
}

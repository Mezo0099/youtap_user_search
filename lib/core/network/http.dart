import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:user_search_test/core/error_handler/errors.dart';
import 'package:user_search_test/core/startup.dart';

abstract class Http {
  Future<http.Response> get({
    required String url,
  });

  String get getBaseUrl;
}

class HttpImpl implements Http {
  final Connectivity _connectivity = sl();

  @override
  Future<http.Response> get({
    required String url,
  }) async {
    try {
      if (!(await _isConnected())) {
        throw Exception();
      }
      var finalUrl = Uri.parse(getBaseUrl);

      log("Getting From: $finalUrl");
      var result = await http.get(
        finalUrl,
        headers: _getHeaders(),
      );

      return result;
    } catch (e) {
      throw NoInternetException("No Internet Connection");
    }
  }

  @override
  String get getBaseUrl => "https://jsonplaceholder.typicode.com/users";

  static Map<String, String> _getHeaders() {
    var headers = {'Content-Type': 'application/json-patch+json'};
    return headers;
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}

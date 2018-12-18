import 'dart:convert';

import 'package:http/http.dart' as http;
import 'version.dart';

class MPRestClient {
  final String BASE_URL = 'api.mercadopago.com';
  final String MIME_JSON = 'application/json';
  final String MIME_FORM = 'application/x-www-form-urlencoded';

  MPRestClient();

  String get _makeAgent => 'MercadoPago Dart SDK v${SDK_VERSION}';

  String _makeURL(uri, [Map<String, String> params]) {
    return Uri.https(BASE_URL, uri, params).toString();
  }

  Map<String, String> _makeHeaders({
    Map<String, String> extraHeaders,
  }) {
    return {
      'User-Agent': this._makeAgent,
      'Accept': this.MIME_JSON,
    }
      ..addAll(extraHeaders);
  }

  Future<Map<String, dynamic>> get(uri, [
    Map<String, String> params,
  ]) async {
    var response = await http.get(this._makeURL(uri, params),
        headers: this._makeHeaders());

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }

  Future<Map<String, dynamic>> post(uri, {
    Map<String, dynamic> data,
    Map<String, String> params,
    String contentType,
  }) async {
    var response = await http.post(this._makeURL(uri, params),
        headers: this._makeHeaders(
            extraHeaders: {'Content-type': contentType ?? this.MIME_JSON}),
        body: json.encode(data));

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }

  Future<Map<String, dynamic>> put(uri, {
    Map<String, dynamic> data,
    Map<String, String> params,
    String contentType,
  }) async {
    var response = await http.put(this._makeURL(uri, params),
        headers: this._makeHeaders(
            extraHeaders: {'Content-type': contentType ?? this.MIME_JSON}),
        body: json.encode(data));

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }

  Future<Map<String, dynamic>> delete(uri, {
    Map<String, String> params,
  }) async {
    var response = await http.delete(this._makeURL(uri, params),
        headers: this._makeHeaders());

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }
}

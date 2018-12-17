import 'package:http/http.dart' as http;

class MPRestClient {
  final String _API_BASE_URL = 'api.mercadopago.com';
  final String _USER_AGENT = 'MercadoPago Dart SDK ';
  final String _MIME_JSON = 'application/json';
  String _version;

  MPRestClient({version}) {
    this._version = version;
  }

  String get _makeAgent => _USER_AGENT + _version;

  String _makeURL(uri, [Map<String, String> params]) {
    return Uri.https(_API_BASE_URL, uri, params).toString();
  }

  Map<String, String> _makeHeaders() {
    return {
      'User-Agent': this._makeAgent,
      'Accept': this._MIME_JSON,
      'Content-type': this._MIME_JSON,
    };
  }

  Future<http.Response> get(uri, [Map<String, String> params]) {
    return http.get(this._makeURL(uri, params), headers: this._makeHeaders());
  }

  Future<http.Response> post(uri,
      {Map<String, String> data, Map<String, String> params}) {
    return http.post(this._makeURL(uri, params),
        headers: this._makeHeaders(), body: data);
  }

  Future<http.Response> put(uri,
      {Map<String, String> data, Map<String, String> params}) {
    return http.put(this._makeURL(uri, params),
        headers: this._makeHeaders(), body: data);
  }

  Future<http.Response> delete(uri,
      {Map<String, String> data, Map<String, String> params}) {
    return http.delete(this._makeURL(uri, params),
        headers: this._makeHeaders());
  }
}

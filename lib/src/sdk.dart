import 'dart:async';
import 'dart:core';

import 'rest_client.dart';

class MP {
  String? _client_id;
  String? _client_secret;

  String? _access_token;
  MPRestClient _restClient = MPRestClient();

  MP(this._client_id, this._client_secret);

  MP.fromAccessToken(this._access_token);

  /// Set access token
  /// return void
  void setAccessToken(String token) {
    this._access_token = token;
  }

  /// Get access token
  /// return Future<String>
  Future<String?> getAccessToken() async {
    if (this._access_token != null) {
      return this._access_token;
    }

    Map<String, String?> data_app_client = {
      'client_id': this._client_id,
      'client_secret': this._client_secret,
      'grant_type': 'client_credentials',
    };

    var access_data = await this._restClient.post('/oauth/token',
        data: data_app_client, contentType: _restClient.MIME_FORM);

    if (access_data['status'] == 200) {
      this._access_token = access_data['response']['access_token'];
      return this._access_token;
    }
    return null;
  }

  Future<Map<String, String>?> _getAccessTokenParam() async {
    String? access_token = await this.getAccessToken();
    return access_token != null ? {'access_token': access_token} : null;
  }

  /// Get information for specific payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> getPayment(String id) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this._restClient.get('/v1/payments/${id}', params);
  }

  /// Get information for specific authorized payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> getAuthorizedPayment(String id) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this._restClient.get('/authorized_payments/${id}', params);
  }

  /// Refund accredited payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> refundPayment(String id) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this
        ._restClient
        .post('/v1/payments/${id}/refunds', params: params, data: {});
  }

  /// Cancel pending payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> cancelPayment(String id) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this._restClient.put('/v1/payments/${id}',
        params: params, data: {"status": "cancelled"});
  }

  /// Search payments according to filters, with pagination
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> searchPayment(Map<String, String> filters,
      {int offset = 0, int limit = 0}) async {
    Map<String, String>? params = await _getAccessTokenParam();
    if (params != null) filters.addAll(params);
    filters..addAll({'offset': '$offset'})..addAll({'limit': '$limit'});
    return this._restClient.get('/v1/payments/search', filters);
  }

  /// Create a checkout preference
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> createPreference(
      Map<String, dynamic> preference) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this
        ._restClient
        .post('/checkout/preferences', params: params, data: preference);
  }

  /// Update a checkout preference
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> updatePreference(
      String id, Map<String, dynamic> preference) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this
        ._restClient
        .put('/checkout/preferences/${id}', params: params, data: preference);
  }

  /// Get a checkout preference
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> getPreference(String id) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this._restClient.get('/checkout/preferences/${id}', params);
  }

  /// Create a preapproval payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> createPreapprovalPayment(
      Map<String, dynamic> payment) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this
        ._restClient
        .post('/preapproval/', params: params, data: payment);
  }

  /// Get a preapproval payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> getPreapprovalPayment(String id) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this._restClient.get('/preapproval/${id}', params);
  }

  /// Update a preapproval payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> updatePreapprovalPayment(
      String id, Map<String, dynamic> payment) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this
        ._restClient
        .put('/preapproval/${id}', params: params, data: payment);
  }

  /// Cancel preapproval payment
  /// return Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> cancelPreapprovalPayment(String id) async {
    Map<String, String>? params = await _getAccessTokenParam();
    return this._restClient.put('/preapproval/${id}',
        params: params, data: {"status": "cancelled"});
  }

  /// Generic resource get
  /// Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> get(
    String uri, {
    Map<String, String>? params,
    bool authenticate = true,
  }) async {
    Map<String, String> extras = {};
    if (authenticate) {
      Map<String, String>? pToken = await _getAccessTokenParam();
      if (pToken != null) extras..addAll(pToken);
    }
    if (params != null) extras..addAll(params);
    return this._restClient.get(uri, extras);
  }

  /// Generic resource post
  /// Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> post(
    String uri, {
        Map<String, dynamic> data = const {},
        Map<String, String>? params,
      }) async {
    Map<String, String> extras = {};
    Map<String, String>? pToken = await _getAccessTokenParam();
    if (pToken != null) extras..addAll(pToken);
    if (params != null) extras..addAll(params);
    return this._restClient.post(uri, data: data, params: extras);
  }

  /// Generic resource put
  /// Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> put(
    String uri, {
        Map<String, dynamic> data = const {},
        Map<String, String>? params,
      }) async {
    Map<String, String> extras = {};
    Map<String, String>? pToken = await _getAccessTokenParam();
    if (pToken != null) extras..addAll(pToken);
    if (params != null) extras..addAll(params);
    return this._restClient.put(uri, data: data, params: extras);
  }

  /// Generic resource delete
  /// Future<Map<String, dynamic>>
  Future<Map<String, dynamic>> delete(
    String uri, {
        Map<String, String>? params,
      }) async {
    Map<String, String> extras = {};
    Map<String, String>? pToken = await _getAccessTokenParam();
    if (pToken != null) extras..addAll(pToken);
    if (params != null) extras..addAll(params);
    return this._restClient.delete(uri, params: extras);
  }
}

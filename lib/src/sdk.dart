import 'rest_client.dart';

class MP {
  final String _client_id;
  final String _client_secret;

  String _access_token;
  MPRestClient _restClient;

  MP(this._client_id, this._client_secret) {
    _restClient = MPRestClient();
  }

  Future<String> getAccessToken() async {
    if (this._access_token != null && !this._access_token.isEmpty) {
      return this._access_token;
    }

    Map<String, String> data_app_client = {
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

  Future<Map<String, dynamic>> getPayment(String id) async {
    final String access_token = await this.getAccessToken();
    return await this
        ._restClient
        .get('/v1/payments/${id}', {'access_token': access_token});
  }

  Future<Map<String, dynamic>> getAuthorizedPayment(String id) async {
    final String access_token = await this.getAccessToken();
    return await this
        ._restClient
        .get('/authorized_payments/${id}', {'access_token': access_token});
  }

  Future<Map<String, dynamic>> refundPayment(String id) async {
    final String access_token = await this.getAccessToken();
    return await this._restClient.post('/v1/payments/${id}/refunds',
        params: {'access_token': access_token}, data: {});
  }

  Future<Map<String, dynamic>> cancelPayment(String id) async {
    final String access_token = await this.getAccessToken();
    return await this._restClient.put('/v1/payments/${id}',
        params: {'access_token': access_token}, data: {"status": "cancelled"});
  }

  Future<Map<String, dynamic>> searchPayment(Map<String, dynamic> filters,
      {int offset: 0, int limit: 0}) async {
    final String access_token = await this.getAccessToken();

    filters..addAll({'access_token': access_token})..addAll(
        {'offset': offset})..addAll({'limit': limit});

    return await this._restClient.get('/v1/payments/search', filters);
  }

  Future<Map<String, dynamic>> createPreference(
      Map<String, dynamic> preference) async {
    final String access_token = await this.getAccessToken();
    return await this._restClient.post('/checkout/preferences',
        params: {'access_token': access_token}, data: preference);
  }

  Future<Map<String, dynamic>> updatePreference(String id,
      Map<String, dynamic> preference) async {
    final String access_token = await this.getAccessToken();
    return await this._restClient.put('/checkout/preferences/${id}',
        params: {'access_token': access_token}, data: preference);
  }

  Future<Map<String, dynamic>> getPreference(String id) async {
    final String access_token = await this.getAccessToken();
    return await this
        ._restClient
        .get('/checkout/preferences/${id}', {'access_token': access_token});
  }

  Future<Map<String, dynamic>> createPreapprovalPayment(
      Map<String, dynamic> payment) async {
    final String access_token = await this.getAccessToken();
    return await this._restClient.post('/preapproval/',
        params: {'access_token': access_token}, data: payment);
  }

  Future<Map<String, dynamic>> getPreapprovalPayment(String id) async {
    final String access_token = await this.getAccessToken();
    return await this
        ._restClient
        .get('/preapproval/${id}', {'access_token': access_token});
  }

  Future<Map<String, dynamic>> updatePreapprovalPayment(String id,
      Map<String, dynamic> payment) async {
    final String access_token = await this.getAccessToken();
    return await this._restClient.put('/preapproval/${id}',
        params: {'access_token': access_token}, data: payment);
  }

  Future<Map<String, dynamic>> cancelPreapprovalPayment(String id) async {
    final String access_token = await this.getAccessToken();
    return await this._restClient.put('/preapproval/${id}',
        params: {'access_token': access_token}, data: {"status": "cancelled"});
  }
}

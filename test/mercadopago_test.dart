import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import "package:test/test.dart";

void main() {
  String CLIENT_ID = '';
  String CLIENT_SECRET = '';

  var mp = MP(CLIENT_ID, CLIENT_SECRET);

  test('Testing getAccessToken()', () async {
    var token = await mp.getAccessToken();

    expect(token, isNot(equals(null)));
  });

  test('Testing get()', () async {
    var response =
    await mp.get("/v1/payment_methods", authenticate: true, params: {});

    expect(response['status'], equals(200));
  });

  test('Testing createPreference()', () async {
    var response = await mp.createPreference({
      "items": [
        {
          "title": "sdk-python",
          "quantity": 5,
          "currency_id": "ARS",
          "unit_price": 10.5
        }
      ]
    });

    expect(response['status'], equals(201));
  });
}

import "package:test/test.dart";
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

void main() {
  String CLIENT_ID = '';
  String CLIENT_SECRET = '';

  var mp = MP(CLIENT_ID, CLIENT_SECRET);

  test('Testing getAccessToken()', () async {
    var token = await mp.getAccessToken();

    expect(token, isNot(equals(null)));
  });

  test('Testing createPreference()', () async {
    var response = await mp.createPreference({
      "items": [
        {
          "title": "sdk-python",
          "quantity": 5,
          "currency_id": "VEF",
          "unit_price": 10.5
        }
      ]
    });

    expect(response['status'], equals(200));
  });
}

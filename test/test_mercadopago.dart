import "package:test/test.dart";
import 'package:mercadopago_sdk/mercadopago.dart';

void main() {
  String CLIENT_ID = '';
  String CLIENT_SECRET = '';

  test('Testing createPreference()', () async {
    var mp = MP(CLIENT_ID, CLIENT_SECRET);

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

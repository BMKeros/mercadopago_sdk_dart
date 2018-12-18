import "package:test/test.dart";
import 'package:mercadopago_sdk/mercadopago.dart';

void main() {
  String CLIENT_ID = '';
  String CLIENT_SECRET = '';

  test('Testing getAccessToken()', () async {
    var mp = MP(CLIENT_ID, CLIENT_SECRET);

    var token = await mp.getAccessToken();

    expect(token, isNot(equals(null)));
  });
}

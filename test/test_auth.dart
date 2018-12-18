import "package:test/test.dart";
import 'package:mercadopago_sdk/mercadopago.dart';

void main() {
  String CLIENT_ID = '153375178490957';
  String CLIENT_SECRET = 'WM64YE7NqEjfzdxzXOTiuWRZctKKLB9U';

  test('Testing getAccessToken()', () async {
    var mp = MP(CLIENT_ID, CLIENT_SECRET);

    var token = await mp.getAccessToken();

    expect(token, isNot(equals(null)));
  });
}

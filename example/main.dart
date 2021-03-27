import 'package:mercadopago_sdk/mercadopago_sdk.dart';

void main() async {
  var mp = MP('CLIENT_ID', 'CLIENT_SECRET');

  String? token = await mp.getAccessToken();

  print('Mercadopago token ${token}');
}

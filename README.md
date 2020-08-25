# MercadoPago SDK module for Payments integration

## Usage

To use this plugin, add `mercadopago_sdk` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

- Basic checkout
- Customized checkout
- Generic methods

## Basic checkout

Configure your credentials

- Get your **CLIENT_ID** and **CLIENT_SECRET** in the following address:
  - Argentina: [https://www.mercadopago.com/mla/herramientas/aplicaciones](https://www.mercadopago.com/mla/herramientas/aplicaciones)
  - Brazil: [https://www.mercadopago.com/mlb/ferramentas/aplicacoes](https://www.mercadopago.com/mlb/ferramentas/aplicacoes)
  - México: [https://www.mercadopago.com/mlm/herramientas/aplicaciones](https://www.mercadopago.com/mlm/herramientas/aplicaciones)
  - Venezuela: [https://www.mercadopago.com/mlv/herramientas/aplicaciones](https://www.mercadopago.com/mlv/herramientas/aplicaciones)
  - Colombia: [https://www.mercadopago.com/mco/herramientas/aplicaciones](https://www.mercadopago.com/mco/herramientas/aplicaciones)
  - Chile: [https://www.mercadopago.com/mlc/herramientas/aplicaciones](https://www.mercadopago.com/mlc/herramientas/aplicaciones)

---

    import 'package:mercadopago_sdk/mercadopago_sdk.dart';

    var mp = MP("CLIENT_ID", "CLIENT_SECRET");

---

Instance with only access token

    var mp = MP.fromAccessToken("TOKEN");

## Preferences

Get an existent Checkout preference

---

    Future<Map<String, dynamic>> index() async {
        result = await mp.getPreference("PREFERENCE_ID");

        return result;
    }

Create a Checkout preference

---

    Future<Map<String, dynamic>> index() async {
        var preference = {
            "items": [
                {
                    "title": "Test",
                    "quantity": 1,
                    "currency_id": "USD",
                    "unit_price": 10.4
                }
            ]
        };

        var result = await mp.createPreference(preference);

        return result;
    }

Update an existent Checkout preference

---

    Future<Map<String, dynamic>> index() async {
        var preference = {
            "items": [
                {
                    "title": "Test Modified",
                    "quantity": 1,
                    "currency_id": "USD",
                    "unit_price": 20.4
                }
            ]
        };

        var result = await mp.updatePreference(id, preference);

        return result;
    }

## Payments/Collections

## Search for payments

    Future<Map<String, dynamic>> index() async {
        var filters = {
            "id": None,
            "external_reference": None
        };

        var searchResult = await mp.searchPayment(filters)

        return searchResult;
    }

## Get payment data

    Future<Map<String, dynamic>> index() async {
        paymentInfo = await mp.getPayment("PID");

        return paymentInfo;
    }

## Cancel (only for pending payments)

    Future<Map<String, dynamic>> index() async {
        var result = await mp.cancelPayment("PID");

        // Show result
        return result;
    }

## Refund (only for accredited payments)

    Future<Map<String, dynamic>> index() async {
        var result = await mp.refundPayment("PID");

        // Show result
        return result;
    }

## Customized checkout

## Configure your credentials

- Get your **ACCESS_TOKEN** in the following address:
  - Argentina: [https://www.mercadopago.com/mla/account/credentials](https://www.mercadopago.com/mla/account/credentials)
  - Brazil: [https://www.mercadopago.com/mlb/account/credentials](https://www.mercadopago.com/mlb/account/credentials)
  - Mexico: [https://www.mercadopago.com/mlm/account/credentials](https://www.mercadopago.com/mlm/account/credentials)
  - Venezuela: [https://www.mercadopago.com/mlv/account/credentials](https://www.mercadopago.com/mlv/account/credentials)
  - Colombia: [https://www.mercadopago.com/mco/account/credentials](https://www.mercadopago.com/mco/account/credentials)

---

    import 'package:mercadopago_sdk/mercadopago_sdk.dart';

    var mp = MP("ACCESS_TOKEN");

## Create payment

    mp.post("/v1/payments", data);

## Create customer

    mp.post("/v1/customers", {"email": "email@test.com"});

## Get customer

    mp.get("/v1/customers/CUSTOMER_ID");

- View more Custom checkout related APIs in Developers Site
  - Argentina: [https://www.mercadopago.com.ar/developers](https://www.mercadopago.com.ar/developers)
  - Brazil: [https://www.mercadopago.com.br/developers](https://www.mercadopago.com.br/developers)
  - Mexico: [https://www.mercadopago.com.mx/developers](https://www.mercadopago.com.mx/developers)
  - Venezuela: [https://www.mercadopago.com.ve/developers](https://www.mercadopago.com.ve/developers)
  - Colombia: [https://www.mercadopago.com.co/developers](https://www.mercadopago.com.co/developers)

## Generic methods

---

You can access any other resource from the MercadoPago API using the generic methods:

    // Get a resource, with optional URL params. Also you can disable authentication for public APIs
    mp.get("/resource/uri", { params, authenticate });

    // Create a resource with "data" and optional URL params.
    mp.post("/resource/uri", { data, params });

    // Update a resource with "data" and optional URL params.
    mp.put("/resource/uri", { data, params });

    // Delete a resource with optional URL params.
    mp.delete("/resource/uri", { params });

For example, if you want to get the Sites list (no params and no authentication):

    var result = mp.get("/sites");

    print(result);

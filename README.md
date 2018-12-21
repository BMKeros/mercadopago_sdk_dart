# MercadoPago SDK module for Payments integration

## Usage

To use this plugin, add `mercadopago_sdk` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

- `Basic checkout`\_
- `Customized checkout`\_
- `Generic methods`\_

## Basic checkout

Configure your credentials

- Get your **CLIENT_ID** and **CLIENT_SECRET** in the following address:
  - Argentina: `https://www.mercadopago.com/mla/herramientas/aplicaciones <https://www.mercadopago.com/mla/herramientas/aplicaciones>`\_
  - Brazil: `https://www.mercadopago.com/mlb/ferramentas/aplicacoes <https://www.mercadopago.com/mlb/ferramentas/aplicacoes>`\_
  - México: `https://www.mercadopago.com/mlm/herramientas/aplicaciones <https://www.mercadopago.com/mlm/herramientas/aplicaciones>`\_
  - Venezuela: `https://www.mercadopago.com/mlv/herramientas/aplicaciones <https://www.mercadopago.com/mlv/herramientas/aplicaciones>`\_
  - Colombia: `https://www.mercadopago.com/mco/herramientas/aplicaciones <https://www.mercadopago.com/mco/herramientas/aplicaciones>`\_
  - Chile: `https://www.mercadopago.com/mlc/herramientas/aplicaciones <https://www.mercadopago.com/mlc/herramientas/aplicaciones>`\_

---

    import 'package:mercadopago_sdk/mercadopago_sdk.dart';
    mp = MP("CLIENT_ID", "CLIENT_SECRET");

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
  - Argentina: `https://www.mercadopago.com/mla/account/credentials <https://www.mercadopago.com/mla/account/credentials>`\_
  - Brazil: `https://www.mercadopago.com/mlb/account/credentials <https://www.mercadopago.com/mlb/account/credentials>`\_
  - Mexico: `https://www.mercadopago.com/mlm/account/credentials <https://www.mercadopago.com/mlm/account/credentials>`\_
  - Venezuela: `https://www.mercadopago.com/mlv/account/credentials <https://www.mercadopago.com/mlv/account/credentials>`\_
  - Colombia: `https://www.mercadopago.com/mco/account/credentials <https://www.mercadopago.com/mco/account/credentials>`\_

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
  - Argentina: `https://www.mercadopago.com.ar/developers <https://www.mercadopago.com.ar/developers>`\_
  - Brazil: `https://www.mercadopago.com.br/developers <https://www.mercadopago.com.br/developers>`\_
  - Mexico: `https://www.mercadopago.com.mx/developers <https://www.mercadopago.com.mx/developers>`\_
  - Venezuela: `https://www.mercadopago.com.ve/developers <https://www.mercadopago.com.ve/developers>`\_
  - Colombia: `https://www.mercadopago.com.co/developers <https://www.mercadopago.com.co/developers>`\_

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

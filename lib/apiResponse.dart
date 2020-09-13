import 'package:http/http.dart' as http;
import 'dart:convert';

 double convertedCurrency;

const String apiKey1 = '617047AA-7907-4A83-A6B0-2BDB85E6A82A';
const String apiKey2 = '8932D663-D778-44B5-9ED5-B5773DB582A3';
const String apiKey3 = '6D3FE9C0-7FDC-4597-8DFF-C08033AD657B';

 Future<dynamic> getCurrency(String crypto, String selectedCurrency) async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=$apiKey3');

    if (response.statusCode == 200) {
      String data = response.body;
      convertedCurrency = jsonDecode(data)['rate'];
      return convertedCurrency.toInt();
    } else {
      print('statuscode: ${response.statusCode}');
    }
  }
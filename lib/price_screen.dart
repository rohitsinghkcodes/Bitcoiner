import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey1 = '617047AA-7907-4A83-A6B0-2BDB85E6A82A';
const String apiKey2 = '8932D663-D778-44B5-9ED5-B5773DB582A3';
const String apiKey3 = '6D3FE9C0-7FDC-4597-8DFF-C08033AD657B';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  double convertedCurrency;
  int newCurrency;

  int Value0;
  int Value1;
  int Value2;
  //Dropdown for android function
  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropItemsList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency,style: TextStyle(fontSize: 26.0),),
        value: currency,
      );
      dropItemsList.add(newItem);
    }
    return DropdownButton<String>(
      iconSize: 30.0,
        value: selectedCurrency,
        items: dropItemsList,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            bitTicker(selectedCurrency);
          });
        });
  }

  //picker for iOS function
  CupertinoPicker getiOsPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(
        currency,
        style: TextStyle(color: Colors.white70),
      ));
    }
    return CupertinoPicker(
      backgroundColor: Colors.blue[700],
      itemExtent: 33,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = pickerItems[selectedIndex].toString();
        bitTicker(selectedCurrency);
      },
      children: pickerItems,
    );
  }

  //first run method
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCurrency = 'USD';
    });
    bitTicker(selectedCurrency);
  }

  //Handling multiple bitcoin versions
  void bitTicker(String selectCurr) async {
    int Valuebtc = await getCurrency(cryptoList[0], selectedCurrency);
    int ValueEth = await getCurrency(cryptoList[1], selectedCurrency);
    int ValueLtc = await getCurrency(cryptoList[2], selectedCurrency);
    setState(() {
      Value0 = Valuebtc;
      Value1 = ValueEth;
      Value2 = ValueLtc;
    });
  }

  Future<dynamic> getCurrency(String crypto, String selectedCurrency) async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=$apiKey2');

    if (response.statusCode == 200) {
      String data = response.body;
      convertedCurrency = jsonDecode(data)['rate'];
      return convertedCurrency.toInt();
    } else {
      print('statuscode: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'BITCOIN TICKER',
          style: TextStyle(color: Colors.white70),
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                Card(
                  color: Colors.blue[700],
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $Value0 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.blue[700],
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $Value1 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.blue[700],
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $Value2 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blue[700],
            child: Platform.isIOS ? getiOsPicker() : getAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}

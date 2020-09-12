import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  //Dropdown for android function
  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropItemsList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropItemsList.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropItemsList,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
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
      onSelectedItemChanged: (selectedIndex) {},
      children: pickerItems,
    );
  }

  //Method for fetching the currency
  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  void getCurrency() async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=617047AA-7907-4A83-A6B0-2BDB85E6A82A');
    

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
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
            child: Card(
              color: Colors.blue[700],
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
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

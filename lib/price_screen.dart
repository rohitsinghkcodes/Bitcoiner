
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'apiResponse.dart';



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //Declarations
  String selectedCurrency = 'USD';
  int value0, value1, value2;

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
        //No functionality yet
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
    int valuebtc = await getCurrency(cryptoList[0], selectedCurrency);
    int valueEth = await getCurrency(cryptoList[1], selectedCurrency);
    int valueLtc = await getCurrency(cryptoList[2], selectedCurrency);
    setState(() {
      value0 = valuebtc;
      value1 = valueEth;
      value2 = valueLtc;
    });
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
                      '1 BTC = $value0 $selectedCurrency',
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
                      '1 ETH = $value1 $selectedCurrency',
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
                      '1 LTC = $value2 $selectedCurrency',
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

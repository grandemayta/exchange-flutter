import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/exchange_model.dart';

class Exchange extends StatefulWidget {
  @override
  createState() => ExchangeState();
}

class ExchangeState extends State<Exchange> {
  String currencyFrom = 'EUR';
  String currencyTo = 'USD';
  String amount = '';
  String result = '';
  final String url = 'https://exchangeratesapi.io/api/latest';

  Future fetchData(String currencyFrom, String currencyTo) async {
    final response = await http.get('$url?base=$currencyFrom&symbols=$currencyTo');

    if (response.statusCode == 200) {
      var data = ExchangeModel.fromJson(json.decode(response.body));
      var rate = data.rates;
      rate.forEach(iterateMapEntry);
    } else if (response.statusCode == 400) {
      var data = ExchangeModel.fromJson(json.decode(response.body));
      var error = data.error;
      updateResult(error);

    } else {
      throw Exception('Failed http call!');
    }
  }

  void iterateMapEntry(key, value) {
    updateResult((value * double.parse(amount)).toStringAsFixed(2));
  }

  void updateAmount(value) {
    setState(() {
      amount = value;
    });
  }

  void updateCurrencyFrom(value) {
    setState(() {
      currencyFrom = value;
      result = '';
    });
  }

  void updateCurrencyTo(value) {
    setState(() {
      currencyTo = value;
      result = '';
    });
  }

  void handleClick() {
    if (amount.length > 0) {
      fetchData(currencyFrom, currencyTo);
    }
  }

  void updateResult(value) {
    setState(() {
      result = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    final currencies = [
      new DropdownMenuItem<String>(value: 'EUR', child: Text('EUR')),
      new DropdownMenuItem<String>(value: 'USD', child: Text('USD')),
      new DropdownMenuItem<String>(value: 'CHF', child: Text('CHF'))
    ].toList();

    Widget resultChild;

    if (result != '') {
      resultChild = Container(
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        decoration: BoxDecoration(color: Colors.black12),
        height: 50.0,
        alignment: Alignment(0.0, 0.0),
        child: Text(result, style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold
        )),
      );
    } else {
      resultChild = Container();
    }

    var textField = Row(
      children: [
         Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Type amount'
            ),
            onChanged: (value) {
              updateAmount(value);
            },
          ),
        )
      ],
    );

    var dropDowns = Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 20.0, 40.0, 0.0),
            child: DropdownButton(
              value: currencyFrom,
              items: currencies,
              onChanged: (value) {
                updateCurrencyFrom(value);
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
            child: DropdownButton(
              value: currencyTo,
              items: currencies,
              onChanged: (value) {
                updateCurrencyTo(value);
              },
            ),
          ),
        )
      ],
    );

    var message = Row(
      children: [
        Expanded(
          child: resultChild
        )
      ],
    );

    var button = Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
            child: RaisedButton(
              child: Text('Calculate'),
              color: Colors.lightBlueAccent,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0),
              onPressed: () {
                handleClick();
              },
            )
          )
        )
      ],
    );

    var label = Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: Text(
              'Developed by GABRIEL MAYTA', 
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center
            )
          )
        )
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            textField,
            dropDowns,
            button,
            message
          ],
        )
      ),
      bottomNavigationBar: label 
    );
  }
}

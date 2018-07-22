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
  String amount = '';
  String currencyFrom = 'EUR';
  String currencyTo = 'USD';
  String result = '';
  final String url = 'https://exchangeratesapi.io/api/latest';

  Future fetchData(String currencyFrom, String currencyTo) async {
    final response = await http.get('$url?base=$currencyFrom&symbols=$currencyTo');

    if (response.statusCode == 200) {
      var data = ExchangeModel.fromJson(json.decode(response.body));
      var rate = data.rates;
      rate.forEach(iterateMapEntry);
      print(rate);
    } else {
      throw Exception('Failed http call!');
    }
  }

  void iterateMapEntry(key, value) {
    print(value + 1);
  }

  void updateAmount(value) {
    setState(() {
      amount = value;
    });
  }

  void updateCurrencyFrom(value) {
    setState(() {
      currencyFrom = value;
    });
  }

  void updateCurrencyTo(value) {
    setState(() {
      currencyTo = value;
    });
  }

  void handleClick(value) {
    fetchData(currencyFrom, currencyTo);
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

    var textField = Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Type the amount',
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
          child: DropdownButton(
            hint: Text('From'),
            value: currencyFrom,
            items: currencies,
            onChanged: (value) {
              updateCurrencyFrom(value);
            },
          ),
        ),
        Expanded(
          child: DropdownButton(
            hint: Text('To'),
            value: currencyTo,
            items: currencies,
            onChanged: (value) {
              updateCurrencyTo(value);
            },
          ),
        )
      ],
    );

    var message = Row(
      children: [
        Expanded(
          child: Text('$result'),
        )
      ],
    );

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            textField,
            dropDowns,
            message
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleClick(amount);
        },
        child: Icon(Icons.monetization_on)
      ),  
    );
  }
}

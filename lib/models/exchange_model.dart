class ExchangeModel {
  final String base;
  final String date;
  final Map rates;
  final String error;

  ExchangeModel({this.base, this.date, this.rates, this.error});

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      base: json['base'],
      date: json['date'],
      rates: json['rates'],
      error: json['error']
    );
  }
}
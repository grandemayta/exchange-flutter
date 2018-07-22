class ExchangeModel {
  final String base;
  final String date;
  final Map rates;

  ExchangeModel({this.base, this.date, this.rates});

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      base: json['base'],
      date: json['date'],
      rates: json['rates']
    );
  }
}
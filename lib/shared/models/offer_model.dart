class OfferModel {
  OfferModel({
    required this.name,
    required this.cost,
  });

  factory OfferModel.fromMap(Map data) {
    return OfferModel(name: data['name'], cost: data['cost']);
  }

  final String name;
  final int cost;

  Map toMap() {
    return {'name': name, 'cost': cost};
  }
}

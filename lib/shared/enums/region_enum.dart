enum Region {
  eu('eu'),
  na('na'),
  kr('kr'),
  ap('ap');

  final String type;
  const Region(this.type);

  factory Region.fromID(String string) {
    return values.firstWhere((element) => element.type == string);
  }
}

enum Locations {
  currentLocation('Current Location', 1),
  lisboa('Lisboa', 2267056),
  leiria('Leiria', 2267094),
  coimbra('Coimbra', 2740636),
  porto('Porto', 2735941),
  faro('Faro', 2268337);

  const Locations(this.location, this.locationId);
  final String location;
  final int locationId;
}

enum TemperatureUnits {
  celsius("Celsius", 'ºC'),
  fahrenheit("Fahrenheit", 'ºF'),
  kelvins("Kelvins", 'ºK');

  const TemperatureUnits(this.unit, this.identificationSymbol);
  final String unit;
  final String identificationSymbol;
}

enum FuelType { e5, e10, diesel }

enum SearchMode {
  location('Aktueller Standort'),
  place('Ort'),
  ;

  const SearchMode(this.name);
  final String name;
}

class FilterState {
  const FilterState({
    required this.fuelType,
    required this.radius,
    required this.searchType,
  });
  //TODO: Add filter with own filters
  final FuelType fuelType;
  final double radius;
  final SearchMode searchType;

  FilterState copyWith({
    FuelType? fuelType,
    double? radius,
    SearchMode? searchType,
  }) {
    return FilterState(
      searchType: searchType ?? this.searchType,
      fuelType: fuelType ?? this.fuelType,
      radius: radius ?? this.radius,
    );
  }
}

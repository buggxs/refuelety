import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refuelety/components/map_view/cubit/cubit/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit()
      : super(
          const FilterState(
            fuelType: FuelType.diesel,
            radius: 5,
            searchType: SearchMode.location,
          ),
        );

  void updateFuelType(FuelType fuelType) {
    emit(state.copyWith(fuelType: fuelType));
  }

  void updateRadius(double radius) {
    emit(state.copyWith(radius: radius));
  }

  void updateSearchType(SearchMode searchType) {
    emit(state.copyWith(searchType: searchType));
  }
}

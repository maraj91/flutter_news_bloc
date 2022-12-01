part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryDataLoaded extends CountryState {
  late final CountryListMain data;
  CountryDataLoaded(this.data);
}

class CountryError extends CountryState {}
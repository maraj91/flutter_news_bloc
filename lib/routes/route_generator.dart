import 'package:news_flutter_block/block/countries/country_bloc.dart';
import 'package:news_flutter_block/block/news/news_bloc.dart';
import 'package:news_flutter_block/data/model/news_list/news_list_main.dart';
import 'package:news_flutter_block/ui/country_list/country_list_center_screen.dart';
import 'package:news_flutter_block/ui/country_list/country_list_screen.dart';
import 'package:news_flutter_block/ui/news_detail/news_detail_screen.dart';
import 'package:news_flutter_block/ui/news_home/news_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  
  final NewsBloc _newsBloc = NewsBloc();
  final CountryBloc _countryBloc = CountryBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case NewsListScreen.id:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<NewsBloc>.value(
            value: _newsBloc,
            child: const NewsListScreen(),
          ),
        );

      case NewsDetailScreen.id :
        return MaterialPageRoute(
          builder: (_) => BlocProvider<NewsBloc>.value(
            value: _newsBloc,
            child: NewsDetailScreen(articleData: args as Article),
          ),
        );

      case CountryListScreen.id :
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CountryBloc>.value(
            value: _countryBloc,
            child: const CountryListScreen(),
          ),
        );

      case CountryListCenterScreen.id :
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CountryBloc>.value(
            value: _countryBloc,
            child: CountryListCenterScreen(selectedCountry: args as String),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error while loading new page'),
        ),
      );
    });
  }
}
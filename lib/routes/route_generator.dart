import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter_block/block/countries/country_bloc.dart';
import 'package:news_flutter_block/block/news/news_bloc.dart';
import 'package:news_flutter_block/data/model/news_list/news_list_main.dart';
import 'package:news_flutter_block/ui/country_list/country_list_center_screen.dart';
import 'package:news_flutter_block/ui/country_list/country_list_screen.dart';
import 'package:news_flutter_block/ui/news_detail/news_detail_screen.dart';
import 'package:news_flutter_block/ui/news_detail/news_detail_slider_screen.dart';
import 'package:news_flutter_block/ui/news_home/news_list_pagination_screen.dart';
import 'package:news_flutter_block/ui/news_home/news_list_screen.dart';

class RouteGenerator {
  // final NewsBloc _newsBloc = NewsBloc();
  // final CountryBloc _countryBloc = CountryBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case NewsListScreen.id:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<NewsBloc>.value(
            value: NewsBloc(),
            child: const NewsListScreen(),
          ),
        );

      case NewsDetailSliderScreen.id:
        return MaterialPageRoute(
          builder: (context) {
            return NewsDetailSliderScreen(newsList: args as List<Article>);
          },
        );

      case NewsDetailScreen.id:
        return MaterialPageRoute(
          builder: (context) {
            return NewsDetailScreen(articleData: args as Article);
          },
        );

      case CountryListScreen.id:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CountryBloc>.value(
            value: CountryBloc(),
            child: const CountryListScreen(),
          ),
        );

      case CountryListCenterScreen.id:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CountryBloc>.value(
            value: CountryBloc(),
            child: CountryListCenterScreen(selectedCountry: args as String),
          ),
        );

      case NewsListPaginationScreen.id:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<NewsBloc>.value(
            value: NewsBloc(),
            child: const NewsListPaginationScreen(),
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

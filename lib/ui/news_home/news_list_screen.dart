import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter_block/block/news/news_bloc.dart';
import 'package:news_flutter_block/data/model/news_list/news_list_main.dart';
import 'package:news_flutter_block/main.dart';
import 'package:news_flutter_block/res/app_context_extension.dart';
import 'package:news_flutter_block/ui/country_list/country_list_center_screen.dart';
import 'package:news_flutter_block/ui/navigation_drawer/navigation_action.dart';
import 'package:news_flutter_block/ui/navigation_drawer/navigation_drawer.dart';
import 'package:news_flutter_block/ui/news_detail/news_detail_screen.dart';
import 'package:news_flutter_block/ui/news_detail/news_detail_slider_screen.dart';
import 'package:news_flutter_block/ui/news_home/news_list_pagination_screen.dart';
import 'package:news_flutter_block/ui/utils/utility.dart';
import 'package:news_flutter_block/ui/widget/app_widgets.dart';

class NewsListScreen extends StatefulWidget {
  static const String id = "news_list_screen";

  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late NewsBloc _newsBloc;
  String selectedCountries = "in";
  String newsType = "";
  List<Article> _newsList = [];

  @override
  void initState() {
    _newsBloc = BlocProvider.of(context);
    _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBarWithSingleIcon(context, context.resources.strings?.newsHome ?? "", () {
        _moveToCountryListScreen();
      },const Icon(Icons.language)),
      drawer: NavigationDrawer(countryMenuClick: (events) {
        Navigator.pop(context);
        switch(events) {
          case NavigationAction.country:
            _moveToCountryListScreen();
            break;
          case NavigationAction.about:
            print("CLICK -> ${events.name}");
            break;
          case NavigationAction.allNews:
            newsType = events.name;
            _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
            break;
          case NavigationAction.technology:
            newsType = events.name;
            _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
            break;
          case NavigationAction.business:
            newsType = events.name;
            _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
            break;
          case NavigationAction.entertainment:
            newsType = events.name;
            _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
            break;
          case NavigationAction.health:
            newsType = events.name;
            _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
            break;
          case NavigationAction.science:
            newsType = events.name;
            _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
            break;
          case NavigationAction.sports:
            newsType = events.name;
            _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
            break;
          case NavigationAction.medium:
            Utility.launchURL("https://marajhussain.medium.com/");
            break;
          case NavigationAction.linkedIn:
            Utility.launchURL("https://in.linkedin.com/in/maraj-hossain-0a67a0a3?trk=people-guest_people_search-card");
            break;
          case NavigationAction.github:
            Utility.launchURL("https://github.com/maraj91");
            break;
          case NavigationAction.allNewsSlider:
            if(_newsList.isNotEmpty) {
              Navigator.of(context, rootNavigator: true).pushNamed(NewsDetailSliderScreen.id,arguments: _newsList);
            }
            break;
          case NavigationAction.lngEnglish:
            MyApp.setLocale(context, const Locale("en"));
            break;
          case NavigationAction.lngHindi:
            MyApp.setLocale(context, const Locale("hi"));
            break;
          case NavigationAction.newsPagination:
            Navigator.of(context, rootNavigator: true).pushNamed(NewsListPaginationScreen.id);
            break;
        }},
      ),
      body: BlocConsumer<NewsBloc, NewsState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("${NewsListScreen.id} -->> $state");
          }
          if (state is NewsPageLoading) {
            return AppWidgets.getCenterLoadingView();
          } else if (state is NewsPageLoaded) {
            if (state.data.articles.isNotEmpty == true) {
              _newsList = state.data.articles;
            } else {
              return AppWidgets.getBuildNoResult(context, context.resources.strings?.noNewsFound ?? "");
            }
          } else if (state is NewsPageError) {
            return AppWidgets.getBuildNoResult(context, state.errorMessage);
          }
          return _newsListView();
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _newsListView() {
    return ListView.builder(
      itemCount: _newsList.length,
      itemBuilder: (context, index) {
        return _newsListItems(_newsList[index]);
      },
    );
  }

  Widget _newsListItems(Article article) {
    return Card(
      child: ListTile(
        title: Text(
          article.source?.name ?? "NA",
          style: context.resources.style.headingTextStyle,
        ),
        subtitle: Text(article.title, style: context.resources.style.subHeadingTextStyle),
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(NewsDetailScreen.id, arguments: article);
        },
      ),
    );
  }

  void _moveToCountryListScreen() async {
    final result = await Navigator.of(context, rootNavigator: true)
        .pushNamed(CountryListCenterScreen.id,arguments: selectedCountries);
    if (kDebugMode) {
      print("SELECTED COUNTRY CODE: $result");
    }
    selectedCountries = result as String;
    _newsBloc.add(NewsFetchDataEvent(selectedCountries,newsType));
  }
}

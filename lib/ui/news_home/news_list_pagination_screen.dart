import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter_block/block/news/news_bloc.dart';
import 'package:news_flutter_block/data/model/news_list/news_list_main.dart';
import 'package:news_flutter_block/res/app_context_extension.dart';
import 'package:news_flutter_block/ui/news_detail/news_detail_screen.dart';
import 'package:news_flutter_block/ui/widget/app_widgets.dart';

class NewsListPaginationScreen extends StatefulWidget {
  static const String id = "news_list_pagination_screen";

  const NewsListPaginationScreen({Key? key}) : super(key: key);

  @override
  State<NewsListPaginationScreen> createState() =>
      _NewsListPaginationScreenState();
}

class _NewsListPaginationScreenState extends State<NewsListPaginationScreen> {
  late NewsBloc _newsBloc;
  String selectedCountries = "in";
  String newsType = "";
  final List<Article> _newsList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print("initState");
    _newsBloc = BlocProvider.of(context);
    _newsBloc.add(NewsFetchDataPaginationEvent(selectedCountries, newsType));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(
        context,
        context.resources.strings?.newsHome ?? "",
      ),
      body: BlocConsumer<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsPageLoadingMore) {
              return AppWidgets.getCenterLoadingView();
          } else if (state is NewsPageError) {
            return AppWidgets.getBuildNoResult(context, state.errorMessage);
          } else if (state is NewsMorePageLoaded) {
            _newsList.addAll(state.data.articles);
            if(_newsList.length >= state.data.totalResults) {
              _newsBloc.haveMoreData = false;
            } else {
              _newsBloc.haveMoreData = true;
            }
          }
          return _newsListView();
        },
        listener: (context, state) {
        },
      ),
    );
  }

  Widget _newsListView() {
    return ListView(
      controller: _scrollController..addListener(() {
        if(_scrollController.offset == _scrollController.position.maxScrollExtent && _newsBloc.haveMoreData) {
          _newsBloc.haveMoreData = false;
          _newsBloc.add(NewsFetchDataPaginationEvent(selectedCountries, newsType));
        }
      }),
      children: [
        ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _newsList.length,
          itemBuilder: (context, index) {
            return _newsListItems(_newsList[index], index);
          },
        ),
        _newsBloc.haveMoreData?_bottomLoaderView():Container()
      ],
    );
  }

  Widget _newsListItems(Article article, int index) {
    return Card(
      child: ListTile(
        leading: Text(
          (index + 1).toString(),
          style: context.resources.style.headingTextStyle,
        ),
        title: Text(
          article.source?.name ?? "NA",
          style: context.resources.style.headingTextStyle,
        ),
        subtitle: Text(article.title,
            style: context.resources.style.subHeadingTextStyle),
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(NewsDetailScreen.id, arguments: article);
        },
      ),
    );
  }

  Widget _bottomLoaderView() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(color: Colors.red),
      ),
    );
  }
}

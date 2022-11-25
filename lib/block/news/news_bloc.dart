import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter_block/data/model/news_list/news_list_main.dart';
import 'package:news_flutter_block/repository/news/news_repo_imp.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

  final _newsRepo = NewsRepoImp();

  NewsBloc() : super(NewsInitial()) {
    on<NewsFetchDataEvent>(_fetchNewsList);
  }

  FutureOr<void> _fetchNewsList(NewsEvent event, Emitter<NewsState> emit) async {
    if(event is NewsFetchDataEvent) {
      emit(NewsPageLoading());
      await _newsRepo
          .getNewsData(event.countryCode, event.newsType)
          .onError((error, stackTrace) => emit(NewsPageError(error.toString())))
          .then((value) {
        NewsListMain newsListMain = NewsListMain.fromJson(value);
        if (newsListMain.status == "ok") {
          emit(NewsPageLoaded(newsListMain));
        } else {
          emit(NewsPageError(newsListMain.message ?? "Something went wrong"));
        }
      });
    }
  }
}

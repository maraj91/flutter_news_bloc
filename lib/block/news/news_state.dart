part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsPageLoading extends NewsState {}

class NewsPageLoadingMore extends NewsState {}

class NewsPageLoaded extends NewsState {
  late final NewsListMain data;
  NewsPageLoaded(this.data);
}

class NewsPagingLoaded extends NewsState {
  late final NewsListMain data;
  NewsPagingLoaded(this.data);
}

class NewsMorePageLoaded extends NewsState {
  late final NewsListMain data;
  NewsMorePageLoaded(this.data);
}

class NewsPageError extends NewsState {
  late final String errorMessage;
  NewsPageError(this.errorMessage);
}

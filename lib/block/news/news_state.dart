part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsPageLoading extends NewsState {}

class NewsPageLoaded extends NewsState {
  late final NewsListMain data;
  NewsPageLoaded(this.data);
}

class NewsPageError extends NewsState {
  late final String errorMessage;
  NewsPageError(this.errorMessage);
}

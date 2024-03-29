part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchSucces<T> extends SearchState {
  final List<T> result;

  SearchSucces(this.result);
}
class GetPopularSucces<T> extends SearchState {
  final List<T> result;

  GetPopularSucces(this.result);
}

class EmptySearch extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}

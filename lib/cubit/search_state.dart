part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class AuthInitial extends SearchState {}

class AuthSucces extends SearchState {
  final List<Release> releases;

  AuthSucces(this.releases);
}

class AuthLoading extends SearchState {}

class AuthError extends SearchState {
  final String error;

  AuthError(this.error);
}

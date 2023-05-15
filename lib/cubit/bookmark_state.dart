part of 'bookmark_cubit.dart';

@immutable
abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}


class BookmarkLoading extends BookmarkState {}

class BookmarkError extends BookmarkState {
  final String error;

  BookmarkError(this.error);
}

class BookmarkSucces<T> extends BookmarkState {
  final List<T> result;

  BookmarkSucces(this.result);
}
class ReleaseSucces<Release> extends BookmarkState {
  final Release result;

  ReleaseSucces(this.result);
}
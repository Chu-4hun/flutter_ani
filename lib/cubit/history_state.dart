part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryError extends HistoryState {
  final String error;

  HistoryError(this.error);
}

class HistorySucces<T> extends HistoryState {
  final List<T> result;

  HistorySucces(this.result);
}

class HistoryReleaseSucces<Release> extends HistoryState {
  final Release result;

  HistoryReleaseSucces(this.result);
}
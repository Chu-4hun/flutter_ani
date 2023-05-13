part of 'release_cubit.dart';

@immutable
abstract class ReleaseState {}

class ReleaseInitial extends ReleaseState {}

class ReleaseInfo extends ReleaseState {
  final List<Dub> dubs;

  ReleaseInfo(this.dubs);
}

class ReleaseSucces<T> extends ReleaseState {
   final List<T> result;

  ReleaseSucces(this.result);
}

class ReleaseEpisodeSucces<Episode> extends ReleaseState {
   final Episode result;

  ReleaseEpisodeSucces(this.result);
}

class ReleaseLoading extends ReleaseState {}

class ReleaseError extends ReleaseState {
  final String error;

  ReleaseError(this.error);
}

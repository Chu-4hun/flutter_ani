enum URL {
  accessToken('access/'),
  register('auth/register'),
  login('auth/login'),

  profile("profile/"),
  profileEdit("profile/edit"),
  profileSearch("profile/search"),

  watch("watch/"),
  getAllReleases("watch/releases/popular/show"),
  searchReleases("watch/releases/search?request="),
  geByEpisodeById('watch/episode/'),
  getReleaseByEpisodeId('watch/release?episode_id='),
  addHistory("history/insert?"),

  getAllDubOptionsForRelease("watch/release/"),

  getHistoryById('history/'),
  
  addFriend('interact/friend/add/');


  final String value;

  const URL(this.value);
}

// ignore: constant_identifier_names
const String BASE_URL = 'http://localhost:8090/api/v1/';

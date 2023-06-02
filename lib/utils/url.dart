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
  getAllDubOptionsForRelease("watch/release/"),

  geByEpisodeById('watch/episode/'),
  getReleaseByEpisodeId('watch/release?episode_id='),
  getReleaseById('watch/release/'),

  addHistory("history/insert?"),
  getHistoryById('history/'),

  getReviewsWithPagination("review/"),
  sendReview("review/insert"),

  addBookmark("bookmark/add?"),
  getBookmark("bookmark/"),
  
  addFriend('interact/friend/add/');


  final String value;

  const URL(this.value);
}

// ignore: constant_identifier_names
const String BASE_URL = 'http://194.87.238.111:8090/api/v1/';

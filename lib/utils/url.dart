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

  addFriend('interact/friend/add/');

  final String value;

  const URL(this.value);
}

// ignore: constant_identifier_names
const String BASE_URL = 'http://192.168.1.78:8090/api/v1/';

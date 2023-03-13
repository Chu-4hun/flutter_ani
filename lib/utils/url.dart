enum URL {
  token('access/'),
  register('auth/register'),
  login('auth/login'),
  addFriend('interact/friend/add/');

  final String value;

  const URL(this.value);
}

// ignore: constant_identifier_names
const String BASE_URL = 'http://localhost:8090/api/v1/';

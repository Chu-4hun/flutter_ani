enum URL {
  host('http://localhost:8090'),

  token('http://localhost:8090/api/v1/access/'),
  register('http://localhost:8090/api/v1/auth/register'),
  note('http://localhost:8090/api/v1/auth/login'),
  addFriend('http://localhost:8090/api/v1/interact/friend/add/');

  final String value;

  const URL(this.value);
}
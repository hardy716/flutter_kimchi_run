abstract class FirestoreCollection {
  static final Users users = Users();
  static final Nicknames nicknames = Nicknames();
  static final Rankings rankings = Rankings();
}

abstract class FirestoreField {
  String get name;
}

class _Field implements FirestoreField {
  @override
  final String name;

  const _Field(this.name);
}

class Users {
  String get name => 'users';

  final uid = _Field('uid');
  final nickname = _Field('nickname');
}

class Nicknames {
  String get name => 'nicknames';
}

class Rankings {
  String get name => 'rankings';

  final uid = _Field('uid');
  final nickname = _Field('nickname');
  final highScore = _Field('highScore');
  final playCount = _Field('playCount');
  final updatedAt = _Field('updatedAt');
}
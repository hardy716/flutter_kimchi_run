abstract class DebounceTag {
  static final Ranking ranking = Ranking();
}

abstract class DebounceTagField {
  String get name;
}

class _Field implements DebounceTagField {
  @override
  final String name;

  const _Field(this.name);
}

class Ranking {
  String get name => 'ranking';

  final fetchRankingUser = _Field('fetchRankingUser');
}
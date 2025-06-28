// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  String get id => throw _privateConstructorUsedError;
  String get joinCode => throw _privateConstructorUsedError;
  List<User> get players => throw _privateConstructorUsedError;
  List<Team> get teams => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  GamePhase get phase => throw _privateConstructorUsedError;
  int get currentRound => throw _privateConstructorUsedError;
  String? get currentClueGiverId => throw _privateConstructorUsedError;
  String get currentCategory => throw _privateConstructorUsedError;
  String? get currentNoun => throw _privateConstructorUsedError;
  List<String> get guessedNouns => throw _privateConstructorUsedError;
  Map<String, List<String>> get teamScores =>
      throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call({
    String id,
    String joinCode,
    List<User> players,
    List<Team> teams,
    GameStatus status,
    GamePhase phase,
    int currentRound,
    String? currentClueGiverId,
    String currentCategory,
    String? currentNoun,
    List<String> guessedNouns,
    Map<String, List<String>> teamScores,
    DateTime createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? joinCode = null,
    Object? players = null,
    Object? teams = null,
    Object? status = null,
    Object? phase = null,
    Object? currentRound = null,
    Object? currentClueGiverId = freezed,
    Object? currentCategory = null,
    Object? currentNoun = freezed,
    Object? guessedNouns = null,
    Object? teamScores = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            joinCode:
                null == joinCode
                    ? _value.joinCode
                    : joinCode // ignore: cast_nullable_to_non_nullable
                        as String,
            players:
                null == players
                    ? _value.players
                    : players // ignore: cast_nullable_to_non_nullable
                        as List<User>,
            teams:
                null == teams
                    ? _value.teams
                    : teams // ignore: cast_nullable_to_non_nullable
                        as List<Team>,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as GameStatus,
            phase:
                null == phase
                    ? _value.phase
                    : phase // ignore: cast_nullable_to_non_nullable
                        as GamePhase,
            currentRound:
                null == currentRound
                    ? _value.currentRound
                    : currentRound // ignore: cast_nullable_to_non_nullable
                        as int,
            currentClueGiverId:
                freezed == currentClueGiverId
                    ? _value.currentClueGiverId
                    : currentClueGiverId // ignore: cast_nullable_to_non_nullable
                        as String?,
            currentCategory:
                null == currentCategory
                    ? _value.currentCategory
                    : currentCategory // ignore: cast_nullable_to_non_nullable
                        as String,
            currentNoun:
                freezed == currentNoun
                    ? _value.currentNoun
                    : currentNoun // ignore: cast_nullable_to_non_nullable
                        as String?,
            guessedNouns:
                null == guessedNouns
                    ? _value.guessedNouns
                    : guessedNouns // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            teamScores:
                null == teamScores
                    ? _value.teamScores
                    : teamScores // ignore: cast_nullable_to_non_nullable
                        as Map<String, List<String>>,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            startedAt:
                freezed == startedAt
                    ? _value.startedAt
                    : startedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            endedAt:
                freezed == endedAt
                    ? _value.endedAt
                    : endedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
    _$GameImpl value,
    $Res Function(_$GameImpl) then,
  ) = __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String joinCode,
    List<User> players,
    List<Team> teams,
    GameStatus status,
    GamePhase phase,
    int currentRound,
    String? currentClueGiverId,
    String currentCategory,
    String? currentNoun,
    List<String> guessedNouns,
    Map<String, List<String>> teamScores,
    DateTime createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
  });
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
    : super(_value, _then);

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? joinCode = null,
    Object? players = null,
    Object? teams = null,
    Object? status = null,
    Object? phase = null,
    Object? currentRound = null,
    Object? currentClueGiverId = freezed,
    Object? currentCategory = null,
    Object? currentNoun = freezed,
    Object? guessedNouns = null,
    Object? teamScores = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
  }) {
    return _then(
      _$GameImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        joinCode:
            null == joinCode
                ? _value.joinCode
                : joinCode // ignore: cast_nullable_to_non_nullable
                    as String,
        players:
            null == players
                ? _value._players
                : players // ignore: cast_nullable_to_non_nullable
                    as List<User>,
        teams:
            null == teams
                ? _value._teams
                : teams // ignore: cast_nullable_to_non_nullable
                    as List<Team>,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as GameStatus,
        phase:
            null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                    as GamePhase,
        currentRound:
            null == currentRound
                ? _value.currentRound
                : currentRound // ignore: cast_nullable_to_non_nullable
                    as int,
        currentClueGiverId:
            freezed == currentClueGiverId
                ? _value.currentClueGiverId
                : currentClueGiverId // ignore: cast_nullable_to_non_nullable
                    as String?,
        currentCategory:
            null == currentCategory
                ? _value.currentCategory
                : currentCategory // ignore: cast_nullable_to_non_nullable
                    as String,
        currentNoun:
            freezed == currentNoun
                ? _value.currentNoun
                : currentNoun // ignore: cast_nullable_to_non_nullable
                    as String?,
        guessedNouns:
            null == guessedNouns
                ? _value._guessedNouns
                : guessedNouns // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        teamScores:
            null == teamScores
                ? _value._teamScores
                : teamScores // ignore: cast_nullable_to_non_nullable
                    as Map<String, List<String>>,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        startedAt:
            freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        endedAt:
            freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameImpl implements _Game {
  const _$GameImpl({
    required this.id,
    required this.joinCode,
    required final List<User> players,
    required final List<Team> teams,
    this.status = GameStatus.waiting,
    this.phase = GamePhase.teamSelection,
    this.currentRound = 1,
    this.currentClueGiverId,
    this.currentCategory = 'Person',
    this.currentNoun,
    final List<String> guessedNouns = const [],
    final Map<String, List<String>> teamScores = const {},
    required this.createdAt,
    this.startedAt,
    this.endedAt,
  }) : _players = players,
       _teams = teams,
       _guessedNouns = guessedNouns,
       _teamScores = teamScores;

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  final String id;
  @override
  final String joinCode;
  final List<User> _players;
  @override
  List<User> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<Team> _teams;
  @override
  List<Team> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  @override
  @JsonKey()
  final GameStatus status;
  @override
  @JsonKey()
  final GamePhase phase;
  @override
  @JsonKey()
  final int currentRound;
  @override
  final String? currentClueGiverId;
  @override
  @JsonKey()
  final String currentCategory;
  @override
  final String? currentNoun;
  final List<String> _guessedNouns;
  @override
  @JsonKey()
  List<String> get guessedNouns {
    if (_guessedNouns is EqualUnmodifiableListView) return _guessedNouns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_guessedNouns);
  }

  final Map<String, List<String>> _teamScores;
  @override
  @JsonKey()
  Map<String, List<String>> get teamScores {
    if (_teamScores is EqualUnmodifiableMapView) return _teamScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_teamScores);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;

  @override
  String toString() {
    return 'Game(id: $id, joinCode: $joinCode, players: $players, teams: $teams, status: $status, phase: $phase, currentRound: $currentRound, currentClueGiverId: $currentClueGiverId, currentCategory: $currentCategory, currentNoun: $currentNoun, guessedNouns: $guessedNouns, teamScores: $teamScores, createdAt: $createdAt, startedAt: $startedAt, endedAt: $endedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.joinCode, joinCode) ||
                other.joinCode == joinCode) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.currentRound, currentRound) ||
                other.currentRound == currentRound) &&
            (identical(other.currentClueGiverId, currentClueGiverId) ||
                other.currentClueGiverId == currentClueGiverId) &&
            (identical(other.currentCategory, currentCategory) ||
                other.currentCategory == currentCategory) &&
            (identical(other.currentNoun, currentNoun) ||
                other.currentNoun == currentNoun) &&
            const DeepCollectionEquality().equals(
              other._guessedNouns,
              _guessedNouns,
            ) &&
            const DeepCollectionEquality().equals(
              other._teamScores,
              _teamScores,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    joinCode,
    const DeepCollectionEquality().hash(_players),
    const DeepCollectionEquality().hash(_teams),
    status,
    phase,
    currentRound,
    currentClueGiverId,
    currentCategory,
    currentNoun,
    const DeepCollectionEquality().hash(_guessedNouns),
    const DeepCollectionEquality().hash(_teamScores),
    createdAt,
    startedAt,
    endedAt,
  );

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(this);
  }
}

abstract class _Game implements Game {
  const factory _Game({
    required final String id,
    required final String joinCode,
    required final List<User> players,
    required final List<Team> teams,
    final GameStatus status,
    final GamePhase phase,
    final int currentRound,
    final String? currentClueGiverId,
    final String currentCategory,
    final String? currentNoun,
    final List<String> guessedNouns,
    final Map<String, List<String>> teamScores,
    required final DateTime createdAt,
    final DateTime? startedAt,
    final DateTime? endedAt,
  }) = _$GameImpl;

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  String get id;
  @override
  String get joinCode;
  @override
  List<User> get players;
  @override
  List<Team> get teams;
  @override
  GameStatus get status;
  @override
  GamePhase get phase;
  @override
  int get currentRound;
  @override
  String? get currentClueGiverId;
  @override
  String get currentCategory;
  @override
  String? get currentNoun;
  @override
  List<String> get guessedNouns;
  @override
  Map<String, List<String>> get teamScores;
  @override
  DateTime get createdAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get endedAt;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get playerIds => throw _privateConstructorUsedError;
  String? get clueGiverId => throw _privateConstructorUsedError;
  List<String> get guessedNouns => throw _privateConstructorUsedError;
  @ColorJsonConverter()
  Color get color => throw _privateConstructorUsedError;

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call({
    String id,
    String name,
    List<String> playerIds,
    String? clueGiverId,
    List<String> guessedNouns,
    @ColorJsonConverter() Color color,
  });
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? playerIds = null,
    Object? clueGiverId = freezed,
    Object? guessedNouns = null,
    Object? color = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            playerIds:
                null == playerIds
                    ? _value.playerIds
                    : playerIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            clueGiverId:
                freezed == clueGiverId
                    ? _value.clueGiverId
                    : clueGiverId // ignore: cast_nullable_to_non_nullable
                        as String?,
            guessedNouns:
                null == guessedNouns
                    ? _value.guessedNouns
                    : guessedNouns // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            color:
                null == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
    _$TeamImpl value,
    $Res Function(_$TeamImpl) then,
  ) = __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<String> playerIds,
    String? clueGiverId,
    List<String> guessedNouns,
    @ColorJsonConverter() Color color,
  });
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
    : super(_value, _then);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? playerIds = null,
    Object? clueGiverId = freezed,
    Object? guessedNouns = null,
    Object? color = null,
  }) {
    return _then(
      _$TeamImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        playerIds:
            null == playerIds
                ? _value._playerIds
                : playerIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        clueGiverId:
            freezed == clueGiverId
                ? _value.clueGiverId
                : clueGiverId // ignore: cast_nullable_to_non_nullable
                    as String?,
        guessedNouns:
            null == guessedNouns
                ? _value._guessedNouns
                : guessedNouns // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        color:
            null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as Color,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamImpl implements _Team {
  const _$TeamImpl({
    required this.id,
    required this.name,
    required final List<String> playerIds,
    this.clueGiverId,
    final List<String> guessedNouns = const [],
    @ColorJsonConverter() required this.color,
  }) : _playerIds = playerIds,
       _guessedNouns = guessedNouns;

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _playerIds;
  @override
  List<String> get playerIds {
    if (_playerIds is EqualUnmodifiableListView) return _playerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerIds);
  }

  @override
  final String? clueGiverId;
  final List<String> _guessedNouns;
  @override
  @JsonKey()
  List<String> get guessedNouns {
    if (_guessedNouns is EqualUnmodifiableListView) return _guessedNouns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_guessedNouns);
  }

  @override
  @ColorJsonConverter()
  final Color color;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, playerIds: $playerIds, clueGiverId: $clueGiverId, guessedNouns: $guessedNouns, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._playerIds,
              _playerIds,
            ) &&
            (identical(other.clueGiverId, clueGiverId) ||
                other.clueGiverId == clueGiverId) &&
            const DeepCollectionEquality().equals(
              other._guessedNouns,
              _guessedNouns,
            ) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_playerIds),
    clueGiverId,
    const DeepCollectionEquality().hash(_guessedNouns),
    color,
  );

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(this);
  }
}

abstract class _Team implements Team {
  const factory _Team({
    required final String id,
    required final String name,
    required final List<String> playerIds,
    final String? clueGiverId,
    final List<String> guessedNouns,
    @ColorJsonConverter() required final Color color,
  }) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get playerIds;
  @override
  String? get clueGiverId;
  @override
  List<String> get guessedNouns;
  @override
  @ColorJsonConverter()
  Color get color;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

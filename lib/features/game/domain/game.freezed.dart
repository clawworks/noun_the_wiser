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
  @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
  List<User> get players => throw _privateConstructorUsedError;
  @JsonKey(toJson: _teamListToJson, fromJson: _teamListFromJson)
  List<Team> get teams => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  GamePhase get phase => throw _privateConstructorUsedError;
  int get currentRound => throw _privateConstructorUsedError;
  NounCategory get currentCategory => throw _privateConstructorUsedError;
  String? get currentNoun => throw _privateConstructorUsedError;
  String? get currentQuestion => throw _privateConstructorUsedError;
  String? get currentClue => throw _privateConstructorUsedError;
  String? get currentClueGiverId => throw _privateConstructorUsedError;
  String? get currentTeamId => throw _privateConstructorUsedError;
  List<String> get guessedNouns => throw _privateConstructorUsedError;
  Map<String, List<String>> get teamScores =>
      throw _privateConstructorUsedError;
  Map<String, List<NounCategory>> get teamBadges =>
      throw _privateConstructorUsedError;
  List<GameTurn> get turnHistory => throw _privateConstructorUsedError;
  GameTurn? get currentTurn => throw _privateConstructorUsedError;
  int get turnTimeLimit => throw _privateConstructorUsedError; // seconds
  DateTime? get turnStartTime => throw _privateConstructorUsedError;
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
    @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
    List<User> players,
    @JsonKey(toJson: _teamListToJson, fromJson: _teamListFromJson)
    List<Team> teams,
    GameStatus status,
    GamePhase phase,
    int currentRound,
    NounCategory currentCategory,
    String? currentNoun,
    String? currentQuestion,
    String? currentClue,
    String? currentClueGiverId,
    String? currentTeamId,
    List<String> guessedNouns,
    Map<String, List<String>> teamScores,
    Map<String, List<NounCategory>> teamBadges,
    List<GameTurn> turnHistory,
    GameTurn? currentTurn,
    int turnTimeLimit,
    DateTime? turnStartTime,
    DateTime createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
  });

  $GameTurnCopyWith<$Res>? get currentTurn;
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
    Object? currentCategory = null,
    Object? currentNoun = freezed,
    Object? currentQuestion = freezed,
    Object? currentClue = freezed,
    Object? currentClueGiverId = freezed,
    Object? currentTeamId = freezed,
    Object? guessedNouns = null,
    Object? teamScores = null,
    Object? teamBadges = null,
    Object? turnHistory = null,
    Object? currentTurn = freezed,
    Object? turnTimeLimit = null,
    Object? turnStartTime = freezed,
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
            currentCategory:
                null == currentCategory
                    ? _value.currentCategory
                    : currentCategory // ignore: cast_nullable_to_non_nullable
                        as NounCategory,
            currentNoun:
                freezed == currentNoun
                    ? _value.currentNoun
                    : currentNoun // ignore: cast_nullable_to_non_nullable
                        as String?,
            currentQuestion:
                freezed == currentQuestion
                    ? _value.currentQuestion
                    : currentQuestion // ignore: cast_nullable_to_non_nullable
                        as String?,
            currentClue:
                freezed == currentClue
                    ? _value.currentClue
                    : currentClue // ignore: cast_nullable_to_non_nullable
                        as String?,
            currentClueGiverId:
                freezed == currentClueGiverId
                    ? _value.currentClueGiverId
                    : currentClueGiverId // ignore: cast_nullable_to_non_nullable
                        as String?,
            currentTeamId:
                freezed == currentTeamId
                    ? _value.currentTeamId
                    : currentTeamId // ignore: cast_nullable_to_non_nullable
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
            teamBadges:
                null == teamBadges
                    ? _value.teamBadges
                    : teamBadges // ignore: cast_nullable_to_non_nullable
                        as Map<String, List<NounCategory>>,
            turnHistory:
                null == turnHistory
                    ? _value.turnHistory
                    : turnHistory // ignore: cast_nullable_to_non_nullable
                        as List<GameTurn>,
            currentTurn:
                freezed == currentTurn
                    ? _value.currentTurn
                    : currentTurn // ignore: cast_nullable_to_non_nullable
                        as GameTurn?,
            turnTimeLimit:
                null == turnTimeLimit
                    ? _value.turnTimeLimit
                    : turnTimeLimit // ignore: cast_nullable_to_non_nullable
                        as int,
            turnStartTime:
                freezed == turnStartTime
                    ? _value.turnStartTime
                    : turnStartTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
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

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameTurnCopyWith<$Res>? get currentTurn {
    if (_value.currentTurn == null) {
      return null;
    }

    return $GameTurnCopyWith<$Res>(_value.currentTurn!, (value) {
      return _then(_value.copyWith(currentTurn: value) as $Val);
    });
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
    @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
    List<User> players,
    @JsonKey(toJson: _teamListToJson, fromJson: _teamListFromJson)
    List<Team> teams,
    GameStatus status,
    GamePhase phase,
    int currentRound,
    NounCategory currentCategory,
    String? currentNoun,
    String? currentQuestion,
    String? currentClue,
    String? currentClueGiverId,
    String? currentTeamId,
    List<String> guessedNouns,
    Map<String, List<String>> teamScores,
    Map<String, List<NounCategory>> teamBadges,
    List<GameTurn> turnHistory,
    GameTurn? currentTurn,
    int turnTimeLimit,
    DateTime? turnStartTime,
    DateTime createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
  });

  @override
  $GameTurnCopyWith<$Res>? get currentTurn;
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
    Object? currentCategory = null,
    Object? currentNoun = freezed,
    Object? currentQuestion = freezed,
    Object? currentClue = freezed,
    Object? currentClueGiverId = freezed,
    Object? currentTeamId = freezed,
    Object? guessedNouns = null,
    Object? teamScores = null,
    Object? teamBadges = null,
    Object? turnHistory = null,
    Object? currentTurn = freezed,
    Object? turnTimeLimit = null,
    Object? turnStartTime = freezed,
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
        currentCategory:
            null == currentCategory
                ? _value.currentCategory
                : currentCategory // ignore: cast_nullable_to_non_nullable
                    as NounCategory,
        currentNoun:
            freezed == currentNoun
                ? _value.currentNoun
                : currentNoun // ignore: cast_nullable_to_non_nullable
                    as String?,
        currentQuestion:
            freezed == currentQuestion
                ? _value.currentQuestion
                : currentQuestion // ignore: cast_nullable_to_non_nullable
                    as String?,
        currentClue:
            freezed == currentClue
                ? _value.currentClue
                : currentClue // ignore: cast_nullable_to_non_nullable
                    as String?,
        currentClueGiverId:
            freezed == currentClueGiverId
                ? _value.currentClueGiverId
                : currentClueGiverId // ignore: cast_nullable_to_non_nullable
                    as String?,
        currentTeamId:
            freezed == currentTeamId
                ? _value.currentTeamId
                : currentTeamId // ignore: cast_nullable_to_non_nullable
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
        teamBadges:
            null == teamBadges
                ? _value._teamBadges
                : teamBadges // ignore: cast_nullable_to_non_nullable
                    as Map<String, List<NounCategory>>,
        turnHistory:
            null == turnHistory
                ? _value._turnHistory
                : turnHistory // ignore: cast_nullable_to_non_nullable
                    as List<GameTurn>,
        currentTurn:
            freezed == currentTurn
                ? _value.currentTurn
                : currentTurn // ignore: cast_nullable_to_non_nullable
                    as GameTurn?,
        turnTimeLimit:
            null == turnTimeLimit
                ? _value.turnTimeLimit
                : turnTimeLimit // ignore: cast_nullable_to_non_nullable
                    as int,
        turnStartTime:
            freezed == turnStartTime
                ? _value.turnStartTime
                : turnStartTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
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
    @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
    required final List<User> players,
    @JsonKey(toJson: _teamListToJson, fromJson: _teamListFromJson)
    required final List<Team> teams,
    this.status = GameStatus.waiting,
    this.phase = GamePhase.teamSelection,
    this.currentRound = 1,
    this.currentCategory = NounCategory.person,
    this.currentNoun,
    this.currentQuestion,
    this.currentClue,
    this.currentClueGiverId,
    this.currentTeamId,
    final List<String> guessedNouns = const [],
    final Map<String, List<String>> teamScores = const {},
    final Map<String, List<NounCategory>> teamBadges = const {},
    final List<GameTurn> turnHistory = const [],
    this.currentTurn,
    this.turnTimeLimit = 60,
    this.turnStartTime,
    required this.createdAt,
    this.startedAt,
    this.endedAt,
  }) : _players = players,
       _teams = teams,
       _guessedNouns = guessedNouns,
       _teamScores = teamScores,
       _teamBadges = teamBadges,
       _turnHistory = turnHistory;

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  final String id;
  @override
  final String joinCode;
  final List<User> _players;
  @override
  @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
  List<User> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<Team> _teams;
  @override
  @JsonKey(toJson: _teamListToJson, fromJson: _teamListFromJson)
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
  @JsonKey()
  final NounCategory currentCategory;
  @override
  final String? currentNoun;
  @override
  final String? currentQuestion;
  @override
  final String? currentClue;
  @override
  final String? currentClueGiverId;
  @override
  final String? currentTeamId;
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

  final Map<String, List<NounCategory>> _teamBadges;
  @override
  @JsonKey()
  Map<String, List<NounCategory>> get teamBadges {
    if (_teamBadges is EqualUnmodifiableMapView) return _teamBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_teamBadges);
  }

  final List<GameTurn> _turnHistory;
  @override
  @JsonKey()
  List<GameTurn> get turnHistory {
    if (_turnHistory is EqualUnmodifiableListView) return _turnHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_turnHistory);
  }

  @override
  final GameTurn? currentTurn;
  @override
  @JsonKey()
  final int turnTimeLimit;
  // seconds
  @override
  final DateTime? turnStartTime;
  @override
  final DateTime createdAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;

  @override
  String toString() {
    return 'Game(id: $id, joinCode: $joinCode, players: $players, teams: $teams, status: $status, phase: $phase, currentRound: $currentRound, currentCategory: $currentCategory, currentNoun: $currentNoun, currentQuestion: $currentQuestion, currentClue: $currentClue, currentClueGiverId: $currentClueGiverId, currentTeamId: $currentTeamId, guessedNouns: $guessedNouns, teamScores: $teamScores, teamBadges: $teamBadges, turnHistory: $turnHistory, currentTurn: $currentTurn, turnTimeLimit: $turnTimeLimit, turnStartTime: $turnStartTime, createdAt: $createdAt, startedAt: $startedAt, endedAt: $endedAt)';
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
            (identical(other.currentCategory, currentCategory) ||
                other.currentCategory == currentCategory) &&
            (identical(other.currentNoun, currentNoun) ||
                other.currentNoun == currentNoun) &&
            (identical(other.currentQuestion, currentQuestion) ||
                other.currentQuestion == currentQuestion) &&
            (identical(other.currentClue, currentClue) ||
                other.currentClue == currentClue) &&
            (identical(other.currentClueGiverId, currentClueGiverId) ||
                other.currentClueGiverId == currentClueGiverId) &&
            (identical(other.currentTeamId, currentTeamId) ||
                other.currentTeamId == currentTeamId) &&
            const DeepCollectionEquality().equals(
              other._guessedNouns,
              _guessedNouns,
            ) &&
            const DeepCollectionEquality().equals(
              other._teamScores,
              _teamScores,
            ) &&
            const DeepCollectionEquality().equals(
              other._teamBadges,
              _teamBadges,
            ) &&
            const DeepCollectionEquality().equals(
              other._turnHistory,
              _turnHistory,
            ) &&
            (identical(other.currentTurn, currentTurn) ||
                other.currentTurn == currentTurn) &&
            (identical(other.turnTimeLimit, turnTimeLimit) ||
                other.turnTimeLimit == turnTimeLimit) &&
            (identical(other.turnStartTime, turnStartTime) ||
                other.turnStartTime == turnStartTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    joinCode,
    const DeepCollectionEquality().hash(_players),
    const DeepCollectionEquality().hash(_teams),
    status,
    phase,
    currentRound,
    currentCategory,
    currentNoun,
    currentQuestion,
    currentClue,
    currentClueGiverId,
    currentTeamId,
    const DeepCollectionEquality().hash(_guessedNouns),
    const DeepCollectionEquality().hash(_teamScores),
    const DeepCollectionEquality().hash(_teamBadges),
    const DeepCollectionEquality().hash(_turnHistory),
    currentTurn,
    turnTimeLimit,
    turnStartTime,
    createdAt,
    startedAt,
    endedAt,
  ]);

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
    @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
    required final List<User> players,
    @JsonKey(toJson: _teamListToJson, fromJson: _teamListFromJson)
    required final List<Team> teams,
    final GameStatus status,
    final GamePhase phase,
    final int currentRound,
    final NounCategory currentCategory,
    final String? currentNoun,
    final String? currentQuestion,
    final String? currentClue,
    final String? currentClueGiverId,
    final String? currentTeamId,
    final List<String> guessedNouns,
    final Map<String, List<String>> teamScores,
    final Map<String, List<NounCategory>> teamBadges,
    final List<GameTurn> turnHistory,
    final GameTurn? currentTurn,
    final int turnTimeLimit,
    final DateTime? turnStartTime,
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
  @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
  List<User> get players;
  @override
  @JsonKey(toJson: _teamListToJson, fromJson: _teamListFromJson)
  List<Team> get teams;
  @override
  GameStatus get status;
  @override
  GamePhase get phase;
  @override
  int get currentRound;
  @override
  NounCategory get currentCategory;
  @override
  String? get currentNoun;
  @override
  String? get currentQuestion;
  @override
  String? get currentClue;
  @override
  String? get currentClueGiverId;
  @override
  String? get currentTeamId;
  @override
  List<String> get guessedNouns;
  @override
  Map<String, List<String>> get teamScores;
  @override
  Map<String, List<NounCategory>> get teamBadges;
  @override
  List<GameTurn> get turnHistory;
  @override
  GameTurn? get currentTurn;
  @override
  int get turnTimeLimit; // seconds
  @override
  DateTime? get turnStartTime;
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
  List<NounCategory> get badges => throw _privateConstructorUsedError;
  @ColorJsonConverter()
  Color get color => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

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
    List<NounCategory> badges,
    @ColorJsonConverter() Color color,
    int score,
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
    Object? badges = null,
    Object? color = null,
    Object? score = null,
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
            badges:
                null == badges
                    ? _value.badges
                    : badges // ignore: cast_nullable_to_non_nullable
                        as List<NounCategory>,
            color:
                null == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as Color,
            score:
                null == score
                    ? _value.score
                    : score // ignore: cast_nullable_to_non_nullable
                        as int,
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
    List<NounCategory> badges,
    @ColorJsonConverter() Color color,
    int score,
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
    Object? badges = null,
    Object? color = null,
    Object? score = null,
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
        badges:
            null == badges
                ? _value._badges
                : badges // ignore: cast_nullable_to_non_nullable
                    as List<NounCategory>,
        color:
            null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as Color,
        score:
            null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                    as int,
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
    final List<NounCategory> badges = const [],
    @ColorJsonConverter() required this.color,
    this.score = 0,
  }) : _playerIds = playerIds,
       _guessedNouns = guessedNouns,
       _badges = badges;

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

  final List<NounCategory> _badges;
  @override
  @JsonKey()
  List<NounCategory> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  @override
  @ColorJsonConverter()
  final Color color;
  @override
  @JsonKey()
  final int score;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, playerIds: $playerIds, clueGiverId: $clueGiverId, guessedNouns: $guessedNouns, badges: $badges, color: $color, score: $score)';
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
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.score, score) || other.score == score));
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
    const DeepCollectionEquality().hash(_badges),
    color,
    score,
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
    final List<NounCategory> badges,
    @ColorJsonConverter() required final Color color,
    final int score,
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
  List<NounCategory> get badges;
  @override
  @ColorJsonConverter()
  Color get color;
  @override
  int get score;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameTurn _$GameTurnFromJson(Map<String, dynamic> json) {
  return _GameTurn.fromJson(json);
}

/// @nodoc
mixin _$GameTurn {
  String get id => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get clueGiverId => throw _privateConstructorUsedError;
  NounCategory get category => throw _privateConstructorUsedError;
  String get noun => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String? get clue => throw _privateConstructorUsedError;
  String? get guess => throw _privateConstructorUsedError;
  bool? get isCorrect => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  int get timeLimit => throw _privateConstructorUsedError;

  /// Serializes this GameTurn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameTurn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameTurnCopyWith<GameTurn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameTurnCopyWith<$Res> {
  factory $GameTurnCopyWith(GameTurn value, $Res Function(GameTurn) then) =
      _$GameTurnCopyWithImpl<$Res, GameTurn>;
  @useResult
  $Res call({
    String id,
    String teamId,
    String clueGiverId,
    NounCategory category,
    String noun,
    String question,
    String? clue,
    String? guess,
    bool? isCorrect,
    DateTime startTime,
    DateTime? endTime,
    int timeLimit,
  });
}

/// @nodoc
class _$GameTurnCopyWithImpl<$Res, $Val extends GameTurn>
    implements $GameTurnCopyWith<$Res> {
  _$GameTurnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameTurn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teamId = null,
    Object? clueGiverId = null,
    Object? category = null,
    Object? noun = null,
    Object? question = null,
    Object? clue = freezed,
    Object? guess = freezed,
    Object? isCorrect = freezed,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? timeLimit = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            teamId:
                null == teamId
                    ? _value.teamId
                    : teamId // ignore: cast_nullable_to_non_nullable
                        as String,
            clueGiverId:
                null == clueGiverId
                    ? _value.clueGiverId
                    : clueGiverId // ignore: cast_nullable_to_non_nullable
                        as String,
            category:
                null == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as NounCategory,
            noun:
                null == noun
                    ? _value.noun
                    : noun // ignore: cast_nullable_to_non_nullable
                        as String,
            question:
                null == question
                    ? _value.question
                    : question // ignore: cast_nullable_to_non_nullable
                        as String,
            clue:
                freezed == clue
                    ? _value.clue
                    : clue // ignore: cast_nullable_to_non_nullable
                        as String?,
            guess:
                freezed == guess
                    ? _value.guess
                    : guess // ignore: cast_nullable_to_non_nullable
                        as String?,
            isCorrect:
                freezed == isCorrect
                    ? _value.isCorrect
                    : isCorrect // ignore: cast_nullable_to_non_nullable
                        as bool?,
            startTime:
                null == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            endTime:
                freezed == endTime
                    ? _value.endTime
                    : endTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            timeLimit:
                null == timeLimit
                    ? _value.timeLimit
                    : timeLimit // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameTurnImplCopyWith<$Res>
    implements $GameTurnCopyWith<$Res> {
  factory _$$GameTurnImplCopyWith(
    _$GameTurnImpl value,
    $Res Function(_$GameTurnImpl) then,
  ) = __$$GameTurnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String teamId,
    String clueGiverId,
    NounCategory category,
    String noun,
    String question,
    String? clue,
    String? guess,
    bool? isCorrect,
    DateTime startTime,
    DateTime? endTime,
    int timeLimit,
  });
}

/// @nodoc
class __$$GameTurnImplCopyWithImpl<$Res>
    extends _$GameTurnCopyWithImpl<$Res, _$GameTurnImpl>
    implements _$$GameTurnImplCopyWith<$Res> {
  __$$GameTurnImplCopyWithImpl(
    _$GameTurnImpl _value,
    $Res Function(_$GameTurnImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameTurn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teamId = null,
    Object? clueGiverId = null,
    Object? category = null,
    Object? noun = null,
    Object? question = null,
    Object? clue = freezed,
    Object? guess = freezed,
    Object? isCorrect = freezed,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? timeLimit = null,
  }) {
    return _then(
      _$GameTurnImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        teamId:
            null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                    as String,
        clueGiverId:
            null == clueGiverId
                ? _value.clueGiverId
                : clueGiverId // ignore: cast_nullable_to_non_nullable
                    as String,
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as NounCategory,
        noun:
            null == noun
                ? _value.noun
                : noun // ignore: cast_nullable_to_non_nullable
                    as String,
        question:
            null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                    as String,
        clue:
            freezed == clue
                ? _value.clue
                : clue // ignore: cast_nullable_to_non_nullable
                    as String?,
        guess:
            freezed == guess
                ? _value.guess
                : guess // ignore: cast_nullable_to_non_nullable
                    as String?,
        isCorrect:
            freezed == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                    as bool?,
        startTime:
            null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        endTime:
            freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        timeLimit:
            null == timeLimit
                ? _value.timeLimit
                : timeLimit // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameTurnImpl implements _GameTurn {
  const _$GameTurnImpl({
    required this.id,
    required this.teamId,
    required this.clueGiverId,
    required this.category,
    required this.noun,
    required this.question,
    this.clue,
    this.guess,
    this.isCorrect,
    required this.startTime,
    this.endTime,
    this.timeLimit = 60,
  });

  factory _$GameTurnImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameTurnImplFromJson(json);

  @override
  final String id;
  @override
  final String teamId;
  @override
  final String clueGiverId;
  @override
  final NounCategory category;
  @override
  final String noun;
  @override
  final String question;
  @override
  final String? clue;
  @override
  final String? guess;
  @override
  final bool? isCorrect;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  @JsonKey()
  final int timeLimit;

  @override
  String toString() {
    return 'GameTurn(id: $id, teamId: $teamId, clueGiverId: $clueGiverId, category: $category, noun: $noun, question: $question, clue: $clue, guess: $guess, isCorrect: $isCorrect, startTime: $startTime, endTime: $endTime, timeLimit: $timeLimit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameTurnImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.clueGiverId, clueGiverId) ||
                other.clueGiverId == clueGiverId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.noun, noun) || other.noun == noun) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.clue, clue) || other.clue == clue) &&
            (identical(other.guess, guess) || other.guess == guess) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.timeLimit, timeLimit) ||
                other.timeLimit == timeLimit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    teamId,
    clueGiverId,
    category,
    noun,
    question,
    clue,
    guess,
    isCorrect,
    startTime,
    endTime,
    timeLimit,
  );

  /// Create a copy of GameTurn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameTurnImplCopyWith<_$GameTurnImpl> get copyWith =>
      __$$GameTurnImplCopyWithImpl<_$GameTurnImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameTurnImplToJson(this);
  }
}

abstract class _GameTurn implements GameTurn {
  const factory _GameTurn({
    required final String id,
    required final String teamId,
    required final String clueGiverId,
    required final NounCategory category,
    required final String noun,
    required final String question,
    final String? clue,
    final String? guess,
    final bool? isCorrect,
    required final DateTime startTime,
    final DateTime? endTime,
    final int timeLimit,
  }) = _$GameTurnImpl;

  factory _GameTurn.fromJson(Map<String, dynamic> json) =
      _$GameTurnImpl.fromJson;

  @override
  String get id;
  @override
  String get teamId;
  @override
  String get clueGiverId;
  @override
  NounCategory get category;
  @override
  String get noun;
  @override
  String get question;
  @override
  String? get clue;
  @override
  String? get guess;
  @override
  bool? get isCorrect;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  int get timeLimit;

  /// Create a copy of GameTurn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameTurnImplCopyWith<_$GameTurnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Noun _$NounFromJson(Map<String, dynamic> json) {
  return _Noun.fromJson(json);
}

/// @nodoc
mixin _$Noun {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  NounCategory get category => throw _privateConstructorUsedError;
  String get pack => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this Noun to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Noun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NounCopyWith<Noun> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NounCopyWith<$Res> {
  factory $NounCopyWith(Noun value, $Res Function(Noun) then) =
      _$NounCopyWithImpl<$Res, Noun>;
  @useResult
  $Res call({
    String id,
    String name,
    NounCategory category,
    String pack,
    List<String> tags,
  });
}

/// @nodoc
class _$NounCopyWithImpl<$Res, $Val extends Noun>
    implements $NounCopyWith<$Res> {
  _$NounCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Noun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? pack = null,
    Object? tags = null,
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
            category:
                null == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as NounCategory,
            pack:
                null == pack
                    ? _value.pack
                    : pack // ignore: cast_nullable_to_non_nullable
                        as String,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NounImplCopyWith<$Res> implements $NounCopyWith<$Res> {
  factory _$$NounImplCopyWith(
    _$NounImpl value,
    $Res Function(_$NounImpl) then,
  ) = __$$NounImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    NounCategory category,
    String pack,
    List<String> tags,
  });
}

/// @nodoc
class __$$NounImplCopyWithImpl<$Res>
    extends _$NounCopyWithImpl<$Res, _$NounImpl>
    implements _$$NounImplCopyWith<$Res> {
  __$$NounImplCopyWithImpl(_$NounImpl _value, $Res Function(_$NounImpl) _then)
    : super(_value, _then);

  /// Create a copy of Noun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? pack = null,
    Object? tags = null,
  }) {
    return _then(
      _$NounImpl(
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
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as NounCategory,
        pack:
            null == pack
                ? _value.pack
                : pack // ignore: cast_nullable_to_non_nullable
                    as String,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NounImpl implements _Noun {
  const _$NounImpl({
    required this.id,
    required this.name,
    required this.category,
    required this.pack,
    final List<String> tags = const [],
  }) : _tags = tags;

  factory _$NounImpl.fromJson(Map<String, dynamic> json) =>
      _$$NounImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final NounCategory category;
  @override
  final String pack;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Noun(id: $id, name: $name, category: $category, pack: $pack, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NounImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.pack, pack) || other.pack == pack) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    pack,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of Noun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NounImplCopyWith<_$NounImpl> get copyWith =>
      __$$NounImplCopyWithImpl<_$NounImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NounImplToJson(this);
  }
}

abstract class _Noun implements Noun {
  const factory _Noun({
    required final String id,
    required final String name,
    required final NounCategory category,
    required final String pack,
    final List<String> tags,
  }) = _$NounImpl;

  factory _Noun.fromJson(Map<String, dynamic> json) = _$NounImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  NounCategory get category;
  @override
  String get pack;
  @override
  List<String> get tags;

  /// Create a copy of Noun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NounImplCopyWith<_$NounImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get pack => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call({String id, String text, String pack, List<String> tags});
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? pack = null,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
            pack:
                null == pack
                    ? _value.pack
                    : pack // ignore: cast_nullable_to_non_nullable
                        as String,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
    _$QuestionImpl value,
    $Res Function(_$QuestionImpl) then,
  ) = __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, String pack, List<String> tags});
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
    _$QuestionImpl _value,
    $Res Function(_$QuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? pack = null,
    Object? tags = null,
  }) {
    return _then(
      _$QuestionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        pack:
            null == pack
                ? _value.pack
                : pack // ignore: cast_nullable_to_non_nullable
                    as String,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionImpl implements _Question {
  const _$QuestionImpl({
    required this.id,
    required this.text,
    required this.pack,
    final List<String> tags = const [],
  }) : _tags = tags;

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String pack;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Question(id: $id, text: $text, pack: $pack, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.pack, pack) || other.pack == pack) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    pack,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(this);
  }
}

abstract class _Question implements Question {
  const factory _Question({
    required final String id,
    required final String text,
    required final String pack,
    final List<String> tags,
  }) = _$QuestionImpl;

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get pack;
  @override
  List<String> get tags;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

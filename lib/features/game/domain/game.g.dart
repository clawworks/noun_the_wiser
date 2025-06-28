// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
  id: json['id'] as String,
  joinCode: json['joinCode'] as String,
  players: _userListFromJson(json['players'] as List),
  teams:
      (json['teams'] as List<dynamic>)
          .map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList(),
  status:
      $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
      GameStatus.waiting,
  phase:
      $enumDecodeNullable(_$GamePhaseEnumMap, json['phase']) ??
      GamePhase.teamSelection,
  currentRound: (json['currentRound'] as num?)?.toInt() ?? 1,
  currentCategory:
      $enumDecodeNullable(_$NounCategoryEnumMap, json['currentCategory']) ??
      NounCategory.person,
  currentNoun: json['currentNoun'] as String?,
  currentQuestion: json['currentQuestion'] as String?,
  currentClue: json['currentClue'] as String?,
  currentClueGiverId: json['currentClueGiverId'] as String?,
  currentTeamId: json['currentTeamId'] as String?,
  guessedNouns:
      (json['guessedNouns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  teamScores:
      (json['teamScores'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  teamBadges:
      (json['teamBadges'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map((e) => $enumDecode(_$NounCategoryEnumMap, e))
              .toList(),
        ),
      ) ??
      const {},
  turnHistory:
      (json['turnHistory'] as List<dynamic>?)
          ?.map((e) => GameTurn.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentTurn:
      json['currentTurn'] == null
          ? null
          : GameTurn.fromJson(json['currentTurn'] as Map<String, dynamic>),
  turnTimeLimit: (json['turnTimeLimit'] as num?)?.toInt() ?? 60,
  turnStartTime:
      json['turnStartTime'] == null
          ? null
          : DateTime.parse(json['turnStartTime'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  startedAt:
      json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
  endedAt:
      json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
);

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'joinCode': instance.joinCode,
      'players': _userListToJson(instance.players),
      'teams': instance.teams,
      'status': _$GameStatusEnumMap[instance.status]!,
      'phase': _$GamePhaseEnumMap[instance.phase]!,
      'currentRound': instance.currentRound,
      'currentCategory': _$NounCategoryEnumMap[instance.currentCategory]!,
      'currentNoun': instance.currentNoun,
      'currentQuestion': instance.currentQuestion,
      'currentClue': instance.currentClue,
      'currentClueGiverId': instance.currentClueGiverId,
      'currentTeamId': instance.currentTeamId,
      'guessedNouns': instance.guessedNouns,
      'teamScores': instance.teamScores,
      'teamBadges': instance.teamBadges.map(
        (k, e) => MapEntry(k, e.map((e) => _$NounCategoryEnumMap[e]!).toList()),
      ),
      'turnHistory': instance.turnHistory,
      'currentTurn': instance.currentTurn,
      'turnTimeLimit': instance.turnTimeLimit,
      'turnStartTime': instance.turnStartTime?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
    };

const _$GameStatusEnumMap = {
  GameStatus.waiting: 'waiting',
  GameStatus.teamAssignment: 'teamAssignment',
  GameStatus.inProgress: 'inProgress',
  GameStatus.finished: 'finished',
};

const _$GamePhaseEnumMap = {
  GamePhase.teamSelection: 'teamSelection',
  GamePhase.clueGiverSelection: 'clueGiverSelection',
  GamePhase.nounSelection: 'nounSelection',
  GamePhase.questionSelection: 'questionSelection',
  GamePhase.clueGiving: 'clueGiving',
  GamePhase.guessing: 'guessing',
  GamePhase.roundEnd: 'roundEnd',
  GamePhase.gameEnd: 'gameEnd',
};

const _$NounCategoryEnumMap = {
  NounCategory.person: 'person',
  NounCategory.place: 'place',
  NounCategory.thing: 'thing',
};

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  playerIds:
      (json['playerIds'] as List<dynamic>).map((e) => e as String).toList(),
  clueGiverId: json['clueGiverId'] as String?,
  guessedNouns:
      (json['guessedNouns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  badges:
      (json['badges'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$NounCategoryEnumMap, e))
          .toList() ??
      const [],
  color: const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  score: (json['score'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'playerIds': instance.playerIds,
      'clueGiverId': instance.clueGiverId,
      'guessedNouns': instance.guessedNouns,
      'badges': instance.badges.map((e) => _$NounCategoryEnumMap[e]!).toList(),
      'color': const ColorJsonConverter().toJson(instance.color),
      'score': instance.score,
    };

_$GameTurnImpl _$$GameTurnImplFromJson(Map<String, dynamic> json) =>
    _$GameTurnImpl(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      clueGiverId: json['clueGiverId'] as String,
      category: $enumDecode(_$NounCategoryEnumMap, json['category']),
      noun: json['noun'] as String,
      question: json['question'] as String,
      clue: json['clue'] as String?,
      guess: json['guess'] as String?,
      isCorrect: json['isCorrect'] as bool?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime:
          json['endTime'] == null
              ? null
              : DateTime.parse(json['endTime'] as String),
      timeLimit: (json['timeLimit'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$$GameTurnImplToJson(_$GameTurnImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamId': instance.teamId,
      'clueGiverId': instance.clueGiverId,
      'category': _$NounCategoryEnumMap[instance.category]!,
      'noun': instance.noun,
      'question': instance.question,
      'clue': instance.clue,
      'guess': instance.guess,
      'isCorrect': instance.isCorrect,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'timeLimit': instance.timeLimit,
    };

_$NounImpl _$$NounImplFromJson(Map<String, dynamic> json) => _$NounImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  category: $enumDecode(_$NounCategoryEnumMap, json['category']),
  pack: json['pack'] as String,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$NounImplToJson(_$NounImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$NounCategoryEnumMap[instance.category]!,
      'pack': instance.pack,
      'tags': instance.tags,
    };

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      pack: json['pack'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'pack': instance.pack,
      'tags': instance.tags,
    };

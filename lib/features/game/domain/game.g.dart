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
  currentClueGiverId: json['currentClueGiverId'] as String?,
  currentCategory: json['currentCategory'] as String? ?? 'Person',
  currentNoun: json['currentNoun'] as String?,
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
      'currentClueGiverId': instance.currentClueGiverId,
      'currentCategory': instance.currentCategory,
      'currentNoun': instance.currentNoun,
      'guessedNouns': instance.guessedNouns,
      'teamScores': instance.teamScores,
      'createdAt': instance.createdAt.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
    };

const _$GameStatusEnumMap = {
  GameStatus.waiting: 'waiting',
  GameStatus.inProgress: 'inProgress',
  GameStatus.finished: 'finished',
};

const _$GamePhaseEnumMap = {
  GamePhase.teamSelection: 'teamSelection',
  GamePhase.clueGiving: 'clueGiving',
  GamePhase.guessing: 'guessing',
  GamePhase.roundEnd: 'roundEnd',
  GamePhase.gameEnd: 'gameEnd',
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
  color: const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
);

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'playerIds': instance.playerIds,
      'clueGiverId': instance.clueGiverId,
      'guessedNouns': instance.guessedNouns,
      'color': const ColorJsonConverter().toJson(instance.color),
    };

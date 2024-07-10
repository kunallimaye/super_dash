// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_dash/game/bloc/game_bloc.dart';

void main() {
  group('GameBloc', () {
    blocTest<GameBloc, GameState>(
      'emits GameState initial when GameOver is added',
      build: () => GameBloc(User.unauthenticated),
      seed: () => const GameState(
        score: 100,
        currentLevel: 2,
        currentSection: 2,
        currentUser: User.unauthenticated,
      ),
      act: (bloc) => bloc.add(GameOver()),
      expect: () => const [GameState.initial()],
    );

    blocTest<GameBloc, GameState>(
      'emits GameState with score increased correctly '
      'when GameScoreIncreased is added',
      build: () => GameBloc(User.unauthenticated),
      seed: () => const GameState.initial().copyWith(score: 100),
      act: (bloc) => bloc.add(GameScoreIncreased(by: 2)),
      expect: () => [const GameState.initial().copyWith(score: 102)],
    );

    blocTest<GameBloc, GameState>(
      'emits GameState with score decreased correctly '
      'when GameScoreDecreased is added',
      build: () => GameBloc(User.unauthenticated),
      seed: () => const GameState.initial().copyWith(score: 100),
      act: (bloc) => bloc.add(GameScoreDecreased(by: 2)),
      expect: () => [const GameState.initial().copyWith(score: 98)],
    );
  });
}

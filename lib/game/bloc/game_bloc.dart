import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:super_dash/game/game.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(User? user)
      : super(const GameState.initial().copyWith(currentUser: user)) {
    on<GameScoreIncreased>(_onGameScoreIncreased);
    on<GameScoreDecreased>(_onGameScoreDecreased);
    on<GameOver>(_onGameOver);
    on<GameSectionCompleted>(_onGameSectionCompleted);
    on<GameItemCollected>(_onGameItemCollected);
  }

  void _onGameItemCollected(
    GameItemCollected event,
    Emitter<GameState> emit,
  ) {
    print('User [${state.currentUser.id}] collected ${event.itemType}');
    emit(state);
  }

  void _onGameScoreIncreased(
    GameScoreIncreased event,
    Emitter<GameState> emit,
  ) {
    print(
      'Increasing pts for user ${state.currentUser.id} by ${event.by}',
    );
    emit(
      state.copyWith(
        score: state.score + event.by,
      ),
    );
  }

  void _onGameScoreDecreased(
    GameScoreDecreased event,
    Emitter<GameState> emit,
  ) {
    emit(
      state.copyWith(
        score: state.score - event.by,
      ),
    );
  }

  void _onGameOver(
    GameOver event,
    Emitter<GameState> emit,
  ) {
    emit(const GameState.initial());
  }

  void _onGameSectionCompleted(
    GameSectionCompleted event,
    Emitter<GameState> emit,
  ) {
    if (state.currentSection < event.sectionCount - 1) {
      emit(
        state.copyWith(
          currentSection: state.currentSection + 1,
        ),
      );
    } else {
      emit(
        state.copyWith(
          currentSection: 0,
          currentLevel: state.currentLevel + 1,
        ),
      );
    }
  }
}

import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
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
  final channel = WebSocketChannel.connect(
      Uri.parse('wss://item-collected-2rejqy6csq-uc.a.run.app'));
  // final String functionName = 'SendToPubsub';

  // Future<http.Response> sendToPubsub(
  //   String playerID,
  //   String itemType,
  //   String points,
  // ) async {
  //   final response = await http.post(
  //     Uri.parse(
  //         'https://us-central1-kunal-scratch.cloudfunctions.net/SendToPubsub'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'action': 'transfer',
  //       'itemType': itemType,
  //       'playerID': playerID,
  //       'points': points,
  //     }),
  //   );

  //   return response;

  //   // try {
  //   //   FirebaseFunctions.instance.httpsCallable(functionName).call({
  //   //     'action': 'transfer',
  //   //     'itemType': itemType,
  //   //     'playerID': playerID,
  //   //     'points': points,
  //   //   });
  //   // } on FirebaseFunctionsException catch (error) {
  //   //   print(error.message);
  //   // }
  // }

  void _onGameItemCollected(
    GameItemCollected event,
    Emitter<GameState> emit,
  ) {
    print('User [${state.currentUser.id}] collected ${event.itemType}');
    emit(state);
    // sendToPubsub(state.currentUser.id, event.itemType as String, '0');
    channel.sink.add(
      jsonEncode(<String, String>{
        'action': 'transfer',
        'itemType': '${event.itemType}',
        'playerID': state.currentUser.id,
        'points': '',
      }),
    );
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
    // sendToPubsub(state.currentUser.id, ',', event.by as String);
    channel.sink.add(
      jsonEncode(<String, String>{
        'action': 'transfer',
        'itemType': '',
        'playerID': state.currentUser.id,
        'points': '${event.by}',
      }),
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

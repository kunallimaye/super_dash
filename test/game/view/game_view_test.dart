// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_dash/game/game.dart';
import 'package:super_dash/l10n/l10n.dart';
import 'package:super_dash/settings/settings.dart';

import '../../helpers/helpers.dart';

class _MockGameBloc extends MockBloc<GameEvent, GameState>
    implements GameBloc {}

class _MockSettingsController extends Mock implements SettingsController {}

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late SettingsController settingsController;
  late AuthenticationRepository authenticationRespository;

  setUp(() {
    settingsController = _MockSettingsController();
    authenticationRespository = _MockAuthenticationRepository();
    when(() => settingsController.muted).thenReturn(ValueNotifier(true));
    when(() => authenticationRespository.currentUser)
        .thenReturn(User.unauthenticated);
  });

  group('Game', () {
    test('is routable', () {
      expect(Game.route(), isA<PageRoute<void>>());
    });

    testWidgets('renders GameView', (tester) async {
      await tester.pumpApp(
        Game(),
        settingsController: settingsController,
      );

      expect(find.byType(GameView), findsOneWidget);
    });
  });

  group('GameView', () {
    late GameBloc gameBloc;

    setUp(() => gameBloc = _MockGameBloc());

    Widget buildSubject() {
      return BlocProvider.value(
        value: gameBloc,
        child: const GameView(),
      );
    }

    testWidgets('renders score', (tester) async {
      when(() => gameBloc.state).thenReturn(GameState.initial());

      await tester.pumpApp(
        buildSubject(),
        settingsController: settingsController,
        authenticationRespository: authenticationRespository,
      );

      final context = tester.element(find.byType(ScoreLabel));

      expect(
        find.text(
          context.l10n.gameScoreLabel(gameBloc.state.score),
        ),
        findsOneWidget,
      );
    });
  });
}

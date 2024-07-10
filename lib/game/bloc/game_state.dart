part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.score,
    required this.currentLevel,
    required this.currentSection,
    required this.currentUser,
  });

  const GameState.initial()
      : score = 0,
        currentLevel = 1,
        currentSection = 0,
        currentUser = User.unauthenticated;

  final int score;
  final int currentLevel;
  final int currentSection;
  final User currentUser;

  GameState copyWith({
    int? score,
    int? currentLevel,
    int? currentSection,
    User? currentUser,
  }) {
    return GameState(
      score: score ?? this.score,
      currentLevel: currentLevel ?? this.currentLevel,
      currentSection: currentSection ?? this.currentSection,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object?> get props => [score, currentLevel, currentSection, currentUser];
}

import 'package:equatable/equatable.dart';

class Mood extends Equatable {
  final String key;
  final String emoji;

  const Mood({
    required this.key,
    required this.emoji,
  });

  @override
  List<Object?> get props => [key, emoji];
}

class Moods {
  static const List<Mood> list = [
    Mood(key: "crying", emoji: "😢"),
    Mood(key: "sad", emoji: "😔"),
    Mood(key: "angry", emoji: "😡"),
    Mood(key: "neutral", emoji: "😐"),
    Mood(key: "happy", emoji: "😊"),
  ];
}

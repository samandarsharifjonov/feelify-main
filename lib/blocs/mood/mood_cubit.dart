import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/mood.dart';

part 'mood_state.dart';

class MoodCubit extends Cubit<MoodState> {
  MoodCubit()
      : super(MoodState(
          selectedMood: Moods.list.last,
          description: '',
        ));

  void selectMood(Mood mood) {
    emit(MoodState(selectedMood: mood, description: state.description));
  }

  void updateDescription(String description) {
    emit(MoodState(selectedMood: state.selectedMood, description: description));
  }
}

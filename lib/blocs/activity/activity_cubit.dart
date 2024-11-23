
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/activity.dart';
import '../../models/mood.dart';
import '../../repository/activity_repository.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository repository;

  ActivityCubit(this.repository) : super(ActivityState());

  void getRecommendation(Mood mood, String description) async {
    final activity = await repository.fetchActivity(mood, description);
    emit(ActivityState(activity: activity));
  }

  void likeActivity() {
    emit(ActivityState(activity: state.activity, isLiked: true));
  }

  void dislikeActivity(Mood mood, String description) async {
    final newActivity = await repository.fetchActivity(mood, description);
    emit(ActivityState(activity: newActivity, isLiked: false));
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/activity/activity_cubit.dart';
import '../blocs/mood/mood_cubit.dart';
import '../repository/activity_repository.dart';

class ActivityRecommendationScreen extends StatelessWidget {
  final MoodState moodState;

  const ActivityRecommendationScreen({super.key, required this.moodState});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityCubit(ActivityRepository())
        ..getRecommendation(moodState.selectedMood, moodState.description),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Mashg'ulot tavsiyasi",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<ActivityCubit, ActivityState>(
          builder: (context, state) {
            if (state.activity == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      "Sizga mos mashg'ulot tanlanmoqda...",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Mood Indicator
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text(
                            moodState.selectedMood.emoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Sizning kayfiyatingizga mos tavsiya",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Activity Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Activity Title
                          Text(
                            state.activity!.activity,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Duration
                          _buildInfoRow(
                            Icons.timer_outlined,
                            "${state.activity!.duration} daqiqa",
                            Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 16),

                          // Price
                          _buildInfoRow(
                            Icons.payments_outlined,
                            "${state.activity!.price} so'm",
                            Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Feedback Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                context.read<ActivityCubit>().dislikeActivity(
                                      moodState.selectedMood,
                                      moodState.description,
                                    ),
                            icon: const Icon(Icons.thumb_down_outlined),
                            label: const Text("Boshqa tavsiya"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                context.read<ActivityCubit>().likeActivity(),
                            icon: const Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Menga yoqdi",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

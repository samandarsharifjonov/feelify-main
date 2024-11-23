import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/mood/mood_cubit.dart';
import '../models/mood.dart';
import 'activity_recommendation_screen.dart';

class MoodSelectionScreen extends StatelessWidget {
  const MoodSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Kayfiyatingizni tanlang",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Bugun o'zingizni qanday his qilyapsiz?",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: Moods.list
                      .map(
                        (mood) => Expanded(
                          child: _buildMoodButton(context, mood),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                onChanged: (value) =>
                    context.read<MoodCubit>().updateDescription(value),
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Nima uchun shunday his qilyapsiz?",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  final moodState = context.read<MoodCubit>().state;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ActivityRecommendationScreen(moodState: moodState),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Tavsiya olish",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton(BuildContext context, Mood mood) {
    return BlocBuilder<MoodCubit, MoodState>(
      builder: (context, state) {
        final isSelected = state.selectedMood == mood;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => context.read<MoodCubit>().selectMood(mood),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      mood.emoji,
                      style: TextStyle(
                        fontSize: isSelected ? 40 : 32,
                      ),
                    ),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.black54,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      child: Text(mood.key.tr(context: context)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

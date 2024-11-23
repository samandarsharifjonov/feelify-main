import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/activity.dart';
import '../models/mood.dart';

class ActivityRepository {
  Future<Activity> fetchActivity(Mood mood, String description) async {
    try {
      final apiKey = dotenv.env['GOOGLE_GENERATIVE_AI_API_KEY'];
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey ?? '',
      );

      final prompt = _buildPrompt(mood, description);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      final data = jsonDecode(response.text ?? '{}');
      final activity = Activity.fromMap(data);
      return activity;
    } catch (e) {
      rethrow;
    }
  }

  String _buildPrompt(Mood mood, String description) {
    return """
The user is currently experiencing the mood: $mood. 
Description provided by the user: "$description". 

Based on this mood and description, suggest an activity that would be most suitable to improve or match the user's current state. Provide details in the following structured format:

- activity: (a specific activity that suits the user's mood)
- interesting_fact: (a unique or fun fact related to the activity, if available)
- type: (e.g., education, entertainment, relaxation, physical, social)
- participants: (how many people are needed for this activity, e.g., 1 person)
- price: (cost in Uzbekistani so'm)
- duration: (time required to complete the activity in minutes)
- link: (a URL link for more information or resources related to the activity)

Ensure that the response is precise, engaging, and aligned with the mood described. Avoid vague suggestions; focus on practical and actionable activities.
Remember to provide the suggestion in Uzbek language and the following format: 
 {
  "activity": "Yangi muzqaymoq olish",
  "interesting_fact": "Dunyo bo'ylab 200 dan ortiq muzqaymoq lazzatlari mavjud!",
  "type": "Entertainment",
  "participants": "1 kishi",
  "price": "10,000 so'm dan",
  "duration": "30 minut",
  "link": "https://www.google.com/search?q=muzqaymoq+do'konlari+yaqinimda" 
}
Pay attention to quotation marks.
""";
  }
}

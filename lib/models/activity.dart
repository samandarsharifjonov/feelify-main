import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String activity;
  final String interestingFact;
  final String type;
  final String participants;
  final String price;
  final String duration; // qo'shildi
  final String link;

  const Activity({
    required this.activity,
    required this.interestingFact,
    required this.type,
    required this.participants,
    required this.price,
    required this.duration,
    required this.link,
  });

  Activity copyWith({
    String? activity,
    String? interestingFact,
    String? type,
    String? participants,
    String? price,
    String? duration,
    String? link,
  }) {
    return Activity(
      activity: activity ?? this.activity,
      interestingFact: interestingFact ?? this.interestingFact,
      type: type ?? this.type,
      participants: participants ?? this.participants,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      link: link ?? this.link,
    );
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      activity: map['activity'],
      interestingFact: map['interesting_fact'],
      type: map['type'],
      participants: map['participants'],
      price: map['price'],
      duration: map['duration'],
      link: map['link'],
    );
  }

  @override
  List<Object?> get props => [
        activity,
        interestingFact,
        type,
        participants,
        price,
        duration,
        link,
      ];
}

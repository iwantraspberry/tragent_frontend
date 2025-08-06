import 'package:json_annotation/json_annotation.dart';

part 'travel_plan.g.dart';

@JsonSerializable()
class TravelPlan {
  final String id;
  final String title;
  final String description;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final double? budget;
  final String status; // draft, confirmed, completed
  final List<TravelActivity> activities;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TravelPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.destination,
    required this.startDate,
    required this.endDate,
    this.budget,
    required this.status,
    required this.activities,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TravelPlan.fromJson(Map<String, dynamic> json) =>
      _$TravelPlanFromJson(json);
  Map<String, dynamic> toJson() => _$TravelPlanToJson(this);
}

@JsonSerializable()
class TravelActivity {
  final String id;
  final String title;
  final String description;
  final String? location;
  final DateTime? scheduledTime;
  final double? cost;
  final String category; // sightseeing, dining, accommodation, transport
  final bool isBooked;

  const TravelActivity({
    required this.id,
    required this.title,
    required this.description,
    this.location,
    this.scheduledTime,
    this.cost,
    required this.category,
    required this.isBooked,
  });

  factory TravelActivity.fromJson(Map<String, dynamic> json) =>
      _$TravelActivityFromJson(json);
  Map<String, dynamic> toJson() => _$TravelActivityToJson(this);
}

@JsonSerializable()
class TravelDestination {
  final String id;
  final String name;
  final String country;
  final String description;
  final String? imageUrl;
  final double? rating;
  final List<String> tags;
  final String? currency;
  final String? timezone;

  const TravelDestination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    this.imageUrl,
    this.rating,
    required this.tags,
    this.currency,
    this.timezone,
  });

  factory TravelDestination.fromJson(Map<String, dynamic> json) =>
      _$TravelDestinationFromJson(json);
  Map<String, dynamic> toJson() => _$TravelDestinationToJson(this);
}

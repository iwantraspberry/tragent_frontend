// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelPlan _$TravelPlanFromJson(Map<String, dynamic> json) => TravelPlan(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  destination: json['destination'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  budget: (json['budget'] as num?)?.toDouble(),
  status: json['status'] as String,
  activities: (json['activities'] as List<dynamic>)
      .map((e) => TravelActivity.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TravelPlanToJson(TravelPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'destination': instance.destination,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'budget': instance.budget,
      'status': instance.status,
      'activities': instance.activities,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

TravelActivity _$TravelActivityFromJson(Map<String, dynamic> json) =>
    TravelActivity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String?,
      scheduledTime: json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String),
      cost: (json['cost'] as num?)?.toDouble(),
      category: json['category'] as String,
      isBooked: json['isBooked'] as bool,
    );

Map<String, dynamic> _$TravelActivityToJson(TravelActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'scheduledTime': instance.scheduledTime?.toIso8601String(),
      'cost': instance.cost,
      'category': instance.category,
      'isBooked': instance.isBooked,
    };

TravelDestination _$TravelDestinationFromJson(Map<String, dynamic> json) =>
    TravelDestination(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      currency: json['currency'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$TravelDestinationToJson(TravelDestination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'tags': instance.tags,
      'currency': instance.currency,
      'timezone': instance.timezone,
    };

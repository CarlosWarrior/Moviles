import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'food.dart';

class Cafeteria extends Equatable {
  final String? id;
  final String? title;
  final double? rating;
  final String? image;
  final String? description;
  final String? schedule;
  final double? lat;
  final double? lng;
  final List<Food>? foods;

  const Cafeteria({
    this.id,
    this.title,
    this.rating,
    this.image,
    this.description,
    this.schedule,
    this.lat,
    this.lng,
    this.foods,
  });

  factory Cafeteria.fromMap(Map<String, dynamic> data) => Cafeteria(
        id: data['id'] as String?,
        title: data['title'] as String?,
        rating: ( data['rating']  as num?)?.toDouble(),
        image: data['image'] as String?,
        description: data['description'] as String?,
        schedule: data['schedule'] as String?,
        lat: (data['lat'] as num?)?.toDouble(),
        lng: (data['lng'] as num?)?.toDouble(),
        foods: (data['foods'] as List<dynamic>?)
            ?.map((e) => Food.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'rating': rating,
        'image': image,
        'description': description,
        'schedule': schedule,
        'lat': lat,
        'lng': lng,
        'foods': foods?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Cafeteria].
  factory Cafeteria.fromJson(String data) {
    return Cafeteria.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Cafeteria] to a JSON string.
  String toJson() => json.encode(toMap());

  Cafeteria copyWith({
    String? id,
    String? title,
    double? rating,
    String? image,
    String? description,
    String? schedule,
    double? lat,
    double? lng,
    List<Food>? foods,
  }) {
    return Cafeteria(
      id: id ?? this.id,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      description: description ?? this.description,
      schedule: schedule ?? this.schedule,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      rating,
      image,
      description,
      schedule,
      lat,
      lng,
      foods,
    ];
  }
}

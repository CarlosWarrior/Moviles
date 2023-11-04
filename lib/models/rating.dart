import 'dart:convert';

import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String? id;
  final String? image;
  final double? taste;
  final double? price;
  final String? comment;
  final String? cafeteria;
  final String? food;

  const Rating({
    this.id,
    this.image,
    this.taste,
    this.price,
    this.comment,
    this.cafeteria,
    this.food,
  });

  factory Rating.fromMap(Map<String, dynamic> data) => Rating(
        id: data['id'] as String?,
        image: data['image'] as String?,
        taste: (data['taste'] as num?)?.toDouble(),
        price: (data['price'] as num?)?.toDouble(),
        comment: data['comment'] as String?,
        cafeteria: data['cafeteria'] as String?,
        food: data['food'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
        'taste': taste,
        'price': price,
        'comment': comment,
        'cafeteria': cafeteria,
        'food': food,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rating].
  factory Rating.fromJson(String data) {
    return Rating.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rating] to a JSON string.
  String toJson() => json.encode(toMap());

  Rating copyWith({
    String? id,
    String? image,
    double? taste,
    double? price,
    String? comment,
    String? cafeteria,
    String? food,
  }) {
    return Rating(
      id: id ?? this.id,
      image: image ?? this.image,
      taste: taste ?? this.taste,
      price: price ?? this.price,
      comment: comment ?? this.comment,
      cafeteria: cafeteria ?? this.cafeteria,
      food: food ?? this.food,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, taste, price, comment, cafeteria, food];
}

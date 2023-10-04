import 'dart:convert';

import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String? title;
  final double? price;
  final double? rating;

  const Food({this.title, this.price, this.rating});

  factory Food.fromMap(Map<String, dynamic> data) => Food(
        title: data['title'] as String?,
        price: data['price'] as double?,
        rating: data['rating'] as double?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'price': price,
        'rating': rating,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Food].
  factory Food.fromJson(String data) {
    return Food.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Food] to a JSON string.
  String toJson() => json.encode(toMap());

  Food copyWith({
    String? title,
    double? price,
    double? rating,
  }) {
    return Food(
      title: title ?? this.title,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object?> get props => [title, price, rating];
}

import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> data) => Genre(
        id: data['id'],
        name: data['name'],
      );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  List<Object> get props => [
        id,
        name,
      ];
}

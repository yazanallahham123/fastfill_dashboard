import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refill_source.g.dart';

@JsonSerializable()
class RefillSource extends Equatable{
  final int? id;
  final String? arabicName;
  final String? englishName;

  RefillSource({this.id, this.arabicName, this.englishName});

  factory RefillSource.fromJson(Map<String, dynamic> json) =>
      _$RefillSourceFromJson(json);

  Map<String, dynamic> toJson() => _$RefillSourceToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.arabicName, this.englishName];
}

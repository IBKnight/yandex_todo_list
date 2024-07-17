// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'importance_color_entity.freezed.dart';

@freezed
class ImportanceColorEntity with _$ImportanceColorEntity {
  @JsonSerializable(explicitToJson: true)
  const factory ImportanceColorEntity({
    required String? color,
  }) = _ImportanceColorEntity;
}

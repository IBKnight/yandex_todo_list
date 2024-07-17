// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'importance_color_model.freezed.dart';
part 'importance_color_model.g.dart';

@freezed
class ImportanceColorModel with _$ImportanceColorModel {
  @JsonSerializable(explicitToJson: true)
  const factory ImportanceColorModel({
    required String? color,

  }) = _ImportanceColorModel;

  factory ImportanceColorModel.fromJson(Map<String, Object?> json) =>
      _$ImportanceColorModelFromJson(json);
}

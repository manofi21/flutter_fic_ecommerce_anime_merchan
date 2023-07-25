import 'package:freezed_annotation/freezed_annotation.dart';

part 'option.freezed.dart';

@freezed
class Option<T> with _$Option<T> {
  factory Option.some(T value) = Some<T>;
  factory Option.none() = None<T>;
}
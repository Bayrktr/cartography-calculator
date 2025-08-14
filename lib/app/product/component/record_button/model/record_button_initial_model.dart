import 'package:equatable/equatable.dart';

class RecordButtonInitialModel with EquatableMixin {
  RecordButtonInitialModel({
    this.isListening = false,
  });

  final bool isListening;

  @override
  List<Object?> get props => [
        isListening,
      ];

  RecordButtonInitialModel copyWith({
    bool? isListening,
  }) =>
      RecordButtonInitialModel(
        isListening: isListening ?? this.isListening,
      );
}

abstract class GenericBaseModel<T, R> {
  Map<String, dynamic> toJson([Object? Function(R value)? toJsonT]);

  T fromJsonWithT(
      Map<String, dynamic> json,
      R Function(Object? json) fromJsonT,
      );

  T copyWith();
}

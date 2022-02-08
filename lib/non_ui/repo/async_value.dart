class AsyncValue<T> {
  T? value;
  Object? error;
  bool get hasError => error!=null;
  bool get hasValue => value!=null;
  AsyncValue([this.value]);

  factory AsyncValue.withValue(T value) => AsyncValue(value);

  factory AsyncValue.withError(Object error) => AsyncValue()..error = error;
}

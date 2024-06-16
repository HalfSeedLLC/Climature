import 'package:weather_app/constants/enum.dart';

class RequestStateWithValue<T> {
  const RequestStateWithValue({
    required this.requestState,
    required this.value,
  });

  final RequestState requestState;
  final T value;

  RequestStateWithValue<T> copyWith({
    RequestState? requestState,
    T? value,
  }) {
    return RequestStateWithValue(
      requestState: requestState ?? this.requestState,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'RequestStateWithValue{requestState: $requestState, value: $value}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestStateWithValue &&
        other.requestState == requestState &&
        other.value == value;
  }

  @override
  int get hashCode => requestState.hashCode ^ value.hashCode;
}

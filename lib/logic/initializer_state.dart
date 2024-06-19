part of 'initializer_cubit.dart';

class InitializerState extends Equatable {
  const InitializerState({
    this.isFirstLoad = false,
    this.requestState = RequestState.initial,
  });

  final bool isFirstLoad;
  final RequestState requestState;

  @override
  List<Object> get props => [isFirstLoad, requestState];

  InitializerState copyWith({
    bool? isFirstLoad,
    RequestState? requestState,
  }) {
    return InitializerState(
      isFirstLoad: isFirstLoad ?? this.isFirstLoad,
      requestState: requestState ?? this.requestState,
    );
  }
}

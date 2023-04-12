part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class IncrementCounter extends CounterEvent {
  final int counter;
  IncrementCounter({required this.counter});
}

class DecrementCounter extends CounterEvent {
  final int counter;
  DecrementCounter({required this.counter});
}

class IncrementTwiceCounter extends CounterEvent {
  final int counter;
  IncrementTwiceCounter({required this.counter});
}

class DecrementTwiceCounter extends CounterEvent {
  final int counter;
  DecrementTwiceCounter({required this.counter});
}

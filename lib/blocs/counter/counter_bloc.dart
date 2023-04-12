// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_megacom_final/repos/counter_repo.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({
    required this.repo,
  }) : super(CounterInitial()) {
    on<IncrementCounter>(
      (event, emit) async {
        int result = repo.increment(counter: event.counter);
        if (result >= 11) {
          emit(CounterError());
        } else {
          emit(CounterSuccess(counter: result));
        }
      },
    );

    on<DecrementCounter>(
      (event, emit) async {
        int result = repo.decrement(counter: event.counter);
        if (result <= -1) {
          emit(CounterError());
        } else {
          emit(CounterSuccess(counter: result));
        }
      },
    );

    on<IncrementTwiceCounter>(
      (event, emit) async {
        int result = repo.incrementTwice(counter: event.counter);
        if (result >= 11) {
          emit(CounterError());
        } else {
          emit(CounterSuccess(counter: result));
        }
      },
    );

    on<DecrementTwiceCounter>(
      (event, emit) async {
        int result = repo.decrementTwice(counter: event.counter);
        if (result <= -1) {
          emit(CounterError());
        } else {
          emit(CounterSuccess(counter: result));
        }
      },
    );
  }
  final CounterRepo repo;
}

class CounterRepo {
  int increment({required int counter}) {
    return counter + 1;
  }

  int decrement({required int counter}) {
    return counter - 1;
  }

  int incrementTwice({required int counter}) {
    return counter + 2;
  }

  int decrementTwice({required int counter}) {
    return counter - 2;
  }
}

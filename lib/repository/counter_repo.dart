class CounterRepo{
  int counter = 0;

  int increment() => counter+=1;

  int decrement() => counter-=1;
}
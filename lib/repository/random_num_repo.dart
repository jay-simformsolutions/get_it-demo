import 'dart:math';

class RandomNumberRepo{

  int value = 0;

  int setValue(int newValue){
    value = newValue;
    return value;
  }

  int getRandomNumberRepo(){
    return Random().nextInt(1000);
  }
}
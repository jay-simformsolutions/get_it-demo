class ShadowObject {
  int var1 = 0;
  int var2 = 0;
  int var3 = 0;
  int var4 = 0;

  void initializeFirstAndSecond() {
    var1 = 1;
    var2 = 2;
  }

  void initializeThirdAndFourth() {
    var3 = 3;
    var4 = 4;
  }

  @override
  String toString() {
    return "$var1 -> $var2 -> $var3 -> $var4";
  }
}

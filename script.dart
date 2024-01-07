void main() {
  fun1();
  fun2();
  fun3();
}

void fun1() {
  print('It\'s is me Fun1');
}

Future<void> fun2() async {
  print('1');
  await Future.delayed(const Duration(seconds: 5), () {
    print('Hey! wait for me');
  });
  print('It\'s is me Fun2');
}

void fun3() {
  print('It\'s is me Fun3');
}

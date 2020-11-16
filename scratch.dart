void main() {
  performTasks();
}

void performTasks() async {
  //task1();
  print(task2());
//  task3(task2Result);
}

Future<String> task2() async {
  Duration threeSeconds = Duration(seconds: 3);

  String result;

  await Future.delayed(threeSeconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;
}

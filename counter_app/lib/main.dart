import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(home: Home()));

class User {
  String name;
  int age;

  User({this.name, this.age});
}

class Controller extends GetxController {
  RxInt counter = 0.obs;
  increment() => counter++;
}

class Home extends StatelessWidget {
  @override
  final Controller c = Get.put(Controller());
  final user = User(age: 12, name: 'petar').obs;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Counter: ${c.counter} ')),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() =>
                Text('${user.value.name} is ${user.value.age} years old')),
            ElevatedButton(
              child: Text('Change Name'),
              onPressed: () => user.update((val) {
                val.name = "Stipe";
              }),
            ),
            ElevatedButton(
              child: Text('Go to next page'),
              onPressed: () => Get.to(Next()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => c.increment(),
      ),
    );
  }
}

class Next extends StatelessWidget {
  final Controller c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Obx(() => Text('${c.counter}')),
          ElevatedButton(
              onPressed: () => c.increment(), child: Text('increment')),
          ElevatedButton(onPressed: () => Get.back(), child: Text('back'))
        ],
      ),
    );
  }
}

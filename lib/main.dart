import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'car.dart';
import 'view_car.dart';

void main() {
  runApp(const MyApp());
}

Realm getRealmInstance() {
  final config = Configuration.local([Car.schema]);
  return Realm(config);
}

void createCar() {
  final realm = getRealmInstance();
  realm.write(() {
    realm.add(
      Car(
        'Mercedes',
        model: '2022',
      ),
    );
    print('Car added Successfully');
  });
}

void readCar() {
  final realm = getRealmInstance();
  final cars = realm.all<Car>();
  for (var car in cars) {
    print(car.toString()); // Print the car's details
  }
}

void updateCar() {
  final realm = getRealmInstance();
  realm.write(() {
    final cars = realm.query<Car>("make == 'Mercedes'");
    for (var car in cars) {
      car.model = '2023';
    }
    print('Car updated Successfully');
  });
}

void deleteCar() {
  final realm = getRealmInstance();
  realm.write(() {
    final cars = realm.all<Car>();
    for (var car in cars) {
      realm.delete(car);
    }
    print('Car removed Successfully');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEXT REALM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TEXT REALM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _createCar() {
    createCar();
  }

  void _readCar() {
    readCar();
  }

  void _updateCar() {
    updateCar();
  }

  void _deleteCar() {
    deleteCar();
  }

  void _viewHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ViewCarPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _createCar,
            backgroundColor: Colors.yellow,
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _readCar,
            backgroundColor: Colors.blue,
            tooltip: 'Read',
            child: const Icon(Icons.visibility),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _updateCar,
            backgroundColor: Colors.green,
            tooltip: 'Update',
            child: const Icon(Icons.update),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _deleteCar,
            backgroundColor: Colors.red,
            tooltip: 'Delete',
            child: const Icon(Icons.delete),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: _viewHistory,
            backgroundColor: Colors.orange,
            tooltip: 'View History',
            child: const Icon(Icons.bar_chart),
          ),
        ],
      ),
    );
  }
}

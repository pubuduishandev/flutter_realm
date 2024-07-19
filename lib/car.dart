import 'package:realm/realm.dart';

part 'car.realm.dart';

@RealmModel()
class _Car {   //private class
  late String make;
  String? model;

  @override
  String toString() {
    return 'Car(make: $make, model: $model)';
  }
}

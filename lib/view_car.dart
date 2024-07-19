import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'car.dart';

class ViewCarPage extends StatelessWidget {
  const ViewCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Configuration.local([Car.schema]);
    final realm = Realm(config);
    final cars = realm.all<Car>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Car Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Car Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: cars.isNotEmpty
                  ? DataTable(
                columns: const [
                  DataColumn(label: Text('Make')),
                  DataColumn(label: Text('Model')),
                ],
                rows: cars
                    .map(
                      (car) => DataRow(
                    cells: [
                      DataCell(Text(car.make)),
                      DataCell(Text(car.model ?? 'Unknown')),
                    ],
                  ),
                )
                    .toList(),
              )
                  : const Center(
                child: Text('No cars available.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  runApp(const TodayRidesApp());
}

class TodayRidesApp extends StatelessWidget {
  const TodayRidesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodayRidesScreen(),
    );
  }
}

class TodayRidesScreen extends StatelessWidget {
  const TodayRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get today's rides
    final today = DateTime.now();
    final allRides = RidesService.availableRides;
    final todayRides = allRides.where((ride) {
      return ride.departureDate.year == today.year &&
          ride.departureDate.month == today.month &&
          ride.departureDate.day == today.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Today\'s Rides')),
      body: todayRides.isEmpty
          ? const Center(child: Text('No rides today'))
          : ListView.builder(
              itemCount: todayRides.length,
              itemBuilder: (context, index) {
                final ride = todayRides[index];
                return ListTile(
                  title: Text(
                      '${ride.departureLocation.name} to ${ride.arrivalLocation.name}'),
                  subtitle: Text(
                      '${ride.departureDate.hour}:${ride.departureDate.minute.toString().padLeft(2, '0')} - ${ride.availableSeats} seats'),
                );
              },
            ),
    );
  }
}

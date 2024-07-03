import 'package:doctor_booking/Provider/BookingProvider.dart';
import 'package:doctor_booking/Provider/auth_provider.dart';
import 'package:doctor_booking/Provider/patient_provider.dart';
import 'package:doctor_booking/services/shared_prefernces.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/AddTreatment.dart';
import 'Screens/HomePage.dart';
import 'Screens/TBooking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await getSharedPreference();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(
            create: (_) => BookingProvider()..loadBookings()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Airbnb"),
        debugShowCheckedModeBanner: false,
        home: token != null
            ? TBooking()
            : FirstPage(), // Initial page when the app starts
        routes: {
          '/addTreatment': (context) => AddTreatment(),
          '/tbooking': (context) => TBooking(),
        },
      ),
    ),
  );
}

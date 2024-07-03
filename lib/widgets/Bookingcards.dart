import 'package:doctor_booking/models/PatientModel.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final Patient booking;

  const BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    String treatmentName = booking.patientdetailsSet != null &&
            booking.patientdetailsSet!.isNotEmpty
        ? booking.patientdetailsSet!.first.treatmentName ?? "Unknown Treatment"
        : "Unknown Treatment";

    return SingleChildScrollView(
      child: SafeArea(
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.name ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(treatmentName),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 4),
                    Text(booking.dateNdTime ?? ""),
                    SizedBox(width: 16),
                    Icon(Icons.person, size: 16),
                    SizedBox(width: 4),
                    Text(booking.name ?? ""),
                  ],
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('View Booking details'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

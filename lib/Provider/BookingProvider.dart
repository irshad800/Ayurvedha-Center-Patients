import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  String _selectedSortOption = 'Date';
  List<Booking> _bookings = [];

  String get selectedSortOption => _selectedSortOption;
  List<Booking> get bookings => _bookings;

  void setSelectedSortOption(String value) {
    _selectedSortOption = value;
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void loadBookings() {
    _bookings = [
      Booking(
        name: 'Vikram Singh',
        date: '31/01/2024',
        person: 'Jithesh',
        details: 'Couple Combo Package (Rejuvenation Therapy)',
      ),
      Booking(
        name: 'Vikram Singh',
        date: '31/01/2024',
        person: 'Jithesh',
        details: 'Couple Combo Package (Rejuvenation Therapy)',
      ),
      Booking(
        name: 'Vikram Singh',
        date: '31/01/2024',
        person: 'Jithesh',
        details: 'Couple Combo Package (Rejuvenation Therapy)',
      ),
    ];
    notifyListeners();
  }
}

class Booking {
  final String? name;
  final String? date;
  final String? person;
  final String? details;

  Booking({
    this.name,
    this.date,
    this.person,
    this.details,
  });
}

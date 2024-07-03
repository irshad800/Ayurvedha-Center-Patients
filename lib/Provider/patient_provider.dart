import 'package:doctor_booking/models/PatientModel.dart';
import 'package:doctor_booking/services/patient_services.dart';
import 'package:flutter/material.dart';

class Treatment {
  final String name;
  final int maleCount;
  final int femaleCount;

  Treatment(
      {required this.name, required this.maleCount, required this.femaleCount});
}

class PatientProvider extends ChangeNotifier {
  int maleCount = 0;
  int femaleCount = 0;
  List<Treatment> treatments = [];
  bool loading = false;
  String? selectedTreatment;
  PatientModel? patientList;

  void incrementMale() {
    maleCount++;
    notifyListeners();
  }

  void decrementMale() {
    if (maleCount > 0) {
      maleCount--;
      notifyListeners();
    }
  }

  void incrementFemale() {
    femaleCount++;
    notifyListeners();
  }

  void decrementFemale() {
    if (femaleCount > 0) {
      femaleCount--;
      notifyListeners();
    }
  }

  void addTreatment(Treatment treatment) {
    treatments.add(treatment);
    notifyListeners();
  }

  void removeTreatment(int index) {
    treatments.removeAt(index);
    notifyListeners();
  }

  Future<void> getPatient({required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();

      patientList = await getPatientService();
      print("Patient data fetched successfully");
      loading = false;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong')));
      loading = false;
      notifyListeners();
    }
  }
}

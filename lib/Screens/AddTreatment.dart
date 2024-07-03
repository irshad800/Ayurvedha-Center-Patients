import 'package:doctor_booking/Provider/patient_provider.dart';
import 'package:doctor_booking/widgets/CustomButtom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTreatment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Treatment', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(
                  child: Text('Treatment 1'), value: 'Treatment 1'),
              DropdownMenuItem(
                  child: Text('Treatment 2'), value: 'Treatment 2'),
            ],
            onChanged: (value) {
              Provider.of<PatientProvider>(context, listen: false)
                  .selectedTreatment = value;
            },
            decoration: InputDecoration(
              hintText: 'Choose preferred treatment',
              hintStyle: TextStyle(fontSize: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.grey[300],
            ),
          ),
          SizedBox(height: 16),
          Text('Add Patients', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('Male')),
              _buildCounter(context, 'male'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('Female')),
              _buildCounter(context, 'female'),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: CustomButton(
              onPressed: () {
                final provider =
                    Provider.of<PatientProvider>(context, listen: false);
                final treatment = Treatment(
                  name: provider.selectedTreatment ?? "",
                  maleCount: provider.maleCount,
                  femaleCount: provider.femaleCount,
                );
                provider.addTreatment(treatment);
                Navigator.of(context).pop();
              },
              name: "Save",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context, String type) {
    return Consumer<PatientProvider>(
      builder: (context, counter, child) {
        return Row(
          children: [
            IconButton(
              onPressed: type == 'male'
                  ? counter.decrementMale
                  : counter.decrementFemale,
              icon: Icon(Icons.remove, color: Colors.green),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  type == 'male'
                      ? counter.maleCount.toString()
                      : counter.femaleCount.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            IconButton(
              onPressed: type == 'male'
                  ? counter.incrementMale
                  : counter.incrementFemale,
              icon: Icon(Icons.add, color: Colors.green),
            ),
          ],
        );
      },
    );
  }
}

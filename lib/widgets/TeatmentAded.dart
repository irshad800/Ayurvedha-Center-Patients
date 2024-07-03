import 'package:doctor_booking/Provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddedTreatment extends StatelessWidget {
  const AddedTreatment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.treatments.length,
          itemBuilder: (context, index) {
            final treatment = provider.treatments[index];
            return Container(
              height: 100,
              width: 300,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Column(
                children: [
                  SizedBox(height: 1),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "${index + 1}.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          treatment.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          provider.removeTreatment(index);
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Male",
                        style: TextStyle(color: Colors.black),
                      ),
                      Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Text(treatment.maleCount.toString()),
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Colors.black),
                      ),
                      Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Text(treatment.femaleCount.toString()),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

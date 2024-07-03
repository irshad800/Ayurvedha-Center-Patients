import 'package:doctor_booking/Provider/patient_provider.dart';
import 'package:doctor_booking/Screens/RegisterScreen.dart';
import 'package:doctor_booking/services/patient_services.dart';
import 'package:doctor_booking/widgets/Bookingcards.dart';
import 'package:doctor_booking/widgets/CustomButtom.dart';
import 'package:doctor_booking/widgets/Custom_txtFeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TBooking extends StatefulWidget {
  @override
  State<TBooking> createState() => _TBookingState();
}

class _TBookingState extends State<TBooking> {
  String _sortBy = 'Date'; // Initial sort value

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PatientProvider>(context, listen: false).getPatient(
        context: context,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    //  if (patientProvider.patientList?.patient != null) {
    //   if (_sortBy == 'Date') {
    //     patientProvider.patientList!.patient!.sort((a, b) {
    //       DateTime dateA = DateTime.parse(a.treatmentDate!);
    //       DateTime dateB = DateTime.parse(b.treatmentDate!);
    //       return dateA.compareTo(dateB);
    //     });
    //   } else if (_sortBy == 'Name') {
    //     patientProvider.patientList!.patient!.sort((a, b) {
    //       return a.name!.compareTo(b.name!);
    //     });
    //   }
    // }

    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.bell),
            ),
          ),
        ),
        body: patientProvider.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: custom_textfeild(
                            hinText: "Search for treatments",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            name: "Search",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sort by:'),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton<String>(
                            value: _sortBy,
                            items: [
                              DropdownMenuItem(
                                value: 'Date',
                                child: Text('Date'),
                              ),
                              DropdownMenuItem(
                                value: 'Name',
                                child: Text('Name'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _sortBy = value!;
                              });
                            },
                            underline: SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(),
                  ),
                  SizedBox(height: 16),
                  if (patientProvider.patientList != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: ListView.builder(
                          itemCount:
                              patientProvider.patientList!.patient!.length,
                          itemBuilder: (context, index) {
                            final booking =
                                patientProvider.patientList!.patient![index];

                            return BookingCard(booking: booking);
                          },
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButton(
                      name: "Register Now",
                      onPressed: () {
                        getPatientService();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                      },
                    ),
                  ),
                ],
              ));
  }
}

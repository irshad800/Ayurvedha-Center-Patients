import 'dart:convert';

import 'package:doctor_booking/Screens/AddTreatment.dart';
import 'package:doctor_booking/Screens/pdf_generation_page.dart';
import 'package:doctor_booking/utils/constants.dart';
import 'package:doctor_booking/widgets/CustomButtom.dart';
import 'package:doctor_booking/widgets/Custom_txtFeild.dart';
import 'package:doctor_booking/widgets/TeatmentAded.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedHour;
  String? selectedMinute;
  String? _selectedPaymentMethod;
  String? selectedLocation;
  String? selectedBranch;

  List<String> hours =
      List.generate(24, (index) => index.toString().padLeft(2, '0'));
  List<String> minutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));
  List<String> locations = ["Kozhikode", "Kannur", "Vadakara"];
  List<String> branches = ["Branch 1", "Branch 2", "Branch 3"];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _whatsappController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _totalAmountController = TextEditingController();
  TextEditingController _discountController = TextEditingController();
  TextEditingController _advanceController = TextEditingController();
  TextEditingController _balanceController = TextEditingController();
  TextEditingController _treatmentDateController = TextEditingController();

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedPaymentMethod = value;
    });
  }

  Future<void> savePatient() async {
    var patientData = {
      'name': _nameController.text,
      'phone': _whatsappController.text,
      'address': _addressController.text,
      'totalAmount': int.tryParse(_totalAmountController.text) ?? 0,
      'discountAmount': int.tryParse(_discountController.text) ?? 0,
      'advanceAmount': int.tryParse(_advanceController.text) ?? 0,
      'balanceAmount': int.tryParse(_balanceController.text) ?? 0,
      'dateNdTime':
          "${_treatmentDateController.text} ${selectedHour}:${selectedMinute}",
      'branch': selectedBranch,
      'paymentMethod': _selectedPaymentMethod,
    };

    var apiUrl = Uri.parse('$baseUrl/addPatient');

    try {
      var response = await http.post(
        apiUrl,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODA2NDE3MDU1LCJpYXQiOjE3MjAwMTcwNTUsImp0aSI6IjBiOWRlYzA1ODhhYTQ1ZDM5MjMyOWQ2NmJmNzMwZmVmIiwidXNlcl9pZCI6MjF9.FnFwXz4Tt8wK77Vd9lJs4nEXSPfRKZQRpepxPj1tVrM',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(patientData),
      );

      if (response.statusCode == 200) {
        print('Patient data successfully posted!');
      } else {
        print('Failed to post patient data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error posting patient data: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _treatmentDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 25, fontFamily: "Airbnb"),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text("Name"),
                      custom_textfeild(
                        controller: _nameController,
                        hinText: "Enter Your Full name",
                      ),
                      SizedBox(height: 20),
                      Text("Whatsapp Number"),
                      custom_textfeild(
                        keyboardType: TextInputType.number,
                        hinText: "Enter Your Whatsapp Number",
                        controller: _whatsappController,
                      ),
                      SizedBox(height: 20),
                      Text("Address"),
                      custom_textfeild(
                        hinText: "Enter Your Full Address",
                        controller: _addressController,
                      ),
                      SizedBox(height: 20),
                      Text("Location"),
                      DropdownButtonFormField<String>(
                        value: selectedLocation,
                        hint: Text('Choose Your Location'),
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: locations.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedLocation = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Branch"),
                      DropdownButtonFormField<String>(
                        value: selectedBranch,
                        hint: Text('Select the Branch'),
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: branches.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedBranch = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Treatment"),
                      AddedTreatment(),
                      SizedBox(height: 10),
                      CustomButton(
                        name: "+Add Treatments",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[200],
                                actions: [AddTreatment()],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text("Total Amount"),
                      custom_textfeild(
                        keyboardType: TextInputType.number,
                        controller: _totalAmountController,
                      ),
                      SizedBox(height: 20),
                      Text("Discount Amount"),
                      custom_textfeild(
                        keyboardType: TextInputType.number,
                        controller: _discountController,
                      ),
                      SizedBox(height: 20),
                      Text("Payment Option"),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: Row(
                                  children: [
                                    Text(
                                      '',
                                    ),
                                  ],
                                ),
                                value: 'UPI',
                                groupValue: _selectedPaymentMethod,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: Row(
                                  children: [
                                    Text(''),
                                  ],
                                ),
                                value: 'Cash',
                                groupValue: _selectedPaymentMethod,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: Row(
                                  children: [
                                    Text(''),
                                  ],
                                ),
                                value: 'Card',
                                groupValue: _selectedPaymentMethod,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text("UPI"),
                          SizedBox(
                            width: 70,
                          ),
                          Text("card"),
                          SizedBox(
                            width: 70,
                          ),
                          Text("cash"),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Advance Amount"),
                      custom_textfeild(
                        keyboardType: TextInputType.number,
                        controller: _advanceController,
                      ),
                      SizedBox(height: 20),
                      Text("Balance Amount"),
                      custom_textfeild(
                        keyboardType: TextInputType.number,
                        controller: _balanceController,
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Treatment Date"),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _treatmentDateController,
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            decoration: InputDecoration(
                              hintText: 'Select Date',
                              suffixIcon: IconButton(
                                onPressed: () => _selectDate(context),
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Treatment Time"),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedHour,
                                  hint: Text('Hour'),
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  items: hours.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedHour = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedMinute,
                                  hint: Text('Minutes'),
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  items: minutes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedMinute = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                          child: CustomButton(
                        onPressed: () {
                          savePatient();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfGenerationPage(
                                      name: _nameController.text,
                                      address: _addressController.text,
                                      advanceAmount: int.tryParse(
                                              _advanceController.text) ??
                                          0,
                                      balanceAmount: int.tryParse(
                                              _balanceController.text) ??
                                          0,
                                      branch: selectedBranch ?? "",
                                      phone: _whatsappController.text,
                                      dateAndTime:
                                          _treatmentDateController.text,
                                      discountAmount: int.tryParse(
                                              _discountController.text) ??
                                          0,
                                      paymentMethod:
                                          _selectedPaymentMethod.toString(),
                                      totalAmount: int.tryParse(
                                              _totalAmountController.text) ??
                                          0,
                                    )),
                          );
                        },
                        name: "save",
                      )),
                      SizedBox(height: 20),
                    ],
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

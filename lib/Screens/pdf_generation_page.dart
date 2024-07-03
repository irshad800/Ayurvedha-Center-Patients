import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerationPage extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final int totalAmount;
  final int discountAmount;
  final int advanceAmount;
  final int balanceAmount;
  final String dateAndTime;
  final String branch;
  final String paymentMethod;

  PdfGenerationPage({
    required this.name,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    required this.branch,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate PDF'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _generatePdf(context);
          },
          child: Text('Generate PDF'),
        ),
      ),
    );
  }

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(
      (await rootBundle.load(
        'assets/images/Asset 1 2.png',
      ))
          .buffer
          .asUint8List(),
    );

    final image2 = pw.MemoryImage(
      (await rootBundle.load(
        'assets/images/Asset 1 3.png',
      ))
          .buffer
          .asUint8List(),
    );
    final image3 = pw.MemoryImage(
      (await rootBundle.load(
        'assets/images/Vector 1.png',
      ))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Centered background image
              pw.Positioned.fill(
                child: pw.Center(
                  child: pw.Opacity(
                    opacity: 0.3,
                    child: pw.Image(image2, fit: pw.BoxFit.cover),
                  ),
                ),
              ),
              // Content on top of the background image
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(image, height: 100),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('KUMARAKOM',
                              style: pw.TextStyle(
                                  fontSize: 24,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                              'Cheepunkal P.O. Kumarakom, Kottayam, Kerala - 686563'),
                          pw.Text('e-mail: unknown@gmail.com'),
                          pw.Text('Mob: +91 9876543210 | +91 9786543210'),
                          pw.Text('GST No: 32AABCU9603R1ZW'),
                        ],
                      ),
                    ],
                  ),
                  pw.Divider(),
                  pw.Text('Patient Details:',
                      style: pw.TextStyle(
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 20)),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Name: $name'),
                          pw.Text('Phone: $phone'),
                          pw.Text('Address: $address'),
                        ],
                      ),
                      pw.Text('Date and Time: $dateAndTime'),
                    ],
                  ),
                  pw.Divider(),
                  pw.Row(children: [
                    pw.Column(children: [
                      pw.Text("Treatment",
                          style: pw.TextStyle(
                              color: PdfColors.green,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 15)),
                    ]),
                    pw.SizedBox(
                      width: 75,
                    ),
                    pw.Column(children: [
                      pw.Text("Price",
                          style: pw.TextStyle(
                              color: PdfColors.green,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 15)),
                    ]),
                    pw.SizedBox(
                      width: 15,
                    ),
                    pw.Column(children: [
                      pw.Text("Male",
                          style: pw.TextStyle(
                              color: PdfColors.green,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 15)),
                    ]),
                    pw.SizedBox(
                      width: 15,
                    ),
                    pw.Column(children: [
                      pw.Text("Female",
                          style: pw.TextStyle(
                              color: PdfColors.green,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 15)),
                    ]),
                    pw.SizedBox(
                      width: 15,
                    ),
                    pw.Column(children: [
                      pw.Text("Male",
                          style: pw.TextStyle(
                              color: PdfColors.green,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 15)),
                    ]),
                    pw.SizedBox(
                      width: 15,
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text("Total",
                              style: pw.TextStyle(
                                  color: PdfColors.green,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 15)),
                        ],
                      ),
                    ),
                  ]),
                  pw.Divider(),
                  pw.SizedBox(height: 15),
                  pw.Text('Total Amount: ₹$totalAmount'),
                  pw.Text('Discount Amount: ₹$discountAmount'),
                  pw.Text('Advance Amount: ₹$advanceAmount'),
                  pw.Text('Balance Amount: ₹$balanceAmount'),
                  pw.Text("Thank you for choosing us",
                      style: pw.TextStyle(fontSize: 15)),
                  pw.Text(
                      "Your well-being is our commitment, and we're honored\nyou've entrusted us with your health journey"),
                  pw.Image(image2, fit: pw.BoxFit.cover)
                ],
              ),
              // Disclaimer at the bottom
              pw.Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: pw.Center(
                  child: pw.Text(
                    "Booking amount is non-refundable, and it's important to arrive on the allotted time for your treatment",
                    style: pw.TextStyle(
                      color: PdfColors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Patient_Registration_Report.pdf',
    );
  }
}

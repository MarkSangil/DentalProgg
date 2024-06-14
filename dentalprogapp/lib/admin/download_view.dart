import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DownloadViewPage extends StatefulWidget {
  final String uid;
  const DownloadViewPage({super.key, required this.uid});

  @override
  // ignore: library_private_types_in_public_api
  _DownloadViewPageState createState() => _DownloadViewPageState();
}

class _DownloadViewPageState extends State<DownloadViewPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? pdfPath;
  Uint8List? pdfBytes;
  String? tempPath;

  Future<void> _generatePDF() async {
    // Generate PDF
    final pdf = pw.Document();

    // Fetch user data
    final QuerySnapshot userQuerySnapshot = await _firestore
        .collection('users')
        .where('uid', isEqualTo: widget.uid)
        .get();
    final List<DocumentSnapshot> userDocuments = userQuerySnapshot.docs;

    // Load the logo image
    final Uint8List logoData =
        (await rootBundle.load('asset/logo.png')).buffer.asUint8List();
    final pw.MemoryImage logoImage = pw.MemoryImage(logoData);

    for (var userDoc in userDocuments) {
      // Create a list of user information
      List<List<String>> userData = [
        ['Name', 'Age', 'Contact', 'Address'],
        [
          userDoc['name'],
          userDoc['age'],
          userDoc['contact'],
          userDoc['address']
        ],
      ];

      // Fetch history data for the current user
      final QuerySnapshot historyQuerySnapshot = await _firestore
          .collection('transactions')
          .where('user_id', isEqualTo: widget.uid)
          .get();
      final List<DocumentSnapshot> historyDocuments = historyQuerySnapshot.docs;

      // Create a list of history data
      List<List<String>> historyData = [
        ['Payment', 'Status'],
        for (var historyDoc in historyDocuments)
          [historyDoc['paymentmethod'], historyDoc['selectedDentalServices']],
      ];

      // Add user information and history as a table
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Display the logo at the top
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 10.0),
                  child: pw.Image(logoImage),
                ),
                // Display user information table
                pw.Table.fromTextArray(
                  context: context,
                  data: userData,
                  border: pw.TableBorder.all(),
                  headerAlignment: pw.Alignment.center,
                  cellAlignment: pw.Alignment.center,
                  headerStyle: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  cellStyle: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
                // Add some space between tables
                pw.SizedBox(height: 20),
                // Display history table
                pw.Table.fromTextArray(
                  context: context,
                  data: historyData,
                  border: pw.TableBorder.all(),
                  headerAlignment: pw.Alignment.center,
                  cellAlignment: pw.Alignment.center,
                  headerStyle: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  cellStyle: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    // Convert PDF to bytes
    pdfBytes = await pdf.save();

    // Save PDF to file
    final tempDir = await getTemporaryDirectory();
    tempPath = '${tempDir.path}/data.pdf';
    final pdfFile = File(tempPath!);
    await pdfFile.writeAsBytes(pdfBytes!);

    setState(() {});
  }

  Future<void> _printPDF() async {
    if (pdfBytes == null) {
      await _generatePDF();
    }

    await Printing.sharePdf(bytes: pdfBytes!, filename: 'data.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Data Download'),
          actions: [
            IconButton(
              onPressed: _printPDF,
              icon: const Icon(Icons.print),
            ),
          ],
        ),
        body: Center(
          child: pdfBytes != null && tempPath != null && tempPath!.isNotEmpty
              ? PDFView(
                  filePath: tempPath!,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  pageSnap: false,
                  defaultPage: 0,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation: false,
                  onRender: (_) {},
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController controller) {},
                )
              : ElevatedButton(
                  onPressed: _generatePDF,
                  child: const Text('Generate PDF'),
                ),
        ),
      ),
    );
  }
}

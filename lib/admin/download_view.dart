import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';

class DownloadViewPage extends StatefulWidget {
  final String uid;
  const DownloadViewPage({Key? key, required this.uid}) : super(key: key);

  @override
  _DownloadViewPageState createState() => _DownloadViewPageState();
}

class _DownloadViewPageState extends State<DownloadViewPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? pdfPath;
  Uint8List? pdfBytes;
  String? tempPath;

  @override
  void initState() {
    super.initState();
    _generatePDF();
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    final QuerySnapshot userQuerySnapshot = await _firestore
        .collection('users')
        .where('uid', isEqualTo: widget.uid)
        .get();
    final List<DocumentSnapshot> userDocuments = userQuerySnapshot.docs;

    final Uint8List logoData = (await rootBundle.load('asset/logo.png')).buffer.asUint8List();
    final pw.MemoryImage logoImage = pw.MemoryImage(logoData);

    for (var userDoc in userDocuments) {
      List<List<String>> userData = [
        ['Name', 'Age', 'Contact', 'Address'],
        [
          userDoc['name'],
          userDoc['age'],
          userDoc['contact'],
          userDoc['address']
        ],
      ];

      final QuerySnapshot historyQuerySnapshot = await _firestore
          .collection('transactions')
          .where('user_id', isEqualTo: widget.uid)
          .get();
      final List<DocumentSnapshot> historyDocuments = historyQuerySnapshot.docs;

      List<List<String>> historyData = [
        ['Status'],
        for (var historyDoc in historyDocuments)
          [historyDoc['selectedDentalServices']],
      ];

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 10.0),
                  child: pw.Image(logoImage),
                ),
                pw.TableHelper.fromTextArray(
                  data: userData,
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  cellStyle: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  data: historyData,
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  cellStyle: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Signature', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              ],
            );
          },
        ),
      );
    }
    pdfBytes = await pdf.save();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pdfBytes != null && tempPath != null && tempPath!.isNotEmpty
                  ? Expanded(
                child: PDFView(
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
                  onError: (error) {},
                  onPageError: (page, error) {},
                  onViewCreated: (PDFViewController controller) {},
                ),
              )
                  : ElevatedButton(
                onPressed: _generatePDF,
                child: const Text('Generate PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

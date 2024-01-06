import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewPdf extends StatelessWidget {
  final pw.Document pdf;
  const PreviewPdf({required this.pdf, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (formate) => pdf.save(),
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: 'example.pdf',
      ),
    );
  }
}

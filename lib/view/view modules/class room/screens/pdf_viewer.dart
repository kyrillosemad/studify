import 'package:flutter/material.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final String url;

  const PdfViewerPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        url,
        enableDocumentLinkAnnotation: true,
      ),
    );
  }
}

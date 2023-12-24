import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

launchDataUrl(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (await launch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw Exception('Could not launch ');
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}

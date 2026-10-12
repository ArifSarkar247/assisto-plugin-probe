// Probe app: references each candidate plugin so it is compiled/linked in a
// release build. Not meant to run — just to prove the Android build is clean.
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:workmanager/workmanager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const ProbeApp());

class ProbeApp extends StatelessWidget {
  const ProbeApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: Scaffold(body: Center(child: Text('probe'))));
}

// Reference each plugin's API so tree-shaking keeps them.
Future<void> _refs() async {
  final picker = ImagePicker();
  await picker.pickImage(source: ImageSource.gallery);
  await Geolocator.getCurrentPosition();
  final stt = SpeechToText();
  await stt.initialize();
  await Workmanager().initialize((_) async => true);
  await Share.share('x');
  await launchUrl(Uri.parse('tel:123'));
}

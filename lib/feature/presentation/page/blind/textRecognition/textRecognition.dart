import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:open_eye/feature/presentation/common/flutterTTS/flutterTTS.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TextRecognition extends StatefulWidget
{
  static String routeName = "/textRecognition_screen";

  const TextRecognition({Key? key}) : super(key: key);

  @override
  State<TextRecognition> createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> with WidgetsBindingObserver {
  FlutterTts flutterTts = FlutterTts();
  bool _isPermissionGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final textRecognizer = TextRecognizer();
  stt.SpeechToText? _speech;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = _requestCameraPermission();
    _speech = stt.SpeechToText();
    _speak("you are in text recognition page please tap to know the text.");
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(child: CameraPreview(_cameraController!));
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            GestureDetector(
              onTap: ()=>_scanImage(),
              onDoubleTap: (){
                Navigator.of(context).pop();
                _stop();
                textRecognizer.close();
                _stopCamera();
              },
              child: Scaffold(
                backgroundColor: _isPermissionGranted ? Colors.transparent : null,
                body: _isPermissionGranted
                    ? Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                  ],
                )
                    : Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: const Text(
                      'Camera permission denied',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }
  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }
  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }
  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }
    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }
  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);
    if (!mounted) {
      return;
    }
    setState(() {});
  }
  Future<void> _scanImage() async {
    if (_cameraController == null) return;
    try {
      final pictureFile = await _cameraController!.takePicture();
      final file = File(pictureFile.path);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);
      _speak(recognizedText.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
  Future _speak(String text) async {
    await flutterTts.setLanguage("en_US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.speak(text);
  }
  Future _stop() async {
    await flutterTts.stop();
  }
}
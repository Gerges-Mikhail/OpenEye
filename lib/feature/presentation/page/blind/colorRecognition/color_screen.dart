import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/main.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({Key? key}) : super(key: key);
  static String routeName = "/color_screen";

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  CameraImage? _cameraImage;
  CameraController? _cameraController;
  String? output = '';
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
    _speak("you are in color detection screen please tap on screen to detect a color.");
  }
  @override
  void dispose() {
    _stopCamera();
    super.dispose();
  }

  loadCamera() {
    _cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    _cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          _cameraController!.startImageStream((imageStream) {
            _cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (_cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: _cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: _cameraImage!.height,
          imageWidth: _cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/ml/model_colorfinal.tflite", labels: "assets/ml/labels_color.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.pop(context);
                  _stopCamera();
                  _stop();
                },
                onTap: () {
                  speakOutput(output);
                },
                child: Container(
                  height: getProportionateScreenHeight(800),
                  width: double.infinity,
                  child: !_cameraController!.value.isInitialized
                      ? Container()
                      : AspectRatio(
                          aspectRatio: _cameraController!.value.aspectRatio,
                          child: CameraPreview(_cameraController!),
                        ),
                ),
              ),
              Text(
                output!,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(25),
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  speakOutput(String? output) {
    if (output == '0 White') {
      _speak("color is white");
      _stop();
    } else if (output == '1 Black') {
      _speak("color is black");
      _stop();
    } else if (output == '2 Green') {
      _speak("color is green");
      _stop();
    }else if (output == '3 Blue') {
      _speak("color is Blue");
      _stop();
    }else if (output == '4 Red') {
      _speak("color is red");
      _stop();
    }else if (output == '5 Yellow') {
      _speak("color is yellow");
      _stop();
    }
    else {
      _speak("Can't detect any color");
    }
  }
}

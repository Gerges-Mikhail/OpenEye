import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/main.dart';
import 'package:tflite/tflite.dart';

class CurrenciesScreen extends StatefulWidget {
  static String routeName = "/currencies_screen";

  @override
  State<CurrenciesScreen> createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  CameraImage? _cameraImage;
  CameraController? _cameraController;
  String? output = '';
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();

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
        model: "assets/ml/model_money.tflite", labels: "assets/ml/labels_money.txt");
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
                  stopCamera();
                  Navigator.pop(context);
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
  void stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }
  speakOutput(String? output) {
    if (output == '0 Five') {
      _speak("There is a five in front of you");
      _stop();
    } else if (output == '1 Ten') {
      _speak("There is a ten in front of you");
      _stop();
    } else if (output == '2 Twenty') {
      _speak("There is a Twenty in front of you");
      _stop();
    } else if (output == '3 Fifty') {
      _speak("There is a Fifty in front of you");
      _stop();
    }else if (output == '4 One Hundred') {
      _speak("There is a One Hundred in front of you");
      _stop();
    }
    else {
      _speak("Can't detect any money");
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

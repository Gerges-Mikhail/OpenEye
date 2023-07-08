import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_eye/feature/data/model/notesModel.dart';
import 'package:open_eye/feature/data/sqflite/sqflite.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
import 'package:open_eye/feature/presentation/common/size_config/size_config.dart';
import 'package:open_eye/feature/presentation/widget/dataNoteCard.dart';
import 'package:open_eye/feature/presentation/widget/textFormField/textFormField.dart';
import 'package:open_eye/feature/presentation/widget/avatarGlow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static String routeName = "/notes_screen";
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  FlutterTts flutterTts = FlutterTts();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();
  List<NoteModel> datas = [];
  bool fetching = true;
  String textFromFile = "";
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  stt.SpeechToText? _speech;
  late MyDatabase db;
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _noteController.dispose();
    _wordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterTts.speak("you are in notes page say hello for inquiries");
    db = MyDatabase();
    getData2();
    _speech = stt.SpeechToText();
  }

  void getData2() async {
    datas = await db.getNotesData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.of(context).pop();
          flutterTts.speak("go to the home page");
        },
        onTap: () {
          _listen();
          getData();
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CustomAvatarGlow(
                    isListening: _isListening,
                    press: () {
                      _listen();
                      getData();
                    },
                  ),
                ),
                Text(
                  'Title :',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: black,
                  ),
                ),
                CustomTextFormField(
                  labelText: '',
                  controller: _titleController,
                  maxLines: 1,
                  hintValue: "",
                  enabled: false,
                ),
                Text(
                  'Note :',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: black,
                  ),
                ),
                CustomTextFormField(
                  labelText: '',
                  controller: _noteController,
                  maxLines: 6,
                  hintValue: '',
                  enabled: false,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                fetching
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Flexible(
                  child: ListView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, i) {
                        return (i > 0 || i == 0)?
                        DataNoteCard(
                          index: i,
                          data: datas[i],
                        )
                            : Container();
                      }),
                ),
              ],
            ),
          ),
        ),
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

  void insertNote(){
    NoteModel dataLocal = NoteModel(
        title: _titleController.text,
        subtitle: _noteController.text);
    db.insertNotesData(dataLocal);
    dataLocal.id = datas[datas.length - 1].id! + 1;
    setState(() {
      datas.add(dataLocal);
    });
  }
  void deleteNote(int index) {
    db.deleteNotesData(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
  }


  getData() {
    setState(() {
      textFromFile = _text;
      _wordController.text = textFromFile;
    });
  }

  setIsListeningTrue() {
    setState(() => _isListening = true);
  }

  setIsListeningFalse() {
    setState(() => _isListening = false);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setIsListeningTrue();
        _speech!.listen(
          onResult: (val) {
            onResultDefault(val);
          },
        );
      }
    } else {
      setIsListeningFalse();
      _speech!.stop();
    }
  }

  onResultDefault(var val) {
    setState(() {
      _text = val.recognizedWords;
      getData();
      setIsListeningFalse();
      _speech!.stop();
      if (_wordController.text == 'hi' || _wordController.text == 'hello') {
        flutterTts.speak(
            'hello, say 00 or double click in bottom of screen to go to home page, zero one to set your note title, say zero two to set a description of note, say zero three to to save your note and hi For inquiries');
      } else if (_wordController.text == "Home page") {
      } else {
        controllerNumber(int.parse(_wordController.text));
      }
    });
  }

  onResultTitle(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _titleController.text = textFromFile;
        });
      },
    );
  }

  onResultNote(var val) {
    setState(
      () {
        _text = val.recognizedWords;
        getData();
        setIsListeningFalse();
        _speech!.stop();
        setState(() {
          textFromFile = _text;
          _noteController.text = textFromFile;
        });
      },
    );
  }

  void controllerNumber(int number) {
    if (number == 0) {
      Navigator.of(context).pop();
    } else if (number == 01) {
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultTitle(val));
    } else if (number == 02) {
      getData();
      setIsListeningTrue();
      _speech!.listen(
          listenFor: const Duration(milliseconds: 25000),
          partialResults: false,
          onResult: (val) => onResultNote(val));
    } else if (number == 03) {
      insertNote();
      _titleController.clear();
      _noteController.clear();
      _speak("save note successfully");
    } else if (number == 11) {
      _speak(
          " your title is ${datas[1].title} and your note is ${datas[1].subtitle}");
    }else if (number == 12) {
      deleteNote(1);
      _speak("note deleted");
    } else {
      _speak("please , say a valid number.");
    }
  }
}

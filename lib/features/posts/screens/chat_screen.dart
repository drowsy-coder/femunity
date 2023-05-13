import 'package:femunity/features/posts/screens/feature_box.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final speechToText = SpeechToText();
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sakhi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/sakhi.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20)
                    .copyWith(topLeft: const Radius.circular(0)),
              ),
              child: const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Hey! What's on your mind?",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                top: 8,
                left: 10,
              ),
              child: const Text(
                "Here are a few features",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'Share your feelings',
                  descriptionText:
                      "Talk and interact with non-judgmental ears.",
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: "headerText",
                  descriptionText: "descriptionText",
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: "headerText",
                  descriptionText: "descriptionText",
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}

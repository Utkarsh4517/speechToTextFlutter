import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  SpeechToText speechToText = SpeechToText();
  var text = "hold the button and start speaking";
  var isListening = false;
  var answer = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 60,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.pink,
        repeat: true, //
        repeatPauseDuration: const Duration(milliseconds: 100), //
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },
                  );
                });
                if (speechToText.isListening) {
                }
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: const CircleAvatar(
            radius: 30,
            child: Icon(Icons.mic),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Speech to Text'),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 170,
              ),
              const Text('Hold the mic and then say!'),
            ],
          )),
    );
  }
}
